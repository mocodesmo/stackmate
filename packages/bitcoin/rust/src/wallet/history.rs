use crate::e::{ErrorKind, S5Error};
use crate::wallet::config::WalletConfig;

use std::ffi::CString;
use std::os::raw::c_char;

use serde::{Deserialize, Serialize};

use bitcoin::network::constants::Network;

use bdk::blockchain::{noop_progress, ElectrumBlockchain};
use bdk::database::MemoryDatabase;
use bdk::electrum_client::Client;
use bdk::TransactionDetails;
use bdk::Wallet;

/**
*   "fees": 153,
   "height": 2062130,
   "received": 100000,
   "sent": 0,
   "timestamp": 0,
   "transaction": null,
   "txid"
*/

#[derive(Serialize, Deserialize, Debug)]
pub struct WalletHistory {
  pub timestamp: u64,
  pub height: u32,
  pub verified: bool,
  pub txid: String,
  pub received: u64,
  pub sent: u64,
  pub fee: u64,
}

impl WalletHistory {
  pub fn c_stringify(&self) -> *mut c_char {
    let stringified = match serde_json::to_string(self.clone()) {
      Ok(result) => result,
      Err(_) => {
        return CString::new("Error:JSON Stringify Failed. BAD NEWS! Contact Support.")
          .unwrap()
          .into_raw()
      }
    };

    CString::new(stringified).unwrap().into_raw()
  }
  pub fn from_txdetail(txdetail: TransactionDetails) -> Self {
    WalletHistory {
      timestamp: match txdetail.confirmation_time.clone() {
        Some(time) => time.timestamp,
        None => 0,
      },
      height: match txdetail.confirmation_time {
        Some(time) => time.height,
        None => 0,
      },
      verified: txdetail.verified,
      txid: txdetail.txid.to_string(),
      received: txdetail.received,
      sent: txdetail.sent,
      fee: match txdetail.fee {
        Some(fee) => fee,
        None => 0,
      },
    }
  }
}

pub fn sync_history(config: WalletConfig) -> Result<Vec<WalletHistory>, S5Error> {
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

  match wallet.list_transactions(false) {
    Ok(history) => {
      return Ok(
        history
          .iter()
          .map(|txdetail| WalletHistory::from_txdetail(txdetail.clone()))
          .collect(),
      )
    }
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-History")),
  }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct WalletBalance {
  pub balance: u64,
}
impl WalletBalance {
  pub fn c_stringify(&self) -> *mut c_char {
    let stringified = match serde_json::to_string(self.clone()) {
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

pub fn sync_balance(config: WalletConfig) -> Result<WalletBalance, S5Error> {
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

  match wallet.get_balance() {
    Ok(balance) => return Ok(WalletBalance { balance: balance }),
    Err(_) => return Err(S5Error::new(ErrorKind::OpError, "Wallet-Balance")),
  }
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  fn test_balance() {
    let xkey = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe";
    let deposit_desc = format!("wsh(pk({}/0/*))", xkey);
    let network = Network::Testnet;
    let config = WalletConfig::default(&deposit_desc, network);

    let balance = sync_balance(config).unwrap();
    assert_eq!(balance.balance, 10_000)
  }
  #[test]
  fn test_history() {
    let xkey = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe";
    let deposit_desc = format!("wsh(pk({}/0/*))", xkey);
    let network = Network::Testnet;
    let config = WalletConfig::default(&deposit_desc, network);
    let history = sync_history(config).unwrap();
    // println!("{:#?}",history);
    assert_eq!(10_000, history[0].received);
    assert_eq!(
      "ae6275ff3f667e89ea9500e216de8796d413b89ca47ced8fd039c884587f1c8e",
      &history[0].txid
    )
  }
}
