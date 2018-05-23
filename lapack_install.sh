LAPACK_VER=3.8.0
LIB_PATH=../lib

# Download and decompression LAPACK package.
wget http://www.netlib.org/lapack/lapack-${LAPACK_VER}.tar.gz
tar xvzf lapack-${LAPACK_VER}.tar.gz
cd lapack-${LAPACK_VER}

# Copy Makefile.
cp make.inc.example make.inc

# gcc version setting
module add gcc/8.1.0

# Compile BLAS
make blaslib

# Compile CBLAS
make cblaslib

# Compile LAPACK
make lapacklib

# Compile LAPACKE
make lapackelib

# copy Library File
cp *.a ${LIB_PATH}

# copy Header File
cp CBLAS/include/*.h ${LIB_PATH}
cp LAPACKE/include/*.h ${LIB_PATH}