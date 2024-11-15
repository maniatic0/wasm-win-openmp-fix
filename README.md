# WASM fix for Cross Compilation in Windows

For why the fix works see ```Notes.txt```.

Steps:

1. In ```build.bat```, change ```EMSDK_DIR``` and ```LLVM_PROJECT_DIR``` to where you have EMSDK and the LLVM Project.
2. Run ```build.bat```
3. Check ```./build/lib/libomp.a``` for the static lib you'll link to
4. Check ```./build/include``` for the headers you need
