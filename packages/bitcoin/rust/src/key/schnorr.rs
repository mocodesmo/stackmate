// use serde::{Serialize,Deserialize};
use crate::e::{ErrorKind,S5Error};

use secp256k1::rand::rngs::OsRng;
use secp256k1::Secp256k1;

use bitcoin::util::schnorr::{KeyPair,PublicKey};

#[derive(Debug,Clone)]
pub struct SchnorrPair{
  key_pair: KeyPair,
  public_key: PublicKey
}

pub fn generate()->Result<SchnorrPair,S5Error>{
    
  let mut rng = match OsRng::new() {
    Ok(r) => r,
    Err(_) => return Err(S5Error::new(ErrorKind::OpError,"OS-RNG")),
  };
  let secp = Secp256k1::new();

  let key_pair = KeyPair::new(&secp,&mut rng);
  let public_key = PublicKey::from_keypair(&secp,&key_pair);

  Ok(SchnorrPair{
    key_pair,
    public_key
  })

}

#[cfg(test)]
mod tests {
  use super::*;
  #[test]
  fn test_schnorr() {
    let schnorr_keys = generate();
    println!("{:#?}",schnorr_keys);
  }
}
