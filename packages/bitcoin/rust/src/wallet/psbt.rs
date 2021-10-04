use serde::{Deserialize, Serialize};
use std::ffi::CString;
use std::os::raw::c_char;

use crate::e::{ErrorKind, S5Error};
use crate::wallet::config::{WalletConfig};
use bdk::electrum_client::Client;
use bdk::{Wallet,SignOptions};
use bitcoin::util::address::Address;
use bdk::FeeRate;

use bdk::database::MemoryDatabase;
use bdk::blockchain::{ElectrumBlockchain};
use bdk::blockchain::noop_progress;
use std::str::FromStr;
use bitcoin::util::psbt::PartiallySignedTransaction;
use bitcoin::consensus::deserialize;
use bitcoin::consensus::serialize;
use bitcoin::network::constants::Network;

use bdk::Error;

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct WalletPSBT {
  pub psbt: String,
  pub is_finalized: bool,
}

// impl Clone for WalletPSBT {
//     fn clone(&self) -> WalletPSBT {
//         self
//     }
// }
impl WalletPSBT {
  pub fn c_stringify(&self) -> *mut c_char {
    let stringified = match serde_json::to_string(&self.clone()) {
      Ok(result) => result,
      Err(_) => {
        return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.")
          .unwrap()
          .into_raw()
      }
    };

    CString::new(stringified).unwrap().into_raw()
  }
}

pub fn build(config: WalletConfig, to: &str, amount: u64, fee_rate: f32) -> Result<WalletPSBT, S5Error> {
  let client = match Client::new(&config.node_address) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Node-Address-Connection")),
  };

  let wallet = match Wallet::new(
    &config.deposit_desc,
    Some(&config.change_desc),
    config.network,
    MemoryDatabase::default(),
    ElectrumBlockchain::from(client),
  ) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Initialization")),
  };

  match wallet.sync(noop_progress(), None) {
    Ok(_) => (),
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Sync")),
  };

  let send_to = match Address::from_str(to){
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Address-Parse")),
  };

  let (psbt, details) = {
    let mut builder = wallet.build_tx();
    
    builder
      .add_recipient(send_to.script_pubkey(), amount)
      .enable_rbf()
      .do_not_spend_change()
      .fee_rate(FeeRate::from_sat_per_vb(fee_rate));
    
    match builder.finish(){
      Ok(result)=>result,
      Err(e)=>{
        println!("{:?}", e);
        return Err(S5Error::new(ErrorKind::OpError, "Transaction-Build"))
      },
    }
  };

  println!("Transaction details: {:#?}", details);
  println!("Unsigned PSBT: {}", &psbt);

  Ok(WalletPSBT{
    psbt: psbt.to_string(),
    is_finalized: false,
  })
}

#[derive(Serialize,Debug,Clone)]
pub struct DecodedTxOutput{
    value: u64,
    to: String,
}

pub fn decode(network: Network, psbt: &str) -> Result<Vec<DecodedTxOutput>, S5Error> {
  
    let decoded_psbt = match base64::decode(psbt){
        Ok(psbt)=> psbt,
        Err(_)=>return Err(S5Error::new(ErrorKind::OpError, "Basae64-Decode"))
    };

    let psbt_struct: PartiallySignedTransaction = match deserialize(&decoded_psbt){
            Ok(psbt)=>psbt,
            Err(_)=>return Err(S5Error::new(ErrorKind::OpError, "Deserialize-Error"))
    };
    // println!("{:#?}", &psbt_struct);

    
    let outputs = &psbt_struct.global.unsigned_tx.output;
    // println!("{:#?}", &outputs);
    // println!("{:#?}", Address::from_script(&outputs[0].clone().script_pubkey,network_enum));
    let inputs = &psbt_struct.inputs;

    let mut decoded_outputs: Vec<DecodedTxOutput> = vec![];
    let mut total_out_value = 0;
    let mut total_in_value = 0;

    for output in outputs{
        total_out_value += output.value;
        decoded_outputs.push(DecodedTxOutput{
            value: output.value,
            to: match Address::from_script(&output.script_pubkey,network){
                Some(address)=>address.to_string(),
                None=>"None".to_string()
            }
        });
    }
    for input in inputs{
      println!("{:#?}",input.bip32_derivation);

        total_in_value += input.witness_utxo.clone().unwrap().value;
      
    }
    decoded_outputs.push(DecodedTxOutput{
        value: total_in_value-total_out_value,
        to: "miner".to_string()
    });
    Ok(decoded_outputs)

}

pub fn sign(config: WalletConfig, psbt: &str) -> Result<WalletPSBT, S5Error> {
  let client = match Client::new(&config.node_address) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Node-Address-Connection")),
  };

  let wallet = match Wallet::new_offline(
    &config.deposit_desc,
    Some(&config.change_desc),
    config.network,
    MemoryDatabase::default(),
  ) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Initialization")),
  };

  let mut final_psbt = match deserialize(&base64::decode(psbt).unwrap()){
    Ok(psbt)=>psbt,
    Err(_)=>return Err(S5Error::new(ErrorKind::OpError, "Deserialize-Psbt-Error"))
  };

  let finalized = match wallet.sign(&mut final_psbt, SignOptions::default()){
    Ok(result)=>result,
    Err(_)=>return Err(S5Error::new(ErrorKind::OpError, "Sign-Error"))
  };

  Ok(WalletPSBT{
    psbt: final_psbt.to_string(),
    is_finalized: finalized,
  })
}

#[derive(Serialize, Deserialize, Debug,Clone)]
pub struct Txid {
  pub txid: String,
}
impl Txid {
  pub fn c_stringify(&self) -> *mut c_char {
    let stringified = match serde_json::to_string(&self.clone()) {
      Ok(result) => result,
      Err(_) => {
        return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.")
          .unwrap()
          .into_raw()
      }
    };

    CString::new(stringified).unwrap().into_raw()
  }
}

pub fn broadcast(config: WalletConfig, psbt: &str) -> Result<Txid, S5Error> {
  let client = match Client::new(&config.node_address) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Node-Address-Connection")),
  };

  let wallet = match Wallet::new(
    &config.deposit_desc,
    Some(&config.change_desc),
    config.network,
    MemoryDatabase::default(),
    ElectrumBlockchain::from(client),
  ) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Initialization")),
  };

  match wallet.sync(noop_progress(), None) {
    Ok(_) => (),
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Sync")),
  };

  let decoded_psbt = match base64::decode(&psbt){
    Ok(result) => result,
    Err(_)=> return Err(S5Error::new(ErrorKind::OpError, "PSBT-Decode"))
  };
  let psbt_struct: PartiallySignedTransaction = match deserialize(&decoded_psbt){
    Ok(result)=> result,
    Err(_)=> return Err(S5Error::new(ErrorKind::OpError, "PSBT-Deserialize")),
  };
  let tx = psbt_struct.extract_tx();
  
  let txid = wallet.broadcast(tx).unwrap();

  Ok(Txid { txid: txid.to_string() })
}

#[cfg(test)]
mod tests {
  use super::*;
  use crate::wallet::config::WalletConfig;
  use bitcoin::network::constants::Network;

  #[test]
  fn test_send() {
    let xkey = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe";
    let deposit_desc = format!("wpkh({}/0/*)", xkey);
    let change_desc = format!("wpkh({}/1/*)", xkey);
    let network = Network::Testnet;
    let node_address = "ssl://electrum.blockstream.info:60002";

    let config = WalletConfig {
      deposit_desc: deposit_desc, 
      change_desc: change_desc, 
      network:network, 
      node_address:node_address.to_string()
    };

    let xkey = "[db7d25b5/84'/1'/6']tprv8fWev2sCuSkVWYoNUUSEuqLkmmfiZaVtgxosS5jRE9fw5ejL2odsajv1QyiLrPri3ppgyta6dsFaoDVCF4ZdEAR6qqY4tnaosujsPzLxB49";
    let deposit_desc = format!("wpkh({}/0/*)", xkey);
    let change_desc = format!("wpkh({}/1/*)", xkey);


    let sign_config = WalletConfig {
      deposit_desc: deposit_desc, 
      change_desc: change_desc, 
      network:network, 
      node_address:node_address.to_string()
    };

    let to = "mkHS9ne12qx9pS9VojpwU5xtRd4T7X7ZUt";
    let amount = 5000;
    let fee_rate = 1.0;

    let psbt_origin = build(config.clone(), to, amount, fee_rate);
    println!("{:#?}",psbt_origin);
    let decoded = decode(Network::Testnet, &psbt_origin.clone().unwrap().psbt);
    println!("{:#?}",decoded.clone().unwrap());
    // assert_eq!(decoded.unwrap()[0].value, amount);
    let signed = sign(sign_config, &psbt_origin.unwrap().psbt);
    println!("{:#?}",signed.clone().unwrap());
    assert_eq!(signed.clone().unwrap().is_finalized, true);
    // let broadcasted = broadcast(config, &signed.unwrap().psbt);
    // println!("{:#?}",broadcasted.clone().unwrap());
    // assert_eq!(broadcasted.clone().unwrap().txid.len(), 64);

  }
}
