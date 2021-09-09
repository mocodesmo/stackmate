/*
Developed by Stackmate India in 2021.
*/

use std::ffi::{CStr, CString};
use std::os::raw::c_char;
use std::str;

use bitcoin::network::constants::Network;

mod e;

mod key;
use crate::key::child;
use crate::key::master;

mod wallet;
use crate::wallet::address;
use crate::wallet::config::WalletConfig;
use crate::wallet::history;
use crate::wallet::policy;

mod network;
use crate::network::fees;
use crate::network::height;

use e::{ErrorKind, S5Error};

#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn generate_master(
    length: *const c_char,
    passphrase: *const c_char,
    network: *const c_char,
) -> *mut c_char {
    let input_cstr = unsafe { CStr::from_ptr(length) };
    let length: usize = match input_cstr.to_str() {
        Err(_) => 24,
        Ok(string) => match string.parse::<usize>() {
            Ok(l) => {
                if l == 12 || l == 24 {
                    l
                } else {
                    24
                }
            }
            Err(_) => 24,
        },
    };

    let passphrase_cstr = unsafe { CStr::from_ptr(passphrase) };
    let passphrase: &str = match passphrase_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "",
    };

    let network_cstr = unsafe { CStr::from_ptr(network) };
    let network_str: &str = match network_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "test",
    };
    let network = match network_str {
        "main" => Network::Bitcoin,
        "test" => Network::Testnet,
        _ => Network::Testnet,
    };

    match master::generate(length, passphrase, network) {
        Ok(master_key) => return master_key.c_stringify(),
        Err(e) => return e.c_stringify(),
    }
}
#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn import_master(
    mnemonic: *const c_char,
    passphrase: *const c_char,
    network: *const c_char,
) -> *mut c_char {
    let input_cstr = unsafe { CStr::from_ptr(mnemonic) };
    let mnemonic: &str = match input_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => return S5Error::new(ErrorKind::InputError, "Mnemonic").c_stringify(),
    };

    let passphrase_cstr = unsafe { CStr::from_ptr(passphrase) };
    let passphrase: &str = match passphrase_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "",
    };

    let network_cstr = unsafe { CStr::from_ptr(network) };
    let network_str: &str = match network_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "test",
    };
    let network = match network_str {
        "main" => Network::Bitcoin,
        "test" => Network::Testnet,
        _ => Network::Testnet,
    };

    match master::import(mnemonic, passphrase, network) {
        Ok(master_key) => return master_key.c_stringify(),
        Err(e) => return e.c_stringify(),
    }
}

#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn derive_hardened(
    master_xprv: *const c_char,
    purpose: *const c_char,
    account: *const c_char,
) -> *mut c_char {
    let master_xprv_cstr = unsafe { CStr::from_ptr(master_xprv) };
    let master_xprv: &str = match master_xprv_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => return S5Error::new(ErrorKind::InputError, "Master-Xprv").c_stringify(),
    };

    let purpose_cstr = unsafe { CStr::from_ptr(purpose) };
    let purpose: &str = match purpose_cstr.to_str() {
        Ok(string) => match string.parse::<usize>() {
            Ok(_) => string,
            Err(_) => "84",
        },
        Err(_) => "84",
    };

    let account_cstr = unsafe { CStr::from_ptr(account) };
    let account: &str = match account_cstr.to_str() {
        Ok(string) => match string.parse::<usize>() {
            Ok(_) => string,
            Err(_) => "0",
        },
        Err(_) => "0",
    };

    match child::derive(master_xprv, purpose, account) {
        Ok(result) => return result.c_stringify(),
        Err(e) => return e.c_stringify(),
    };
}

#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn compile(policy: *const c_char, script_type: *const c_char) -> *mut c_char {
    let policy_cstr = unsafe { CStr::from_ptr(policy) };
    let policy_str: &str = match policy_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => return S5Error::new(ErrorKind::InputError, "Policy").c_stringify(),
    };

    let script_type_cstr = unsafe { CStr::from_ptr(script_type) };
    let script_type_str: &str = match script_type_cstr.to_str() {
        Ok(string) => match string.parse::<usize>() {
            Ok(_) => string,
            Err(_) => "wsh",
        },
        Err(_) => "wsh",
    };

    match policy::compile(policy_str, script_type_str) {
        Ok(result) => return result.c_stringify(),
        Err(e) => return e.c_stringify(),
    };
}

#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn sync_balance(
    deposit_desc: *const c_char,
    network: *const c_char,
) -> *mut c_char {
    let deposit_desc_cstr = unsafe { CStr::from_ptr(deposit_desc) };
    let deposit_desc: &str = match deposit_desc_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => return S5Error::new(ErrorKind::InputError, "Deposit-Descriptor").c_stringify(),
    };

    let network_cstr = unsafe { CStr::from_ptr(network) };
    let network: &str = match network_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "test",
    };
    let network_enum = match network {
        "main" => Network::Bitcoin,
        "test" => Network::Testnet,
        _ => Network::Testnet,
    };

    let config = WalletConfig::default(deposit_desc, network_enum);
    match history::sync_balance(config) {
        Ok(result) => return result.c_stringify(),
        Err(e) => return e.c_stringify(),
    }
}

// #[deny(unsafe_op_in_unsafe_fn)]
// #[no_mangle]
// pub unsafe extern "C" fn sync_history(
//     deposit_desc: *const c_char,
//     network: *const c_char,
// ) -> *mut c_char {
//     let deposit_desc_cstr = unsafe { CStr::from_ptr(deposit_desc) };
//     let deposit_desc: &str = match deposit_desc_cstr.to_str() {
//         Ok(string) => &string,
//         Err(_) => return S5Error::new(ErrorKind::InputError, "Deposit-Descriptor").c_stringify(),
//     };

//     let network_cstr = unsafe { CStr::from_ptr(network) };
//     let network: &str = match network_cstr.to_str() {
//         Ok(string) => &string,
//         Err(_) => "test",
//     };
//     let network_enum = match network {
//         "main" => Network::Bitcoin,
//         "test" => Network::Testnet,
//         _ => Network::Testnet,
//     };

//     let config = WalletConfig::default(deposit_desc, network_enum);
//     match history::sync_history(config) {
//         Ok(result) => return "",
//         Err(e) => return e.c_stringify(),
//     }
// }

#[allow(clippy::missing_safety_doc)]
#[deny(unsafe_op_in_unsafe_fn)]
#[no_mangle]
pub unsafe extern "C" fn get_address(
    deposit_desc: *const c_char,
    network: *const c_char,
    index: *const c_char,
) -> *mut c_char {
    let deposit_desc_cstr = unsafe { CStr::from_ptr(deposit_desc) };
    let deposit_desc: &str = match deposit_desc_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => return S5Error::new(ErrorKind::InputError, "Deposit-Descriptor").c_stringify(),
    };

    let network_cstr = unsafe { CStr::from_ptr(network) };
    let network: &str = match network_cstr.to_str() {
        Ok(string) => &string,
        Err(_) => "test",
    };
    let network_enum = match network {
        "main" => Network::Bitcoin,
        "test" => Network::Testnet,
        _ => Network::Testnet,
    };

    let index_cstr = unsafe { CStr::from_ptr(index) };
    let address_index: u32 = match index_cstr.to_str() {
        Ok(string) => match string.parse::<u32>() {
            Ok(i) => i,
            Err(_) => {
                return CString::new("Error: Address Index Input.")
                    .unwrap()
                    .into_raw()
            }
        },
        Err(_) => return S5Error::new(ErrorKind::InputError, "Address-Index").c_stringify(),
    };

    let config = WalletConfig::default(deposit_desc, network_enum);

    match address::generate(config, address_index) {
        Ok(result) => return result.c_stringify(),
        Err(e) => return e.c_stringify(),
    }
}

#[allow(clippy::missing_safety_doc)]
#[no_mangle]
pub unsafe extern "C" fn cstring_free(ptr: *mut c_char) {
    if ptr.is_null() {
        return;
    }
    CString::from_raw(ptr);
    // rust automatically deallocates the pointer after using it
    // here we just convert it to a CString so it is used and cleared
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    /// Ensure that mnemonic does not error for bad input values.
    /// Default to 24 words mnemonic.
    fn test_c_master_ops() {
        unsafe {
            let master = generate_master(
                CString::new("9").unwrap().into_raw(),
                CString::new("").unwrap().into_raw(),
                CString::new("tpanini").unwrap().into_raw(),
            );
            let master = CStr::from_ptr(master).to_str().unwrap();
            let master: master::MasterKey = serde_json::from_str(master).unwrap();
            assert_eq!(
                24,
                master
                    .mnemonic
                    .split_whitespace()
                    .collect::<Vec<&str>>()
                    .len()
            );

            let mnemonic = "panel across strong judge economy song loud valid regret fork consider bid rack young avoid soap plate injury snow crater beef alone stay clock";
            let fingerprint = "eb79e0ff";
            let xprv = "tprv8ZgxMBicQKsPduTkddZgfGyk4ZJjtEEZQjofpyJg74LizJ469DzoF8nmU1YcvBFskXVKdoYmLoRuZZR1wuTeuAf8rNYR2zb1RvFns2Vs8hY";
            let master = import_master(
                CString::new(mnemonic).unwrap().into_raw(),
                CString::new("").unwrap().into_raw(),
                CString::new("tpanini").unwrap().into_raw(),
            );
            let master = CStr::from_ptr(master).to_str().unwrap();
            let master: master::MasterKey = serde_json::from_str(master).unwrap();
            assert_eq!(xprv, master.xprv);
            assert_eq!(fingerprint, master.fingerprint);
        }
    }
    /**
     * MasterKey {
        mnemonic: "panel across strong judge economy song loud valid regret fork consider bid rack young avoid soap plate injury snow crater beef alone stay clock",
        fingerprint: "eb79e0ff",
        xprv: "tprv8ZgxMBicQKsPduTkddZgfGyk4ZJjtEEZQjofpyJg74LizJ469DzoF8nmU1YcvBFskXVKdoYmLoRuZZR1wuTeuAf8rNYR2zb1RvFns2Vs8hY",
    }
     */
    #[test]
    fn test_c_child_ops() {
        unsafe {
            let fingerprint = "eb79e0ff";
            let master_xprv: &str = "tprv8ZgxMBicQKsPduTkddZgfGyk4ZJjtEEZQjofpyJg74LizJ469DzoF8nmU1YcvBFskXVKdoYmLoRuZZR1wuTeuAf8rNYR2zb1RvFns2Vs8hY";
            let master_xprv_cstr = CString::new(master_xprv).unwrap().into_raw();

            let purpose_index = "84";
            let purpose_cstr = CString::new(purpose_index).unwrap().into_raw();

            let account_index = "0";
            let account_cstr = CString::new(account_index).unwrap().into_raw();
            let hardened_path = "m/84h/1h/0h";
            let account_xprv = "tprv8gqqcZU4CTQ9bFmmtVCfzeSU9ch3SfgpmHUPzFP5ktqYpnjAKL9wQK5vx89n7tgkz6Am42rFZLS9Qs4DmFvZmgukRE2b5CTwiCWrJsFUoxz";
            let account_xpub = "tpubDDXskyWJLq5pUioZn8sGQ46aieCybzsjLb5BGmRPBAdwfGyvwiyXaoho8EYJcgJa5QGHGYpDjLQ8gWzczWbxadeRkCuExW32Boh696yuQ9m";
            let child_keys = child::ChildKeys {
                fingerprint: fingerprint.to_string(),
                hardened_path: hardened_path.to_string(),
                xprv: account_xprv.to_string(),
                xpub: account_xpub.to_string(),
            };

            let stringified = serde_json::to_string(&child_keys).unwrap();

            let result = derive_hardened(master_xprv_cstr, purpose_cstr, account_cstr);
            let result_cstr = CStr::from_ptr(result);
            let result: &str = result_cstr.to_str().unwrap();
            assert_eq!(result, stringified);
        }
    }

    #[test]
    fn test_c_wallet() {
        unsafe {
            let xkey = "[db7d25b5/84'/1'/6']tpubDCCh4SuT3pSAQ1qAN86qKEzsLoBeiugoGGQeibmieRUKv8z6fCTTmEXsb9yeueBkUWjGVzJr91bCzeCNShorbBqjZV4WRGjz3CrJsCboXUe";
            let network_cstr = CString::new("test").unwrap().into_raw();

            let deposit_desc = format!("wsh(pk({}/0/*))", xkey);
            let deposit_desc_cstr = CString::new(deposit_desc).unwrap().into_raw();
            let balance_ptr = sync_balance(deposit_desc_cstr, network_cstr);
            let balance_str = CStr::from_ptr(balance_ptr).to_str().unwrap();
            let balance: history::WalletBalance = serde_json::from_str(balance_str).unwrap();
            assert_eq!(balance.balance, 10_000);
            let index_cstr = CString::new("0").unwrap().into_raw();
            let address_ptr = get_address(deposit_desc_cstr, network_cstr, index_cstr);
            let address_str = CStr::from_ptr(address_ptr).to_str().unwrap();
            let address: address::WalletAddress = serde_json::from_str(address_str).unwrap();
            assert_eq!(
                address.address,
                "tb1q5f3jl5lzlxtmhptfe9crhmv4wh392ku5ztkpt6xxmqqx2c3jyxrs8vgat7"
            );
        }
    }
}
