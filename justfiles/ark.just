INTEROP_FLAGS := "-DPANDA_ETS_INTEROP_JS=ON -DPANDA_WITH_TESTS=ON -DPANDA_WITH_BENCHMARKS=OFF"
HOST_CLANG_TOOLCHAIN := "-DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/host_clang_14.cmake"
DEFAULT_ES2PANDA := '~/projects/arkcompiler_runtime_core/static_core/build/bin/es2panda'

[group('cmake-gen')]
[group('ohos')]
[group('default-folders')]
ark_interop: (cmake_default HOST_CLANG_TOOLCHAIN INTEROP_FLAGS)

[group('cmake-gen')]
[group('ohos')]
ark_interop_in b: (cmake_in b HOST_CLANG_TOOLCHAIN INTEROP_FLAGS)

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins b=BUILD_DIR: (ark_interop_in b)
    cmake --build {{b}} --target panda_bins ets_interop_js_napi

[group('cmake-build')]
[group('ohos')]
[group('default-folders')]
panda_bins_dirty b=BUILD_DIR:
    cmake --build {{b}} --target panda_bins ets_interop_js_napi

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
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
    #gdb --args {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('gdb')]
es2panda_playground_debug2 t f f2 e2=DEFAULT_ES2PANDA:    
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/{{f2}}.abc {{t}}/{{f2}}
    lldb -- {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
    #gdb --args {{e2}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}

[group('ohos')]
[group('default-folders')]
[group('run')]
es2panda_playground_run folder file es2panda=DEFAULT_ES2PANDA:   
    {{es2panda}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/main.abc {{folder}}/{{file}}
    #node {{folder}}/default_node.js
    lldb -- node {{folder}}/default_node.js
  
[group('ohos')]
[group('default-folders')]
[group('run')]
es2panda_playground_run2 folder file file2 es2panda=DEFAULT_ES2PANDA:   
    {{es2panda}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/{{file2}}.abc {{folder}}/{{file2}}
    {{es2panda}} --opt-level=2 --thread=0 --extension=ets --arktsconfig={{folder}}/arktsconfig.json --output={{folder}}/main.abc {{folder}}/{{file}}
    #node {{folder}}/default_node.js
    lldb -- node {{folder}}/default_node.js

[group('ohos')]
[group('default-folders')]
es2panda_playground_dump t f e2=DEFAULT_ES2PANDA:    
    {{e2}} --opt-level=2 --dump-ast --thread=0 --extension=ets --arktsconfig={{t}}/arktsconfig.json --output={{t}}/main.abc {{t}}/{{f}}
