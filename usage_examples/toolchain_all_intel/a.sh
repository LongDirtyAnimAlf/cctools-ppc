#!/usr/bin/env bash

#---------------------------------------------------------------------------------
# set the target
#---------------------------------------------------------------------------------

target=i686-apple-darwin8

#---------------------------------------------------------------------------------
# Source and Install directories
#---------------------------------------------------------------------------------

SRCDIR=./../../cctools               # the source code dir for cctools
prefix=~/cctools-port/$target        # installation directory

#---------------------------------------------------------------------------------
# set compiler flags
#---------------------------------------------------------------------------------


WARNINGS="-D_GNU_SOURCE -fcommon -Wl,--allow-multiple-definition -Wno-deprecated -Wno-attributes -Wno-maybe-uninitialized -Wno-narrowing -Wno-address -Wall -Wno-format -Wno-enum-compare -Wno-unused-result -Wno-unused-variable -Wno-unused-but-set-variable -Wno-deprecated -Wno-deprecated-declarations -Wno-char-subscripts -Wno-strict-aliasing -Wno-shift-negative-value -Wno-misleading-indentation -Wno-stringop-truncation -Wno-parentheses"

# export LIBS="-nodefaultlibs -lc++ -lc++abi -lm -lc -lgcc_s -lgcc" 
# export CC=clang 
# export CPP=clang-cpp
# export CXX=clang++ 

export CFLAGS="-O2 -std=gnu17 -Wno-int-conversion -Wno-implicit-function-declaration -Wno-pointer-sign $WARNINGS"
# export CXXFLAGS="-O2 -Wno-objc-root-class $WARNINGS"
export CXXFLAGS="-O2 --std=c++0x $WARNINGS"
export LDFLAGS='-s'
export DEBUG_FLAGS=''


#---------------------------------------------------------------------------------
# Build and install cctools
#---------------------------------------------------------------------------------
REALDIR=$(readlink -f $SRCDIR)


cd $REALDIR
# make clean 2>&1

mkdir -p cctools-build/$target
cd cctools-build/$target

make 2>&1 | tee cctools_make.log
## make install 2>&1 | tee cctools_install.log
