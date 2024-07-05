INTEROP_FLAGS := "-DPANDA_ETS_INTEROP_JS=ON -DPANDA_WITH_TESTS=ON -DPANDA_WITH_BENCHMARKS=OFF"
HOST_CLANG_TOOLCHAIN := "-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/host_clang_14.cmake"

[group('cmake-gen')]
[group('ohos')]
[group('default-folders')]
ark_interop: (cmake_default HOST_CLANG_TOOLCHAIN INTEROP_FLAGS)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins: (ark_interop)
    cmake --build BUILD_DIR --target panda_bins

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ets_interop_tests: (ark_interop)
    cmake --build BUILD_DIR --target ets_interop_js_tests

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ark_custom_target t: (ark_interop)
    cmake --build BUILD_DIR --target {{t}}

