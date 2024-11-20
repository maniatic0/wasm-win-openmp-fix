# WASM fix for Cross Compilation in Windows

For why the fix works see ```Notes.txt```. Also, this issue was raised in the LLVM Project at https://github.com/llvm/llvm-project/issues/116552 and fixed at https://github.com/llvm/llvm-project/pull/116874

Steps:

1. In ```build.bat```, change ```EMSDK_DIR``` and ```LLVM_PROJECT_DIR``` to where you have EMSDK and the LLVM Project. You can also change compilation flags there, see ```CFLAGS``` and ```CXXFLAGS```.
2. Run ```build.bat```
3. Check ```./build/lib/libomp.a``` for the static lib you'll link to
4. Check ```./build/include``` for the headers you need
