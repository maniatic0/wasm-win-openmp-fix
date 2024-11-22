@echo off
rem Based on https://github.com/abrown/wasm-openmp-examples/blob/main/emscripten.sh

set PROJECT_DIR=%~dp0\..
set EMSDK_DIR=%PROJECT_DIR%\emsdk
set BUILD_DIR=%~dp0\build
set LLVM_PROJECT_DIR=%PROJECT_DIR%\..\llvm-project
set OPENMP_DIR=%LLVM_PROJECT_DIR%\openmp
set OPENMP_LIB=%BUILD_DIR%\lib\libomp.a

mkdir %BUILD_DIR%

call %EMSDK_DIR%\emsdk activate tot

set CFLAGS=-O3 -std=c++20 -pthread -sUSE_PTHREADS=1 -msimd128 -mavx -fdebug-compilation-dir='%OPENMP_DIR%'
set CXXFLAGS=-O3 -std=c++20 -pthread -sUSE_PTHREADS=1 -msimd128 -mavx -fdebug-compilation-dir='%OPENMP_DIR%'
call emcmake cmake ^
    -DOPENMP_STANDALONE_BUILD=ON ^
    -DOPENMP_ENABLE_OMPT_TOOLS=OFF ^
    -DOPENMP_ENABLE_LIBOMPTARGET=OFF ^
    -DLIBOMP_HAVE_OMPT_SUPPORT=OFF ^
    -DLIBOMP_OMPT_SUPPORT=OFF ^
    -DLIBOMP_OMPD_SUPPORT=OFF ^
    -DLIBOMP_USE_DEBUGGER=OFF ^
    -DLIBOMP_FORTRAN_MODULES=OFF ^
    -DLIBOMP_ENABLE_SHARED=OFF ^
    -DLIBOMP_ARCH=wasm32 ^
    -DCMAKE_INSTALL_PREFIX=%BUILD_DIR% ^
    -G "Ninja Multi-Config" ^
    -B %BUILD_DIR% ^
    -S %OPENMP_DIR%

rem No longer needed as of https://github.com/llvm/llvm-project/pull/116874
rem python %~dp0\fix_kmp_i18n_default.py

call emmake cmake --build %BUILD_DIR% --config Release
call emmake cmake --install %BUILD_DIR% --config Release

echo.%cmdcmdline% | find /I "%~0" >nul
if not errorlevel 1 pause
