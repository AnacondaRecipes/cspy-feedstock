:: cmd
echo "Building %PKG_NAME%."

:: Generate the build files.
echo "Generating the build files..."

:: Configure. Switch off unit tests (require gtest / googletest)
cmake . -B build -G"Ninja" %CMAKE_ARGS%       ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DCMAKE_BUILD_TYPE=Release               ^
    -DBUILD_TESTING=OFF                      ^
    -DBUILD_PYTHON=ON                        ^
    -DBUILD_SHARED_LIBS=ON                   ^
    -DPython3_EXECUTABLE="%PYTHON%"          ^
    -DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS ^
    -DCMAKE_REQUIRE_FIND_PACKAGE_LEMON=ON
if errorlevel 1 exit 1

cmake --build build --target all -v
if errorlevel 1 exit 1

:: Install the wheel
FOR %%w in (build\python\dist\*.whl) DO %PYTHON% -m pip install %%w --no-deps --no-build-isolation -v

:: Install.
cmake --install build
if errorlevel 1 exit 1
