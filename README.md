<p align="center"><img src="https://raw.github.com/wiki/MotomuMatsui/gs/images/GSbanner.png"></p>  

# gs2
`gs2` is a software to conduct a brand-new phylogenetic analysis method--the Graph Splitting (GS). It can effectively resolve early evolution of protein families, and its accuracy and speed was proved by extensive evolutionary simulation.    
`gs2` is open-source software (GPL v3.0) inplemented in C++ for <strong>Linux</strong>, <strong>Mac (macOS)</strong> and <strong>Windows (Cygwin)</strong>.    

<p align="center"><img src="https://raw.github.com/wiki/MotomuMatsui/gs/images/introduction.png"></p>

Reference: Motomu Matsui and Wataru Iwasaki, Systematic Biology, 2019  
Online tool: [GS analysis server](http://gs.bs.s.u-tokyo.ac.jp/)  
Our Laboratory: [Iwasaki Lab](http://iwasakilab.bs.s.u-tokyo.ac.jp/eindex.html)  

[![Build Status](https://travis-ci.org/MotomuMatsui/gs.svg?branch=master)](https://travis-ci.org/MotomuMatsui/gs)
[![Ubuntu](https://img.shields.io/badge/Linux-Ubuntu-green.svg)](https://www.ubuntu.com/)
[![CentOS](https://img.shields.io/badge/Linux-CentOS-green.svg)](https://www.centos.org/)
[![Mac](https://img.shields.io/badge/Mac-macOS-green.svg)](https://www.apple.com/macos/)
[![Windows](https://img.shields.io/badge/Windows-Cygwin-green.svg)](https://www.cygwin.com/)
[![Language](https://img.shields.io/badge/C%2B%2B-5.0%2B-green.svg)](https://gcc.gnu.org/)
[![LAPACK](https://img.shields.io/badge/LAPACK%2FBLAS-3.7%2B-green.svg)](http://www.netlib.org/lapack/)
[![MMseqs](https://img.shields.io/badge/MMSeqs-2.0%2B-green.svg)](https://github.com/soedinglab/MMseqs2)
[![GPL License](https://img.shields.io/badge/license-GPL-blue.svg)](LICENSE)

## History
version 2.4 (2019/02/12)
  - Modified distance function    

version 2.3 (2018/11/16)
  - Added Transfer Bootstrap Expectation algorithm (F. Lemoine, et al., Nature, 2018)    

version 2.2 (2018/11/07)   
  - Updated to display warnings in case redundant sequences are input    

version 2.1 (2018/10/15)   
  - Added transitivity function    
  - Modified addEP function    

version 2.0 (2018/06/01)   
  - Re-implemented in C++    
  - MMseq2 is used for all-to-all pairwise sequence alignment    

version 1.0 (2017/02/07)   
  - Implemented in R and Perl    
  - BLAST+ is used for all-to-all pairwise sequence alignment    

## Demo

![demo](https://raw.github.com/wiki/MotomuMatsui/gs/images/demo.gif)

## Installation

### 0. Requirements

- [GNU GCC compiler](https://gcc.gnu.org/) (5.0+) is required to compile `gs2`    
- [CMake](https://cmake.org/) (3.0+) is required to compile `mmseqs`    

  :exclamation: Mac users are recommended to install `gcc` and `cmake` using [Homebrew](https://brew.sh/)  

### 1. Compile from source code:

````
    $ git clone https://github.com/MotomuMatsui/gs
    $ cd gs
    $ make
````

- You can optimize the Makefile in response to your environment (ex. `CXX := g++-8`, `CXXFLAGS += -std=c++1z`)

### 2. Set PATH environment variable:

```
    $ export PATH=$(pwd)/MMseqs2/build/bin:$PATH
```

- You can move `mmseqs` to the other place where you want (ex. `~/bin`) and add this path to your PATH environment variable (ex. `export PATH=~/bin:$PATH`)

### Known issues

[![Mac](https://img.shields.io/badge/Mac-macOS-yellow.svg)](https://www.apple.com/macos/) ... Compiling LAPACK/BLAS sometimes fails    
- Rewrite `OPTS = -O2 -frecursive` to `OPTS = -O3 -frecursive -pipe` in `lapack-3.7.1/make.inc`, then re-execute `make`    

[![Mac](https://img.shields.io/badge/Mac-macOS-yellow.svg)](https://www.apple.com/macos/) ... You might get the following error message
```
    ld: library not found for -lgfortran
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
    make: *** [gs2] Error 1
```
- Firstly, please execute `locate gfortran` to get the path to `gfortran`. If you already have `gfortran` (ex. /usr/local/bin/gfortran-8), execute the following commands in response to your environment.
```
    $ ln -sf /usr/local/bin/gcc-8 /usr/local/bin/gcc
    $ ln -sf /usr/local/bin/g++-8 /usr/local/bin/g++
    $ ln -sf /usr/local/bin/gfortran-8 /usr/local/bin/gfortran
    $ hash -r
    $ make clean
    $ make
```
- If you have not had `gfortran` yet, please install the most current version of `gcc` using [Homebrew](https://brew.sh/), and execute the above commands    

[![Mac](https://img.shields.io/badge/Mac-macOS-yellow.svg)](https://www.apple.com/macos/) ... You might get the following error message 
```
    ar cr ../../liblapacke.a 
    ar: no archive members specified
        ...
        ...
        ...
    make: *** [lapack] Error 2
```
- Please re-execute `make`    

[![Mac](https://img.shields.io/badge/Mac-macOS-yellow.svg)](https://www.apple.com/macos/) ... If you had previously installed an old version of `gcc`, installing `mmseqs` sometimes fails
- Please replace the old version of `gcc` with the most current version using [Homebrew](https://brew.sh/). [SonicParanoid project page](http://iwasakilab.bs.s.u-tokyo.ac.jp/sonicparanoid/) should give you a useful hint to solve this issue  

[![Windows](https://img.shields.io/badge/Windows-Cygwin-yellow.svg)](https://www.cygwin.com/) ... LAPACK/BLAS <strong>version 3.8.0</strong> has some problem to be installed    
- Choose LAPACK/BLAS <strong>version 3.7.1</strong> for installation (default)    

## Usage
To get on-line help:
```
    $ ./gs2 -h
```

The following command enables you to calculate GS tree (phylogenetic tree reconstructed by Graph Splitting method):
```
    $ ./gs2 [arguments] input > output
```

  :exclamation: A multiple sequence file (ex. [example/200.faa](example/200.faa)) should be required as `input` in [fasta format](https://en.wikipedia.org/wiki/FASTA_format)

Arguments:

|Option| Description                                                                                         |
|:----:|:----------------------------------------------------------------------------------------------------|
|  -e  |<strong>[integer(>=0)]</strong> <em>The number of replicates for EP method. Default: 0</em>          |
|  -r  |<strong>[integer(>=1)]</strong> <em>The random seed number for EP method. Default: random number</em>|
|  -t  |<strong>[integer(>=1)]</strong> <em>The number of threads for MMseqs. Default: 1</em>                |
|  -m  |<strong>[real(1&ndash;7.5)]</strong> <em>Sensitivity for MMseqs. Default: 7.5</em>                   |
|  -b  |<strong>[string(tbe/fbs)]</strong> <em>The bootstrap method. Default: tbe</em>                       |
|  -s  |<em>Silent mode: do not report progress. Default: Off</em>                                           |
|  -l  |<em>Newick format with actual names. Default: Off</em>                                               |
|  -h  |<em>Show help messages. Default: Off</em>                                                            |
|  -v  |<em>Show the version. Default: Off</em>                                                              |

## Examples
GS tree (in [newick format](https://en.wikipedia.org/wiki/Newick_format)) will be displayed in `STDOUT` (correspondence table between IDs and Sequence Names &rarr; [example/200_annotation.txt](example/200_annotation.txt)):
```
    $ ./gs2 example/200.faa
```

GS tree with branch reliability (Edge perturbation; EP) scores will be saved in `test.nwk`:
```
    $ ./gs2 -e 100 example/200.faa > example/200.nwk
```

GS tree with EP scores; a seed number is specified for EP method:
```
    $ ./gs2 -e 100 -r 12345 example/200.faa > example/200.nwk
```

GS tree WITHOUT EP scores + silent mode:
```
    $ ./gs2 -e 0 -s example/200.faa > example/200.nwk
```

MMseqs2 runs multithreaded jobs (4 CPUs are used in parallel):
```
    $ ./gs2 -e 100 -t 4 example/200.faa > example/200.nwk
```

Visualization of [200.nwk](example/200.nwk) by [iTOL](https://itol.embl.de/):

<p align="center"><img src="https://raw.github.com/wiki/MotomuMatsui/gs/images/200_iTOL.png"></p>  

## License
This software is distributed under the GNU GPL, see [LICENSE](LICENSE)   
Copyright &copy; 2019, Motomu Matsui

## Author
[Motomu Matsui](https://sites.google.com/site/motomumatsui/)

## Reference
Frederic Lemoine, Jean-Baka Domelevo Entfellner, Eduan Wilkinson, Damien Correia, Miraine Davila Felipe, Tulio De Oliveira, and Olivier Gascuel, Renewing Felsensteins phylogenetic bootstrap in the era of big data, Nature, 2018    
Motomu Matsui and Wataru Iwasaki, Graph Splitting: A Graph-Based Approach for Superfamily-Scale Phylogenetic Tree Reconstruction, Systematic Biology, 2019    

## Acknowledgements
This package includes the LAPACKE/CBLAS (Univ. of Tennessee; Univ. of California, Berkeley; Univ. of Colorado Denver; and NAG Ltd.) and MMseqs (S&ouml;ding Laboratory) packages. The authors give special thanks to both teams. You can get the detailed information from http://www.netlib.org/lapack/ and https://github.com/soedinglab/MMseqs2.
