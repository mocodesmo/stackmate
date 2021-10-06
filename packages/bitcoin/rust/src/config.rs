// use std::ffi::{CString};
// use std::os::raw::c_char;
use crate::e::{ErrorKind, S5Error};

use bdk::blockchain::electrum::ElectrumBlockchainConfig;
use bdk::blockchain::rpc::{wallet_name_from_descriptor, Auth, RpcConfig};
use bdk::blockchain::any::{AnyBlockchain,AnyBlockchainConfig};
use bdk::blockchain::{ConfigurableBlockchain,ElectrumBlockchain, RpcBlockchain};


use bitcoin::network::constants::Network;
// use serde::{Deserialize, Serialize};

use secp256k1::Secp256k1;
/**
 * I am trying to create a user interface where the blockchain backend can be selected at runtime.
 * I have created a generaized WalletConfig that contains all inputs required by bdk::wallet functions which gets populated by user input.
 * Im not sure how define the type for node_config. In TS the equivalent would be node_config: RpcConfig | ElectrumBlockchainConfig
 * 
 */

pub struct WalletConfig {
  pub deposit_desc: String,
  pub change_desc: String,
  pub network: Network,
  pub client: AnyBlockchain,
}

pub const DEFAULT: &str = "default";
pub const DEFAULT_TESTNET_NODE: &str = "ssl://electrum.blockstream.info:60002";
pub const DEFAULT_MAINNET_NODE  : &str = "ssl://electrum.blockstream.info:50002";

impl WalletConfig {

  pub fn default(
    deposit_desc: &str,
    node_address: &str,
  ) -> Result<Self, S5Error> {
    let change_desc: &str = &deposit_desc.replace("/0/*", "/1/*");
    let network = if deposit_desc.clone().contains("xpub") || deposit_desc.clone().contains("xprv") {
      Network::Bitcoin
    } else {
      Network::Testnet
    };
    
    let node_address = if node_address.contains(DEFAULT){
      let address = match network{
        Network::Bitcoin=>DEFAULT_MAINNET_NODE,
        _=>DEFAULT_TESTNET_NODE
      };
      address
    }
    else{
      node_address
    };

    if node_address.contains("electrum") {
      let config = ElectrumBlockchainConfig {
        url: node_address.to_string(),
        socks5: None,
        retry: 1,
        timeout: Some(5),
        stop_gap: 1000,
      };
      let client = create_blockchain_client(AnyBlockchainConfig::Electrum(config)).unwrap();
      Ok(WalletConfig {
        deposit_desc: deposit_desc.to_string(),
        change_desc: change_desc.to_string(),
        network: network,
        client: client,
      })
    } else if node_address.contains("http") {
      let parts: Vec<&str> = node_address.split("/").collect();
      let auth = if parts[1] == "" {
        Auth::None
      } else {
        Auth::UserPass {
          username: parts[1].split(":").collect::<Vec<&str>>()[0].to_string(),
          password: parts[1].split(":").collect::<Vec<&str>>()[1].to_string(),
        }
      };
      let wallet_name = match wallet_name_from_descriptor(
        deposit_desc,
        Some(change_desc),
        network,
        &Secp256k1::new(),
      ) {
        Ok(name) => name,
        Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Config-RPC-Wallet-Name")),
      };
     
      let config = RpcConfig {
        url: parts[0].to_string(),
        auth: auth,
        network: network,
        wallet_name: wallet_name,
        skip_blocks: None,
      };
      let client = create_blockchain_client(AnyBlockchainConfig::Rpc(config)).unwrap();

      Ok(WalletConfig {
        deposit_desc: deposit_desc.to_string(),
        change_desc: change_desc.to_string(),
        network: network,
        client:client
      })
    }
    else{
      Err(S5Error::new(ErrorKind::OpError, "Node-Address-String"))
    }
    
  }
}

pub fn create_blockchain_client(config: AnyBlockchainConfig)->Result<AnyBlockchain,S5Error>{
  match config{
    AnyBlockchainConfig::Electrum(econf)=>{ 
      let client = match ElectrumBlockchain::from_config(&econf) {
        Ok(result) => result,
        Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Electrum-Node-Connection")),
      };
      Ok(AnyBlockchain::Electrum(client))
    }
    AnyBlockchainConfig::Rpc(econf)=>{ 
      let client = match RpcBlockchain::from_config(&econf) {
        Ok(result) => result,
        Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Core-Rpc-Node-Connection")),
      };
      Ok(AnyBlockchain::Rpc(client))
    }
    _=>return Err(S5Error::new(ErrorKind::OpError, "Blockchain-Type-Not-Supported"))
  }
}

#[cfg(test)]
mod tests {
  use super::*;
  use crate::config::WalletConfig;
  use bitcoin::network::constants::Network;
  use bdk::blockchain::Blockchain;
  #[test]
  fn test_default_electrum_config() {
    let xkey = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe";
    let deposit_desc = format!("wpkh({}/0/*)", xkey);

    let config = WalletConfig::default(&deposit_desc,DEFAULT_TESTNET_NODE).unwrap();
    match config.client{
      AnyBlockchain::Electrum(client)=>{
        let height = client.get_height().unwrap();
        println!("{:#?}",height);
        assert_eq!((height>2097921),true);
      },
      _=>println!("Should not reach.")
    };

    let change_desc = format!("wpkh({}/1/*)", xkey);
    let network = Network::Testnet;
    assert_eq!(config.change_desc,change_desc);
    assert_eq!(config.network,network);

  }

  #[test] #[ignore]
  fn test_local_core_config() {
    println!("Connect a local node and then remove ignore macro.")
  }
}
