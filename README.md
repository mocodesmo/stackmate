<h1 align="center">STACKMATE</h1>
<div align="center">A multi-purpose Bitcoin Wallet</div>
<br />
<br />

## Table of Contents
- [Core](#core)
- [Features](#features)
- [Getting Started](#getting-started)
    - [Flutter Development](#flutter-development)
    - [VSCode Explorer](#vscode-explorer)
    - [Updating stackmate-core](#updating-stackmate-core)
- [Welcome Contributions](#welcome-contributions)
- [Maintainers](#maintainers)
- [License](#license)

## Core
This app uses [stackmate-core](https://github.com/i5hi/stackmate-core) for it's Bitcoin specific logic. 
<br/>
[stackmate-core](https://github.com/i5hi/stackmate-core) is built using Rust.
<br/>
This app communicates with [stackmate-core's](https://github.com/i5hi/stackmate-core) Rust binary via FFI.

## Features
- __modern descriptor wallets:__ uses all the latest technologies from the Bitcoin ecosystem
- __calculator:__ calculate current exchange rates with our built-in calculator
- __cross platform:__ built using Flutter 💙 and Rust

## Getting Started
<br/>

### Flutter Development
Make sure Flutter and Dart are installed.
```bash
flutter pub get
flutter run
```
Run freezed code-gen while updating cubit state classes or model classes.
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```
<br/>

### VSCode Explorer
Visibility of files and folders can be toggled from

    .
    └── .vscode/
        └── settings.json 

<br/>

### Updating stackmate-core
Make sure Rust and Android NDK are installed.
```bash
cd packages/bitcoin
sh update-core.sh
```

<br/>
<br/>


## Welcome Contributions
PRs / help is welcome in the following areas.
- running rust binaries on an ios emulator
-

## Maintainers
[Morteza](https://github.com/mocodesmo)

[Vishal](https://github.com/i5hi)

## License
[MIT](https://github.com/mocodesmo/stackmate/blob/main/LICENSE)