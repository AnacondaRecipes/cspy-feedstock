
rm -rf build

# configure, switch off unit tests (require gtest / googletest)
cmake . -B build -G Ninja $CMAKE_ARGS  \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_PREFIX_PATH=$PREFIX    \
        -DCMAKE_BUILD_TYPE=Release     \
        -DBUILD_TESTING=OFF            \
        -DBUILD_PYTHON=ON              \
        -DBUILD_SHARED_LIBS=ON         \
        -DPython3_EXECUTABLE="$PYTHON" \
        -DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS \
        -DCMAKE_REQUIRE_FIND_PACKAGE_LEMON=ON

cmake --build build --target all -v

# The build will create a wheel file in build/python/dist
# we install that using the usual python script.
# The name of the generated wheel:
#  e.g. cspy-1.0.3-cp38-cp38-linux_aarch64.whl
${PYTHON} -m pip install build/python/dist/cspy-*.whl --no-deps --no-build-isolation -vv

# cd build && ctest --verbose -R python_unittest

# install
cmake --install ./build
