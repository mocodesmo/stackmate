# api
### stackmate-bdk ffi documentation

```
generate_master(
    network: "test" || "main", (All other strings default to "test")
    length: "12" || "24", (All other strings default to "24")
    passphrase: *const c_char, (Can be empty string)
)
```

```
import_master(
    network: "test" || "main", (All other strings default to "test")
    mnemonic: *const c_char, (words separated by space)
    passphrase: *const c_char, (Can be empty string)
)
```

```
derive_hardened(
    master_xprv: *const c_char,
    purpose: "84" || "49" || "44", (All other strings default to "84")
    account: *const c_char, (Can be empty - will default to "0" if value cannot be parsed to integer)
)
```

```
compile(
  policy: *const c_char, 
  script_type: "wpkh" || "wsh" || "sh" || "pk", (Defaults to "wpkh" for all others)
)
```

```
get_fees(
    network: "test" || "main", (All other strings default to "test")
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
    target_size: *const c_char, (Values that cannot be parsed to integer will default to "6")
)
```

```
sync_balance(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
)
```

```
sync_history(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
)
```

```
get_address(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
    index: *const c_char,
)
```

```
build_tx(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
    to_address: *const c_char,
    amount: *const c_char,
    fee_rate: *const c_char,
)
```

```
sign_tx(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
    unsigned_psbt: *const c_char,
)
```

```
broadcast_tx(
    deposit_desc: *const c_char,
    node_address: "default" || *const c_char, ("default" or invalid *const c_char will default to blockstream server)
    signed_psbt: *const c_char,
)
```

```
cstring_free(ptr: *mut c_char)

```