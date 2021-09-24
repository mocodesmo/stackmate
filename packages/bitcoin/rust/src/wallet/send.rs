use bdk::blockchain::{noop_progress, ElectrumBlockchain};
use bdk::database::MemoryDatabase;
use bdk::electrum_client::Client;
use bdk::{FeeRate, Wallet};

use bdk::wallet::AddressIndex::New;
use bitcoin::consensus::serialize;

impl Send {
    pub fn build_tx() -> Result<(), bdk::Error> {
        let client = Client::new("ssl://electrum.blockstream.info:60002")?;
        let wallet = Wallet::new(
        "wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/0/*)",
        Some("wpkh([c258d2e4/84h/1h/0h]tpubDDYkZojQFQjht8Tm4jsS3iuEmKjTiEGjG6KnuFNKKJb5A6ZUCUZKdvLdSDWofKi4ToRCwb9poe1XdqfUnP4jaJjCB2Zwv11ZLgSbnZSNecE/1/*)"),
        bitcoin::Network::Testnet,
        MemoryDatabase::default(),
        ElectrumBlockchain::from(client)
    )?;

        wallet.sync(noop_progress(), None)?;

        let send_to = wallet.get_address(New)?;
        let (psbt, details) = {
            let mut builder = wallet.build_tx();
            builder
                .add_recipient(send_to.script_pubkey(), 50_000)
                .enable_rbf()
                .do_not_spend_change()
                .fee_rate(FeeRate::from_sat_per_vb(5.0));
            builder.finish()?
        };

        println!("Transaction details: {:#?}", details);
        println!("Unsigned PSBT: {}", &psbt);

        Ok(())
    }

    pub fn sign_tx() -> Result<(), bdk::Error> {
        let wallet = Wallet::new_offline(
            "wpkh([c258d2e4/84h/1h/0h]tprv8griRPhA7342zfRyB6CqeKF8CJDXYu5pgnj1cjL1u2ngKcJha5jjTRimG82ABzJQ4MQe71CV54xfn25BbhCNfEGGJZnxvCDQCd6JkbvxW6h/0/*)",
            Some("wpkh([c258d2e4/84h/1h/0h]tprv8griRPhA7342zfRyB6CqeKF8CJDXYu5pgnj1cjL1u2ngKcJha5jjTRimG82ABzJQ4MQe71CV54xfn25BbhCNfEGGJZnxvCDQCd6JkbvxW6h/1/*)"),
            bitcoin::Network::Testnet,
            MemoryDatabase::default(),
        )?;
        let psbt = "...";
        let mut psbt = Psbt::from_str(psbt)?;
        let finalized = wallet.sign(&mut psbt, SignOptions::default())?;
        Ok(())
    }
}
