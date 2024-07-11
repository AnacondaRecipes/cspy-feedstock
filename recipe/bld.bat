dir %PREFIX%\Library

:: Configure. Switch off unit tests (require gtest / googletest)
cmake . -B build -G"Visual Studio 16 2019" %CMAKE_ARGS%      ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%     ^
    -DCMAKE_BUILD_TYPE=Release               ^
    -DBUILD_TESTING=OFF                      ^
    -DBUILD_PYTHON=ON                        ^
    -DBUILD_SHARED_LIBS=ON                   ^
    -DPython3_EXECUTABLE="%PYTHON%"          ^
    -DFETCHCONTENT_TRY_FIND_PACKAGE_MODE=ALWAYS ^
    -DCMAKE_REQUIRE_FIND_PACKAGE_LEMON=ON
if errorlevel 1 exit 1

cmake --build build --config Release --target install -v
if errorlevel 1 exit 1


:: Install.
cmake --install .\build
if errorlevel 1 exit 1
