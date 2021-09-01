
use std::ffi::{CString};
use std::os::raw::c_char;

use serde::{Serialize,Deserialize};
use bitcoin::network::constants::Network;


#[derive(Serialize,Deserialize,Debug,Clone)]
pub struct WalletConfig {
    pub deposit_desc: String,
    pub change_desc: String,
    pub node_address: String,
    pub network: Network,
}

impl WalletConfig{
  pub fn c_stringify(&self)->*mut c_char{
    let stringified = match serde_json::to_string(&self.clone()){
        Ok(result)=>result,
        Err(_)=>return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.").unwrap().into_raw()
    };

    CString::new(stringified).unwrap().into_raw()
  }

  pub fn default(deposit_desc: &str,network: Network)->Self{
    let change_desc = deposit_desc.replace("/0/*", "/1/*");
    let node_address = match network{
        Network::Bitcoin => "ssl://electrum.blockstream.info:50002",
        Network::Testnet => "ssl://electrum.blockstream.info:60002",
        _=>"ssl://electrum.blockstream.info:60002"
    };
    WalletConfig{
        deposit_desc: deposit_desc.to_string(),
        change_desc: change_desc,
        node_address: node_address.to_string(),
        network: network
    }

  }
}