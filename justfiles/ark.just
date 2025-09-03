INTEROP_FLAGS := "-DPANDA_ETS_INTEROP_JS=ON -DPANDA_WITH_TESTS=ON -DPANDA_WITH_BENCHMARKS=OFF"
HOST_CLANG_TOOLCHAIN := "-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/host_clang_14.cmake"
DEFAULT_ES2PANDA := '~/projects/panda/runtime_core/static_core/build/bin/es2panda'
LLVM_TARGET := '-DPANDA_LLVM_BACKEND=ON -DLLVM_TARGET_PATH=/home/nojpg/projects/panda/llvm_install/llvm-15.0.4-ark18-debug-x86_64'
urunner := "tests/tests-u-runner/runner.sh"
CROSS_CLANG_MINGW_TOOLCHAIN := "-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/cross-clang-14-x86_64-w64-mingw32-static.cmake"

[group('cmake-gen')]
[group('ohos')]
[group('default-folders')]
ark_interop *f: (cmake_default HOST_CLANG_TOOLCHAIN INTEROP_FLAGS f)

[group('cmake-gen')]
[group('ohos')]
ark_interop_in b *f: (cmake_in b HOST_CLANG_TOOLCHAIN INTEROP_FLAGS f)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins b=BUILD_DIR f='': (ark_interop_in b f)
    hyperfine --runs 1 --show-output 'cmake --build {{b}} --target panda_bins ets_interop_js_napi ts_bindings etssdk'

[group('default-folders')]
[group('cmake-build')]
[group('tests')]
func_test b=BUILD_DIR f='': (panda_bins b f)
    hyperfine --runs 1 --show-output 'bash tests/tests-u-runner/runner.sh --ets-func-tests --build-dir {{b}} --force-generate --processes $(nproc) --show-progress'

[group('default-folders')]
[group('cmake-build')]
[group('tests')]
sdk_test b=BUILD_DIR f='': (panda_bins b f)
    hyperfine --runs 1 --show-output 'bash tests/tests-u-runner/runner.sh --ets-sdk --build-dir {{b}} --force-generate --processes $(nproc) --show-progress'

[group('default-folders')]
[group('cmake-build')]
[group('tests')]
sdk_test_dirty b=BUILD_DIR f='':
    hyperfine --runs 1 --show-output 'bash tests/tests-u-runner/runner.sh --ets-sdk --build-dir {{b}} --force-generate --processes $(nproc) --show-progress'

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
check b=BUILD_DIR f='': (ark_interop_in b f)
    cmake --build {{b}} --target cmake-checker test-cmake-checker clang-tidy-check code-style-check
    
[group('cmake-gen')]
[group('ohos')]
[group('default-folders')]
ark_interop_win b *f: (cmake_in b CROSS_CLANG_MINGW_TOOLCHAIN f)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
bindings_win b=BUILD_DIR f='': (ark_interop_win b f)
    cmake --build {{b}} --target ts_bindings
    

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins_dirty b=BUILD_DIR:
    hyperfine --runs 1 --show-output 'cmake --build {{b}} --target panda_bins ets_interop_js_napi ts_bindings'

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
[group('tests')]
ets_interop_tests: (ark_interop)
    cmake --build {{BUILD_DIR}} --target ets_interop_tests

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
[group('tests')]
ets_interop_js_tests: (ark_interop)
    cmake --build {{BUILD_DIR}} --target ets_interop_js_tests 
    
[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ark_custom_target *t: (ark_interop)
    cmake --build {{BUILD_DIR}} --target {{t}}

[group('ohos')]
[group('default-folders')]
ark_llvm_back: (panda_bins BUILD_DIR LLVM_TARGET)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
ark_custom_target_dirty *t:
    cmake --build {{BUILD_DIR}} --target {{t}}

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
[group('tests')]
ets_interop_scenarios: (ark_interop)
    cmake --build {{BUILD_DIR}} --target ets_interop_js_scenarios_js_to_ets

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
[group('tests')]
ets_interop_scenarios_dirty: 
    cmake --build {{BUILD_DIR}} --target ets_interop_js_scenarios_js_to_ets

[group('ohos')]
[group('default-folders')]
es2panda_playground_compile t f e2=DEFAULT_ES2PANDA:    
    {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('gdb')]
es2panda_playground_debug t f e2=DEFAULT_ES2PANDA:    
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
    #gdb --args {{e2}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('gdb')]
es2panda_playground_debug2 t f f2 e2=DEFAULT_ES2PANDA:    
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/{{f2}}.abc {{t}}/{{f2}}
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
    #gdb --args {{e2}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('run')]
es2panda_playground_run folder file es2panda=DEFAULT_ES2PANDA:   
    {{es2panda}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/main.abc {{folder}}/{{file}}
    #node {{folder}}/default_node.js
    lldb -- node {{folder}}/default_node.js
    #gdb --args node {{folder}}/default_node.js
  
[group('ohos')]
[group('default-folders')]
[group('run')]
es2panda_playground_run2 folder file file2 es2panda=DEFAULT_ES2PANDA:   
    {{es2panda}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/{{file2}}.abc {{folder}}/{{file2}}
    {{es2panda}} --opt-level=2 --thread=0 --extension=sts --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/main.abc {{folder}}/{{file}}
    #node {{folder}}/default_node.js
    lldb -- node {{folder}}/default_node.js

[group('ohos')]
[group('default-folders')]
es2panda_playground_dump t f e2=DEFAULT_ES2PANDA:    
    {{e2}} --opt-level=2 --dump-ast --thread=0 --extension=sts --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('urunner')]
[group('ohos')]
[group('default-folders')]
runner test_file b=BUILD_DIR:
    {{urunner}} --work-dir={{b}}/groups --astchecker --processes=8 --build-dir={{b}} --verbose all --test-file {{test_file}}

[group('ohos')]
[group('default-folders')]
[group('std-lib')]
genlib b=BUILD_DIR:
    bash plugins/ets/templates/stdlib/genlib.sh
