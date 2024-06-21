dir %PREFIX%\Library

:: Configure. Switch off unit tests (require gtest / googletest)
cmake . -B build -G"Ninja" %CMAKE_ARGS%      ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%  ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%     ^
    -DCMAKE_BUILD_TYPE=Release               ^
    -DBUILD_TESTING=OFF                      ^
    -DBUILD_PYTHON=ON                        ^
    -DBUILD_SHARED_LIBS=ON                   ^
    -DPython3_EXECUTABLE="%PYTHON%"
if errorlevel 1 exit 1

:: Install.
cmake --install .\build
if errorlevel 1 exit 1
