
rm -rf build

# ModuleNotFoundError: No module named '_sysconfigdata_x86_64_apple_darwin20_0_0'
unset _PYTHON_SYSCONFIGDATA_NAME
unset _CONDA_PYTHON_SYSCONFIGDATA_NAME

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

# install
cmake --install ./build
