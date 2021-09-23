use serde::{Serialize,Deserialize};
use std::ffi::{CString};
use std::os::raw::c_char;

use crate::e::{S5Error,ErrorKind};

use std::str::FromStr;

use bdk::descriptor::Segwitv0;
use bdk::descriptor::{Descriptor, Legacy, Miniscript};
use bdk::miniscript::policy::Concrete;
use bdk::Error;

#[derive(Serialize,Deserialize,Debug)]
pub struct WalletPolicy {
    pub policy: String,
    pub descriptor: String
}
impl WalletPolicy{
  pub fn c_stringify(&self)->*mut c_char{
    let stringified = match serde_json::to_string(self.clone()){
        Ok(result)=>result,
        Err(_)=>return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.").unwrap().into_raw()
    };

    CString::new(stringified).unwrap().into_raw()
  }
}

pub fn compile(
  policy: &str,
  script_type: &str,
) -> Result<WalletPolicy, S5Error> {
  let x_policy = match Concrete::<String>::from_str(policy){
    Ok(result)=>result,
    Err(_)=>return Err(S5Error::new(ErrorKind::OpError,"Extract-Policy"))
  };
  let legacy_policy: Miniscript<String, Legacy> = x_policy
      .compile()
      .map_err(|e| Error::Generic(e.to_string())).unwrap();
  let segwit_policy: Miniscript<String, Segwitv0> = x_policy
      .compile()
      .map_err(|e| Error::Generic(e.to_string())).unwrap();

  let descriptor = match script_type {
      "sh" => Descriptor::new_sh(legacy_policy),
      "wsh" => Descriptor::new_wsh(segwit_policy),
      "sh-wsh" => Descriptor::new_sh_wsh(segwit_policy),
      _ => return Err(S5Error::new(ErrorKind::OpError,"Invalid-Script-Type")),
  }
  .map_err(Error::Miniscript).unwrap();

  Ok(WalletPolicy{
    policy: policy.to_string(),
    descriptor: descriptor.to_string()
  })
}


#[cfg(test)]
mod tests {
  use super::*;
  use crate::wallet::address::{generate};
  use crate::wallet::config::{WalletConfig};
  use bitcoin::network::constants::Network;

  #[test]
  fn test_policies() {
    let user_xprv = "[db7d25b5/84'/1'/6']tprv8fWev2sCuSkVWYoNUUSEuqLkmmfiZaVtgxosS5jRE9fw5ejL2odsajv1QyiLrPri3ppgyta6dsFaoDVCF4ZdEAR6qqY4tnaosujsPzLxB49/0/*";
    let user_xpub = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe/0/*";
    let custodian = "[66a0c105/84'/1'/5']tpubDCKvnVh6U56wTSUEJGamQzdb3ByAc6gTPbjxXQqts5Bf1dBMopknipUUSmAV3UuihKPTddruSZCiqhyiYyhFWhz62SAGuC3PYmtAafUuG6R/0/*";
    let bailout_time = 525_600;
    // POLICIES
    let single_policy = format!("pk({})",user_xprv);
    let single_watchonly_policy = format!("pk({})",user_xpub);
    let raft_policy = format!("or(pk({}),and(pk({}),after({})))", user_xprv,custodian,bailout_time);

    //  DESCRIPTORS
    let raft_result_bech32 = compile(&raft_policy, "wsh").unwrap(); 
    let single_result_bech32 = compile(&single_policy, "wsh").unwrap(); 
    let single_watchonly_result_bech32 = compile(&single_watchonly_policy, "wsh").unwrap();

    // let raft_result_p2sh = compile(&raft_policy, "sh-wsh").unwrap(); 
    // let single_result_p2sh = compile(&single_policy, "sh-wsh").unwrap(); 
    // let single_watchonly_result_p2sh = compile(&single_watchonly_policy, "sh-wsh").unwrap();

    // let raft_result_legacy = compile(&raft_policy, "sh").unwrap(); 
    // let single_result_legacy = compile(&single_policy, "sh").unwrap(); 
    // let single_watchonly_result_legacy = compile(&single_watchonly_policy, "sh").unwrap();

    let expected_raft_bech32 = "wsh(or_d(pk([db7d25b5/84'/1'/6']tprv8fWev2sCuSkVWYoNUUSEuqLkmmfiZaVtgxosS5jRE9fw5ejL2odsajv1QyiLrPri3ppgyta6dsFaoDVCF4ZdEAR6qqY4tnaosujsPzLxB49/0/*),and_v(v:pk([66a0c105/84'/1'/5']tpubDCKvnVh6U56wTSUEJGamQzdb3ByAc6gTPbjxXQqts5Bf1dBMopknipUUSmAV3UuihKPTddruSZCiqhyiYyhFWhz62SAGuC3PYmtAafUuG6R/0/*),after(525600))))#q3uaemh2";
    assert_eq!(&raft_result_bech32.descriptor,expected_raft_bech32);
    let expected_single_bech32 = "wsh(pk([db7d25b5/84'/1'/6']tprv8fWev2sCuSkVWYoNUUSEuqLkmmfiZaVtgxosS5jRE9fw5ejL2odsajv1QyiLrPri3ppgyta6dsFaoDVCF4ZdEAR6qqY4tnaosujsPzLxB49/0/*))#amx4geaf";
    assert_eq!(&single_result_bech32.descriptor,expected_single_bech32);
    let expected_single_watchonly_bech32 = "wsh(pk([db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe/0/*))#2gagkcn9";
    assert_eq!(&single_watchonly_result_bech32.descriptor,expected_single_watchonly_bech32);

    // REMOVE CHECKSUM FROM DESCRIPTOR
    let raft_split = expected_raft_bech32.split("#").collect::<Vec<&str>>()[0];
    let single_split = expected_single_bech32.split("#").collect::<Vec<&str>>()[0];
    let watchonly_split = expected_single_watchonly_bech32.split("#").collect::<Vec<&str>>()[0];

    let raft_config: WalletConfig = WalletConfig::default(raft_split, Network::Testnet);
    let single_config: WalletConfig = WalletConfig::default(single_split, Network::Testnet);
    let watchonly_config: WalletConfig = WalletConfig::default(watchonly_split, Network::Testnet);

    let raft_bech32_address = generate(raft_config,0);
    let single_bech32_address = generate(single_config,0);
    let watchonly_bech32_address = generate(watchonly_config,0);

    println!("{:?}",raft_bech32_address);
    println!("{:?}",single_bech32_address);
    println!("{:?}",watchonly_bech32_address);
    
  }
}
