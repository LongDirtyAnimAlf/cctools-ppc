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

UNI_WARNINGS="-D_GNU_SOURCE -fcommon -Wno-sign-compare -Wno-return-local-addr -Wno-deprecated -Wno-attributes -Wno-maybe-uninitialized -Wno-narrowing  -Wno-address -Wall  -Wno-format -Wno-enum-compare -Wno-unused-result -Wno-unused-variable -Wno-unused-but-set-variable -Wno-deprecated -Wno-deprecated-declarations -Wno-char-subscripts -Wno-strict-aliasing -Wno-shift-negative-value -Wno-misleading-indentation -Wno-stringop-truncation  -Wno-parentheses"
C_WARNINGS="-Wno-int-conversion -Wno-implicit-function-declaration -Wno-pointer-sign"

export CFLAGS="-O2 $UNI_WARNINGS $C_WARNINGS"
export CXXFLAGS="-O2 $UNI_WARNINGS"
export LDFLAGS='-s'
export DEBUG_FLAGS=''

#---------------------------------------------------------------------------------
# Build and install cctools
#---------------------------------------------------------------------------------
REALDIR=$(readlink -f $SRCDIR)

cd $REALDIR

mkdir -p cctools-build/$target
cd cctools-build/$target
make clean 2>&1

$REALDIR/configure --prefix=$prefix --target=$target \
    2>&1 | tee cctools_configure.log

make clean 2>&1 | tee cctools_make.log
make all 2>&1 | tee cctools_make.log
make install 2>&1 | tee cctools_install.log

if [ "$OSTYPE" == "cygwin" ]; then
    cp /bin/cygcrypto-1.1.dll $prefix/bin
    cp /bin/cyggcc_s-1.dll $prefix/bin
    cp /bin/cyggcc_s-seh-1.dll $prefix/bin
    cp /bin/cygstdc++-6.dll $prefix/bin
    cp /bin/cygwin1.dll $prefix/bin
    cp /bin/cygz.dll $prefix/bin
    cp /bin/cyguuid-1.dll $prefix/bin
    cp /bin/cygintl-8.dll $prefix/bin
    cp /bin/cygiconv-2.dll $prefix/bin
    for astarget in arm i386 ppc ppc64 x86_64; do
        cp /bin/cyggcc_s-1.dll $prefix/libexec/as/$astarget
        cp /bin/cyggcc_s-seh-1.dll $prefix/libexec/as/$astarget
        cp /bin/cygwin1.dll $prefix/libexec/as/$astarget
    done 
fi
