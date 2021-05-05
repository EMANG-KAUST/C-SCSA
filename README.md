# Signal denoising based on SCSA and a curvature constraint (C-SCSA)

Matlab implementation of the C-SCSA method.

[![Paper1](https://img.shields.io/badge/paper-IET%20journal-brightgreen)](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/sil2.12023)
[![Paper2](https://img.shields.io/badge/paper-ArXiv-blueviolet)](https://arxiv.org/abs/1908.07758)
[![Discord](https://img.shields.io/badge/Code%20Coverage-70%25-yellowgreen)](https://github.com/EMANG-KAUST/C-SCSA/blob/main/README.md)

## Running the project code
The original source is developed in Matlab 2016. An equaling or higher version is recommended. Download the project to your local Matlab directory and include all folders and subfolders in the project.

### Signal and noise generation
There are different types of signals you can generate, including:

|     Types     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **`Gaussian`**   | The Gaussian signal is recommended to be used in simulation, which [SCSA](https://link.springer.com/content/pdf/10.1007/s00498-012-0091-1.pdf) is good at characterizing. Signals such as [chromatography](https://en.wikipedia.org/wiki/Chromatography) spectral peaks can be modeled by Gaussian peaks API. The users will be able to change the amplitude, position and width of peak `[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,0)` in favor of their options.          |
|   `Regular`    | Stand-alone signing tool, which can be used as a backend signer for `geth`.  |
|   `Bumps`    | Utilities to interact with nodes on the networking layer, without running a full blockchain. |
|   `Blocks`    | Source code generator to convert Ethereum contract definitions into easy to use, compile-time type-safe Go packages. It operates on plain [Ethereum contract ABIs](https://docs.soliditylang.org/en/develop/abi-spec.html) with expanded functionality if the contract bytecode is also available. However, it also accepts Solidity source files, making development much more streamlined. Please see our [Native DApps](https://geth.ethereum.org/docs/dapp/native-bindings) page for details. |
|  `Sing`   | Stripped down version of our Ethereum client implementation that only takes part in the network node discovery protocol, but does not run any of the higher level application protocols. It can be used as a lightweight bootstrap node to aid in finding peers in private networks.                                                                                                                                                                                                                                                                 |
|     `Noise(Gaussian)`     | Developer utility version of the EVM (Ethereum Virtual Machine) that is capable of running bytecode snippets within a configurable environment and execution mode. Its purpose is to allow isolated, fine-grained debugging of EVM opcodes (e.g. `evm --code 60ff60ff --debug run`).                                                                                                                                                                                                                                                                     |
|   `Noise(Uniform)`   | Developer utility tool to convert binary RLP ([Recursive Length Prefix](https://eth.wiki/en/fundamentals/rlp)) dumps (data encoding used by the Ethereum protocol both network as well as consensus wise) to user-friendlier hierarchical representation (e.g. `rlpdump --hex CE0183FFFFFFC4C304050583616263`).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
