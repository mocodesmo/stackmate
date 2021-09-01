use crate::e::{ErrorKind,S5Error};

use std::ffi::{CString};
use std::os::raw::c_char;

use serde::{Serialize,Deserialize};

use secp256k1::rand::rngs::OsRng;
use secp256k1::Secp256k1;

use bip39::{Language, Mnemonic};
use bitcoin::network::constants::Network;

use bitcoin::util::bip32::ExtendedPrivKey;

#[derive(Serialize,Deserialize,Debug)]
pub struct MasterKey {
  pub fingerprint: String,
  pub mnemonic: String,
  pub xprv: String
}

impl MasterKey{
  pub fn c_stringify(&self)->*mut c_char{
    let stringified = match serde_json::to_string(self.clone()){
      Ok(result)=>result,
      Err(_)=>return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.").unwrap().into_raw()
    };

    CString::new(stringified).unwrap().into_raw()
  }
}

pub fn generate(
  length: usize,
  passphrase: &str,
  network: Network)->Result<MasterKey, S5Error>{
    let secp = Secp256k1::new();

    let length: usize = if length == 12 || length == 24 {
      length
    } else {
      24
    };
  
    let mut rng = match OsRng::new() {
      Ok(r) => r,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"OS-RNG")),
    };
  
    let mnemonic = match Mnemonic::generate_in_with(&mut rng, Language::English, length) {
      Ok(mne) => mne,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"Mnemonic-Generate")),
    };

    let mnemonic_struct = match Mnemonic::parse_in(Language::English, &mnemonic.to_string()) {
      Ok(mne) => mne,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"Mnemonic-Parse")),
    };
  
    let seed = mnemonic_struct.to_seed(passphrase);
  
    let master_xprv = match ExtendedPrivKey::new_master(network, &seed) {
      Ok(xprv) => xprv,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"MasterXprv-New")),
    };
  
    let fingerprint = master_xprv.fingerprint(&secp);

    Ok(MasterKey{
      fingerprint: fingerprint.to_string(),
      mnemonic: mnemonic.to_string(),
      xprv: master_xprv.to_string(),
    })
}

pub fn import(
  mnemonic: &str,
  passphrase: &str,
  network: Network)->Result<MasterKey, S5Error>{
    let secp = Secp256k1::new();
  
    let mnemonic_struct = match Mnemonic::parse_in(Language::English, mnemonic.to_string()) {
      Ok(mne) => mne,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"Mnemonic-Parse")),
    };
  
    let seed = mnemonic_struct.to_seed(passphrase);
  
    let master_xprv = match ExtendedPrivKey::new_master(network, &seed) {
      Ok(xprv) => xprv,
      Err(_) => return Err(S5Error::new(ErrorKind::OpError,"MasterXprv-New")),
    };
  
    let fingerprint = master_xprv.fingerprint(&secp);

    Ok(MasterKey{
      fingerprint: fingerprint.to_string(),
      mnemonic: mnemonic.to_string(),
      xprv: master_xprv.to_string(),
    })
}

#[cfg(test)]
mod tests {
  use super::*;
  #[test]
  fn test_key_ops(){
    let master_key = generate(9, "this should be okay", Network::Testnet).unwrap();
    assert_eq!(24,master_key.mnemonic.split_whitespace().collect::<Vec<&str>>().len());
    let master_key = generate(12, "this should be okay", Network::Testnet).unwrap();
    assert_eq!(12,master_key.mnemonic.split_whitespace().collect::<Vec<&str>>().len());
    let master_key = generate(29, "this should be okay", Network::Testnet).unwrap();
    assert_eq!(24,master_key.mnemonic.split_whitespace().collect::<Vec<&str>>().len());
    let imported_master_key = import(&master_key.mnemonic,"this should be okay",Network::Testnet).unwrap();
    assert_eq!(imported_master_key.xprv,master_key.xprv);
    assert_eq!(imported_master_key.fingerprint,master_key.fingerprint);
  }
}