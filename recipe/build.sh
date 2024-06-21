
rm -rf build

# configure, switch off unit tests (require gtest / googletest)
cmake . -B build -G Ninja $CMAKE_ARGS  \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_PREFIX_PATH=$PREFIX    \
        -DCMAKE_BUILD_TYPE=Release     \
        -DBUILD_TESTING=OFF            \
        -DBUILD_PYTHON=ON              \
        -DBUILD_SHARED_LIBS=ON         \
        -DPython3_EXECUTABLE="$PYTHON"

cmake --build build --config Release --target all -v

# cd build && ctest --verbose -R python_unittest

# install
cmake --install ./build