#import <Flutter/Flutter.h>

@interface BitcoinPlugin : NSObject<FlutterPlugin>
@end

char *generate_master(const char *length, const char *passphrase, const char *network);

char *import_master(const char *mnemonic, const char *passphrase, const char *network);

char *derive_hardened(const char *master_xprv, const char *purpose, const char *account);

char *compile(const char *policy, const char *script_type);

char *sync_balance(const char *deposit_desc, const char *network);

char *get_address(const char *deposit_desc, const char *network, const char *index);

void cstring_free(char *ptr);