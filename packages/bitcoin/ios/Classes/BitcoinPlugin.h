#import <Flutter/Flutter.h>

@interface BitcoinPlugin : NSObject<FlutterPlugin>
@end


char *generate_master(const char *network, const char *length, const char *passphrase);

char *import_master(const char *network, const char *mnemonic, const char *passphrase);

char *derive_hardened(const char *master_xprv, const char *purpose, const char *account);

char *compile(const char *policy, const char *script_type);

char *sync_balance(const char *deposit_desc, const char *node_address);

char *sync_history(const char *deposit_desc, const char *node_address);

char *get_address(const char *deposit_desc, const char *node_address, const char *index);

char *get_fees(const char *network, const char *node_address, const char *target_size);

char *build_tx(const char *deposit_desc,
               const char *node_address,
               const char *to_address,
               const char *amount,
               const char *fee_rate);

char *sign_tx(const char *deposit_desc, const char *node_address, const char *unsigned_psbt);

char *broadcast_tx(const char *deposit_desc, const char *node_address, const char *signed_psbt);
