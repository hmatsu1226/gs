/******************************************\
| Graph Splitting Method v2.4 (2019/02/12) |
|                                          |
| Copyright (c) 2015-2019 Motomu Matsui    |
|     Distributed under the GNU GPL        |
|                                          |
|     Matsui M and Iwasaki W (2019)        |
|     Systematic Biology, xx:xx-xx.        |
|                                          |
|     http://gs.bs.s.u-tokyo.ac.jp/        |
\******************************************/

#ifndef MMSEQS_H
#define MMSEQS_H

#include <fstream>
#include <regex>
#include <sstream>
#include <stdio.h>
#include <string>
#include <sys/stat.h>
#include <unordered_map>

using namespace std;

void mmseqs(string const& fst, string const& output, string const& threads, string const& sensitivity);

#endif /*MMSEQS_H*/
