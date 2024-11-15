import os
import sys
import pathlib
import fileinput
import re

def get_script_path():
    return os.path.dirname(os.path.realpath(__file__))

if __name__ == "__main__":
    project_dir = pathlib.Path(get_script_path())
    build_dir = project_dir /  pathlib.Path("build")
    i18_file = build_dir /  pathlib.Path("runtime/src/kmp_i18n_default.inc")
    print(f"Fixing: {i18_file}")

    regex = re.compile(r"%([0-9])!(s|l?[du])!")

    for line in fileinput.input(i18_file, inplace=True):
        print(regex.sub(r"%\1$\2", line), end='')

    print(f"Fixed: {i18_file}")

