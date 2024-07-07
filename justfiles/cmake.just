GENERATOR_NAME := 'Ninja'
BUILD_TYPE := 'Debug'
BUILD_DIR := 'build'
SOURCE_PATH := '.'
EMPTY := ''

_clean b=BUILD_DIR:
    @echo 'Remove {{b}}'
    rm -rf {{b}}
	
_cmake_gen b=BUILD_DIR g=GENERATOR_NAME s=SOURCE_PATH bt=BUILD_TYPE *extra_flags='': (_clean b)
    @echo 'Cmake generate into {{b}}, \
     generator {{g}}, sources {{s}} extra_flags {{extra_flags}}'
    cmake -G {{g}} -B {{b}} -S {{s}} -Werror=dev \
     -DCMAKE_BUILD_TYPE={{bt}} -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
     {{extra_flags}}

[group('cmake-gen')]
[group('default-folders')]
cmake_default *extra_flags: (_cmake_gen BUILD_DIR GENERATOR_NAME SOURCE_PATH BUILD_TYPE extra_flags)

[group('cmake-build')]
cmake_all b=BUILD_DIR:
    cmake --build {{b}} --target all

import 'ark.just'
