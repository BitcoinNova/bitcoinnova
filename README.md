![image](https://github.com/BitcoinNova/brand/blob/master/logo/wordmark/bitcoinnova_wordmark_ubuntu.png)

[![Discord](https://img.shields.io/discord/428851188817985547?label=Bitcoin%20Nova%20[BTN])](https://discord.gg/8zQf7PD) 
[![GitHub All Releases](https://img.shields.io/github/downloads/BitcoinNova/bitcoinnova/total?label=Downloads)](http://latest.bitcoinnova.org) 
[![GitHub contributors](https://img.shields.io/github/contributors-anon/BitcoinNova/bitcoinnova?label=Contributors)](https://github.com/BitcoinNova/bitcoinnova/graphs/contributors) 
[![GitHub issues](https://img.shields.io/github/issues/BitcoinNova/bitcoinnova?label=Issues)](https://github.com/BitcoinNova/bitcoinnova/issues) 
![Version](https://img.shields.io/github/v/release/BitcoinNova/bitcoinnova)

#### Master Build Status
[![Build Status](https://travis-ci.org/BitcoinNova/bitcoinnova.svg?branch=master)](https://travis-ci.org/BitcoinNova/bitcoinnova) [![Build status](https://ci.appveyor.com/api/projects/status/0lcblve16aqbl006?svg=true)](https://ci.appveyor.com/project/BitcoinNovaProject/bitcoinnova)

### Installing

We offer binary images of the latest releases here: [http://latest.bitcoinnova.org](https://github.com/BitcoinNova/bitcoinnova/releases/)
If you would like to compile yourself, read on.

### How To Compile

#### Linux

##### Prerequisites

You will need the following packages: [Boost](https://www.boost.org/), [OpenSSL](https://www.openssl.org/), cmake (3.8 or higher), make, and git.

You will also need either GCC/G++, or Clang.

If you are using GCC, you will need GCC-7.0 or higher.

If you are using Clang, you will need Clang 6.0 or higher. You will also need libstdc++\-6.0 or higher.

##### Ubuntu, using GCC

- `sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y`
- `sudo apt-get update`
- `sudo apt-get install aptitude -y`
- `sudo aptitude install -y build-essential g++-8 gcc-8 git libboost-all-dev python-pip libssl-dev`
- `sudo pip install cmake`
- `export CC=gcc-8`
- `export CXX=g++-8`
- `git clone -b master --single-branch https://github.com/BitcoinNova/bitcoinnova`
- `cd bitcoinnova`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./Bitcoinnovad --version`

##### Ubuntu, using Clang

- `sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y`
- `wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -`

You need to modify the below command for your version of ubuntu - see https://apt.llvm.org/

* Ubuntu 14.04 (Trusty)
- `sudo add-apt-repository "deb https://apt.llvm.org/trusty/ llvm-toolchain-trusty 6.0 main"`

* Ubuntu 16.04 (Xenial)
- `sudo add-apt-repository "deb https://apt.llvm.org/xenial/ llvm-toolchain-xenial 6.0 main"`

* Ubuntu 18.04 (Bionic)
- `sudo add-apt-repository "deb https://apt.llvm.org/bionic/ llvm-toolchain-bionic 6.0 main"`

- `sudo apt-get update`
- `sudo apt-get install aptitude -y`
- `sudo aptitude install -y -o Aptitude::ProblemResolver::SolutionCost='100*canceled-actions,200*removals' build-essential clang-6.0 libstdc++-7-dev git libboost-all-dev python-pip libssl-dev`
- `sudo pip install cmake`
- `export CC=clang-6.0`
- `export CXX=clang++-6.0`
- `git clone -b master --single-branch https://github.com/BitcoinNova/bitcoinnova`
- `cd bitcoinnova`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./Bitcoinnovad --version`

##### Generic Linux

Ensure you have the dependencies listed above.

If you want to use clang, ensure you set the environment variables `CC` and `CXX`.
See the ubuntu instructions for an example.

- `git clone -b master --single-branch https://github.com/BitcoinNova/bitcoinnova`
- `cd bitcoinnova`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./Bitcoinnovad --version`

#### OSX/Apple, using Clang

##### Prerequisites

- Install XCode and Developer Tools.

##### Building

- `which brew || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
- `brew install --force cmake boost llvm openssl`
- `export CC=/usr/local/opt/llvm/bin/clang`
- `export CXX=/usr/local/opt/llvm/bin/clang++`
- `git clone -b master --single-branch https://github.com/BitcoinNova/bitcoinnova`
- `cd bitcoinnova`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./Bitcoinnovad --version`

#### Windows

##### Prerequisites

You can build for 32-bit or 64-bit Windows. **If you're not sure, pick 64-bit.**

- Download the [Build Tools for Visual Studio 2019](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=BuildTools&rel=16) Installer
- When it opens up select **C++ build tools**, it automatically selects the needed parts
- Install Boost (1.69 works the latest is 1.70 and doesn't work). Select the appropriate version for your system:
  - [Boost 64-bit](https://bintray.com/boostorg/release/download_file?file_path=1.69.0%2Fbinaries%2Fboost_1_69_0-msvc-14.1-64.exe)
  - [Boost 32-bit](https://bintray.com/boostorg/release/download_file?file_path=1.69.0%2Fbinaries%2Fboost_1_69_0-msvc-14.1-32.exe)
- Install the latest full version of OpenSSL (currently OpenSSL 1.1.1c). Select the appropriate version for your system:
  - [OpenSSL 64-bit](https://slproweb.com/download/Win64OpenSSL-1_1_1c.exe)
  - [OpenSSL 32-bit](https://slproweb.com/download/Win32OpenSSL-1_1_1c.exe)

##### Building

For 64-bit:
- From the start menu, open 'x64 Native Tools Command Prompt for VS 2019'.
- `cd <your_bitcoinnova_directory>`
- `mkdir build`
- `cd build`
- `cmake -G "Visual Studio 16 2019" -A x64 .. -DBOOST_ROOT=C:/local/boost_1_69_0`
- `MSBuild Bitcoinnova.sln /p:Configuration=Release /m` or `MSBuild src\cli.vcxproj /p:Configuration=Release /m`

For 32-bit:
- From the start menu, open 'x86 Native Tools Command Prompt for VS 2019'.
- `cd <your_bitcoinnova_directory>`
- `mkdir build`
- `cd build`
- `cmake -G "Visual Studio 16 2019" -A Win32 .. -DBOOST_ROOT=C:/local/boost_1_69_0`
- `MSBuild Bitcoinnova.sln /p:Configuration=Release /p:Platform=Win32 /m` 

The binaries will be in the `src/Release` folder when you are complete.

- `cd src`
- `cd Release`
- `Bitcoinnovad.exe --version`

#### Thanks
Cryptonote Developers, Bytecoin Developers, Monero Developers, Forknote Project, TurtleCoin Community, The Bitcoin Nova Developers.

### Copypasta for license when editing files

```
// Copyright (c) 2012-2017, The CryptoNote developers, The Bytecoin developers
// Copyright (c) 2014-2018, The Monero Project
// Copyright (c) 2018-2019, The TurtleCoin Developers
// Copyright (c) 2018-2020, The Bitcoin Nova Developers
//
// Please see the included LICENSE file for more information.
```
