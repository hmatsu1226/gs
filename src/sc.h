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

#ifndef SC_H
#define SC_H

#include <algorithm>
#include <tuple>
#include <vector>

#include "eigen.h"
#include "sc_functions.h"

using namespace std;

tuple<vector<int>,vector<int>> spectral_clustering(double* const& oW, vector<int> const& res, int const& num);

#endif /*SC_H*/
