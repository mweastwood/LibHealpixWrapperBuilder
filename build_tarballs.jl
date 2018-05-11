using BinaryBuilder

# Collection of sources required to build LibHealpixWrapper
sources = [
    "https://github.com/mweastwood/LibHealpixWrapper.git" =>
    "889645f510d7283f6ce3393eb6e2576c9d6f6be4",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd LibHealpixWrapper
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_TOOLCHAIN_FILE=/opt/$target/$target.toolchain
make
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    BinaryProvider.Linux(:i686, :glibc, :blank_abi),
    BinaryProvider.Linux(:aarch64, :glibc, :blank_abi),
    BinaryProvider.Linux(:powerpc64le, :glibc, :blank_abi),
    BinaryProvider.Linux(:armv7l, :glibc, :eabihf),
    BinaryProvider.MacOS(:x86_64, :blank_libc, :blank_abi),
    BinaryProvider.Linux(:x86_64, :glibc, :blank_abi)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libhealpixwrapper", :libhealpixwrapper)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    "https://github.com/mweastwood/LibHealpixBuilder/releases/download/v3.31-1/build.jl"
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "LibHealpixWrapper", sources, script, platforms, products, dependencies)

