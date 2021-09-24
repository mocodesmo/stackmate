use crate::e::{S5Error,ErrorKind};

use std::ffi::{CString};
use std::os::raw::c_char;

use serde::{Serialize,Deserialize};

use bdk::electrum_client::Client;
use bdk::blockchain::{Blockchain};
use bdk::blockchain::electrum::{ElectrumBlockchain};

#[derive(Serialize,Deserialize,Debug)]
pub struct NetworkFee {
    pub fee: f32,
}
impl NetworkFee{
  pub fn c_stringify(&self)->*mut c_char{
    let stringified = match serde_json::to_string(self.clone()){
        Ok(result)=>result,
        Err(_)=>return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.").unwrap().into_raw()
    };

    CString::new(stringified).unwrap().into_raw()
  }
}

pub fn estimate_sats_per_byte(node_address: &str, target: usize)->Result<NetworkFee, S5Error>{
  let client = match Client::new(node_address) {
    Ok(result) => result,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError,"Node-Address-Connection"))
  };    
  let blockchain:ElectrumBlockchain = ElectrumBlockchain::from(client);
  let fee = blockchain.estimate_fee(target).unwrap();
    Ok(NetworkFee{
      fee: fee.as_sat_vb()
    })
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_estimate_fee() {
    let node_address = "ssl://electrum.blockstream.info:50002"; // mainnet port used
    let network_fee = estimate_sats_per_byte(node_address,1).unwrap();
    println!("{:#?}",network_fee);
  }

}