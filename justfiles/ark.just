INTEROP_FLAGS := "-DPANDA_ETS_INTEROP_JS=ON -DPANDA_WITH_TESTS=ON -DPANDA_WITH_BENCHMARKS=OFF \
    -DPANDA_WITH_JAVA=OFF -DPANDA_WITH_TESTS_JAVA_ECMASCRIPT=OFF -DPANDA_WITH_CANJIE=OFF \
    -DPANDA_WITH_HZ_ECMASCRIPT=OFF -DPANDA_WITH_ECMASCRIPT=OFF"
HOST_CLANG_TOOLCHAIN := "-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/host_clang_14.cmake"
DEFAULT_ES2PANDA := '~/projects/arkcompiler_runtime_core/static_core/build/bin/es2panda'

[group('cmake-gen')]
[group('ohos')]
[group('default-folders')]
ark_interop: (cmake_default HOST_CLANG_TOOLCHAIN INTEROP_FLAGS)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins: (ark_interop)
    cmake --build {{BUILD_DIR}} --target panda_bins

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ets_interop_tests: (ark_interop)
    cmake --build {{BUILD_DIR}} --target ets_interop_js_tests

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ark_custom_target t: (ark_interop)
    cmake --build {{BUILD_DIR}} --target {{t}}

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ets_interop_scenarios: (ark_interop)
    cmake --build {{BUILD_DIR}} --target ets_interop_js_scenarios_js_to_ets

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ets_interop_scenarios_dirty: 
    cmake --build {{BUILD_DIR}} --target ets_interop_js_scenarios_js_to_ets

[group('ohos')]
[group('default-folders')]
es2panda_playground t f e2=DEFAULT_ES2PANDA:    
    @echo 'Run es2panda {{e2}}'
    @echo 'on {{t}}'
    {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('gdb')]
es2panda_playground_debug t f e2=DEFAULT_ES2PANDA:    
    @echo 'Run es2panda {{e2}}'
    @echo 'on {{t}}'
    gdb --args {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
