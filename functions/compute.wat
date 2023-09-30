(module
  (type (;0;) (func (param i32) (result i32)))
  (type (;1;) (func (result i32)))
  (type (;2;) (func (param i32)))
  (type (;3;) (func))
  (type (;4;) (func (param i32 i32)))
  (type (;5;) (func (param i32 i32 i32)))
  (type (;6;) (func (param i32 i32) (result i32)))
  (type (;7;) (func (param f64 f64) (result f64)))
  (type (;8;) (func (param i32 i32 f64)))
  (type (;9;) (func (param f64) (result f64)))
  (func $__wasm_call_ctors (type 3)
    nop)
  (func $foo_std::__2::span<char__4294967295ul>_ (type 4) (param i32 i32)
    (local i32 i32 i32 i32 i32 i32 f64 f64 i32 i64 f64 f64 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    i32.const 6000000
    call $dlmalloc
    local.set 5
    loop  ;; label = @1
      local.get 7
      f64.convert_i32_s
      local.tee 8
      local.get 8
      f64.add
      f64.const 0x1.f4p+10 (;=2000;)
      f64.div
      f64.const -0x1p+0 (;=-1;)
      f64.add
      local.set 9
      i32.const 0
      local.set 10
      loop  ;; label = @2
        local.get 2
        local.get 9
        f64.store offset=24
        local.get 2
        local.get 10
        f64.convert_i32_s
        f64.const 0x1.8p+1 (;=3;)
        f64.mul
        f64.const 0x1.77p+11 (;=3000;)
        f64.div
        f64.const -0x1p+1 (;=-2;)
        f64.add
        local.tee 12
        f64.store offset=16
        i32.const 0
        local.set 3
        i32.const 0
        local.set 4
        block  ;; label = @3
          local.get 12
          local.get 9
          call $hypot
          f64.const 0x1p+1 (;=2;)
          f64.gt
          br_if 0 (;@3;)
          loop  ;; label = @4
            local.get 2
            local.get 2
            i32.const 16
            i32.add
            local.get 2
            i32.const 16
            i32.add
            call $std::__2::complex<double>_std::__2::operator*_abi:v160004_<double>_std::__2::complex<double>_const&__std::__2::complex<double>_const&_
            local.get 2
            local.get 9
            local.get 2
            f64.load offset=8
            f64.add
            local.tee 8
            f64.store offset=24
            local.get 2
            local.get 12
            local.get 2
            f64.load
            f64.add
            local.tee 13
            f64.store offset=16
            local.get 3
            i32.const 1
            i32.add
            local.set 4
            local.get 13
            local.get 8
            call $hypot
            f64.const 0x1p+1 (;=2;)
            f64.gt
            br_if 1 (;@3;)
            local.get 3
            i32.const 255
            i32.and
            local.set 14
            local.get 4
            local.set 3
            local.get 14
            i32.const 99
            i32.lt_u
            br_if 0 (;@4;)
          end
        end
        local.get 5
        local.get 6
        i32.add
        local.get 4
        i32.store8
        local.get 6
        i32.const 1
        i32.add
        local.set 6
        local.get 10
        i32.const 1
        i32.add
        local.tee 10
        i32.const 3000
        i32.ne
        br_if 0 (;@2;)
      end
      local.get 7
      i32.const 1
      i32.add
      local.tee 7
      i32.const 2000
      i32.ne
      br_if 0 (;@1;)
    end
    i32.const 0
    local.set 4
    loop  ;; label = @1
      local.get 5
      local.get 4
      i32.const 1
      i32.or
      i32.add
      i64.load8_u
      local.get 11
      local.get 4
      local.get 5
      i32.add
      local.tee 3
      i64.load8_u
      i64.add
      i64.add
      local.get 3
      i64.load8_u offset=2
      i64.add
      local.get 3
      i64.load8_u offset=3
      i64.add
      local.get 3
      i64.load8_u offset=4
      i64.add
      local.get 3
      i64.load8_u offset=5
      i64.add
      local.set 11
      local.get 4
      i32.const 6
      i32.add
      local.tee 4
      i32.const 6000000
      i32.ne
      br_if 0 (;@1;)
    end
    local.get 5
    call $dlfree
    i32.const 8
    call $dlmalloc
    local.tee 3
    local.get 11
    i64.store align=1
    local.get 0
    i32.const 8
    i32.store offset=4
    local.get 0
    local.get 3
    i32.store
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer)
  (func $std::__2::complex<double>_std::__2::operator*_abi:v160004_<double>_std::__2::complex<double>_const&__std::__2::complex<double>_const&_ (type 5) (param i32 i32 i32)
    (local f64 f64 f64 f64 f64 f64 f64 f64 f64 f64 i32)
    local.get 1
    f64.load offset=8
    local.tee 5
    local.get 2
    f64.load
    local.tee 3
    f64.mul
    local.tee 9
    local.get 1
    f64.load
    local.tee 4
    local.get 2
    f64.load offset=8
    local.tee 6
    f64.mul
    local.tee 10
    f64.add
    local.set 7
    block  ;; label = @1
      local.get 4
      local.get 3
      f64.mul
      local.tee 11
      local.get 5
      local.get 6
      f64.mul
      local.tee 12
      f64.sub
      local.tee 8
      local.get 8
      f64.eq
      br_if 0 (;@1;)
      local.get 7
      local.get 7
      f64.eq
      br_if 0 (;@1;)
      block  ;; label = @2
        local.get 4
        f64.abs
        f64.const inf (;=inf;)
        f64.eq
        local.tee 2
        local.get 5
        f64.abs
        f64.const inf (;=inf;)
        f64.eq
        local.tee 1
        i32.or
        local.tee 13
        i32.eqz
        br_if 0 (;@2;)
        f64.const 0x1p+0 (;=1;)
        f64.const 0x0p+0 (;=0;)
        local.get 2
        select
        local.get 4
        f64.copysign
        local.set 4
        f64.const 0x1p+0 (;=1;)
        f64.const 0x0p+0 (;=0;)
        f64.const 0x1p+0 (;=1;)
        local.get 2
        select
        local.get 1
        select
        local.get 5
        f64.copysign
        local.set 5
        f64.const 0x0p+0 (;=0;)
        local.get 3
        f64.copysign
        local.get 3
        local.get 3
        local.get 3
        f64.ne
        select
        local.set 3
        local.get 6
        local.get 6
        f64.eq
        br_if 0 (;@2;)
        f64.const 0x0p+0 (;=0;)
        local.get 6
        f64.copysign
        local.set 6
      end
      block  ;; label = @2
        local.get 3
        f64.abs
        f64.const inf (;=inf;)
        f64.eq
        local.tee 1
        local.get 6
        f64.abs
        f64.const inf (;=inf;)
        f64.eq
        local.tee 2
        i32.or
        if  ;; label = @3
          f64.const 0x1p+0 (;=1;)
          f64.const 0x0p+0 (;=0;)
          local.get 1
          select
          local.get 3
          f64.copysign
          local.set 3
          f64.const 0x1p+0 (;=1;)
          f64.const 0x0p+0 (;=0;)
          f64.const 0x1p+0 (;=1;)
          local.get 1
          select
          local.get 2
          select
          local.get 6
          f64.copysign
          local.set 6
          f64.const 0x0p+0 (;=0;)
          local.get 4
          f64.copysign
          local.get 4
          local.get 4
          local.get 4
          f64.ne
          select
          local.set 4
          local.get 5
          local.get 5
          f64.eq
          br_if 1 (;@2;)
          f64.const 0x0p+0 (;=0;)
          local.get 5
          f64.copysign
          local.set 5
          br 1 (;@2;)
        end
        local.get 13
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 11
          f64.abs
          f64.const inf (;=inf;)
          f64.eq
          br_if 0 (;@3;)
          local.get 12
          f64.abs
          f64.const inf (;=inf;)
          f64.eq
          br_if 0 (;@3;)
          local.get 10
          f64.abs
          f64.const inf (;=inf;)
          f64.eq
          br_if 0 (;@3;)
          local.get 9
          f64.abs
          f64.const inf (;=inf;)
          f64.ne
          br_if 2 (;@1;)
        end
        f64.const 0x0p+0 (;=0;)
        local.get 3
        f64.copysign
        local.get 3
        local.get 3
        local.get 3
        f64.ne
        select
        local.set 3
        f64.const 0x0p+0 (;=0;)
        local.get 5
        f64.copysign
        local.get 5
        local.get 5
        local.get 5
        f64.ne
        select
        local.set 5
        f64.const 0x0p+0 (;=0;)
        local.get 4
        f64.copysign
        local.get 4
        local.get 4
        local.get 4
        f64.ne
        select
        local.set 4
        local.get 6
        local.get 6
        f64.eq
        br_if 0 (;@2;)
        f64.const 0x0p+0 (;=0;)
        local.get 6
        f64.copysign
        local.set 6
      end
      local.get 4
      local.get 6
      f64.mul
      local.get 3
      local.get 5
      f64.mul
      f64.add
      f64.const inf (;=inf;)
      f64.mul
      local.set 7
      local.get 4
      local.get 3
      f64.mul
      local.get 6
      local.get 5
      f64.mul
      f64.sub
      f64.const inf (;=inf;)
      f64.mul
      local.set 8
    end
    local.get 0
    local.get 7
    f64.store offset=8
    local.get 0
    local.get 8
    f64.store)
  (func $function (type 6) (param i32 i32) (result i32)
    (local i32 i32)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 2
    local.get 2
    i64.load offset=16 align=4
    i64.store offset=8
    local.get 2
    i32.const 24
    i32.add
    local.get 2
    i32.const 8
    i32.add
    call $foo_std::__2::span<char__4294967295ul>_
    i32.const 1028
    local.get 2
    i32.load offset=28
    i32.store
    local.get 2
    i32.load offset=24
    local.set 3
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 3)
  (func $get_output_size (type 1) (result i32)
    i32.const 1028
    i32.load)
  (func $alloc (type 0) (param i32) (result i32)
    local.get 0
    call $dlmalloc)
  (func $dealloc (type 2) (param i32)
    local.get 0
    call $dlfree)
  (func $_initialize (type 3)
    call $__wasm_call_ctors)
  (func $hypot (type 7) (param f64 f64) (result f64)
    (local i32 i64 i64 i64 i32 i32 f64)
    global.get $__stack_pointer
    i32.const 32
    i32.sub
    local.tee 2
    global.set $__stack_pointer
    local.get 0
    i64.reinterpret_f64
    i64.const 9223372036854775807
    i64.and
    local.tee 3
    local.get 1
    i64.reinterpret_f64
    i64.const 9223372036854775807
    i64.and
    local.tee 4
    local.get 3
    local.get 4
    i64.lt_u
    select
    local.tee 5
    f64.reinterpret_i64
    local.set 1
    block  ;; label = @1
      local.get 5
      i64.const 52
      i64.shr_u
      i32.wrap_i64
      local.tee 6
      i32.const 2047
      i32.eq
      br_if 0 (;@1;)
      local.get 3
      local.get 4
      local.get 3
      local.get 4
      i64.gt_u
      select
      local.tee 3
      f64.reinterpret_i64
      local.set 0
      block  ;; label = @2
        local.get 5
        i64.eqz
        br_if 0 (;@2;)
        local.get 3
        i64.const 52
        i64.shr_u
        i32.wrap_i64
        local.tee 7
        i32.const 2047
        i32.eq
        br_if 0 (;@2;)
        local.get 7
        local.get 6
        i32.sub
        i32.const 65
        i32.ge_s
        if  ;; label = @3
          local.get 0
          local.get 1
          f64.add
          local.set 1
          br 2 (;@1;)
        end
        block (result f64)  ;; label = @3
          local.get 7
          i32.const 1534
          i32.ge_u
          if  ;; label = @4
            local.get 1
            f64.const 0x1p-700 (;=1.90109e-211;)
            f64.mul
            local.set 1
            local.get 0
            f64.const 0x1p-700 (;=1.90109e-211;)
            f64.mul
            local.set 0
            f64.const 0x1p+700 (;=5.26014e+210;)
            br 1 (;@3;)
          end
          f64.const 0x1p+0 (;=1;)
          local.tee 8
          local.get 6
          i32.const 572
          i32.gt_u
          br_if 0 (;@3;)
          drop
          local.get 1
          f64.const 0x1p+700 (;=5.26014e+210;)
          f64.mul
          local.set 1
          local.get 0
          f64.const 0x1p+700 (;=5.26014e+210;)
          f64.mul
          local.set 0
          f64.const 0x1p-700 (;=1.90109e-211;)
        end
        local.set 8
        local.get 2
        i32.const 24
        i32.add
        local.get 2
        i32.const 16
        i32.add
        local.get 0
        call $sq
        local.get 2
        i32.const 8
        i32.add
        local.get 2
        local.get 1
        call $sq
        local.get 8
        local.get 2
        f64.load
        local.get 2
        f64.load offset=16
        f64.add
        local.get 2
        f64.load offset=8
        f64.add
        local.get 2
        f64.load offset=24
        f64.add
        call $sqrt
        f64.mul
        local.set 1
        br 1 (;@1;)
      end
      local.get 0
      local.set 1
    end
    local.get 2
    i32.const 32
    i32.add
    global.set $__stack_pointer
    local.get 1)
  (func $sq (type 8) (param i32 i32 f64)
    (local f64 f64)
    local.get 0
    local.get 2
    local.get 2
    f64.mul
    local.tee 4
    f64.store
    local.get 1
    local.get 2
    local.get 2
    f64.const 0x1.0000002p+27 (;=1.34218e+08;)
    f64.mul
    local.tee 3
    local.get 2
    local.get 3
    f64.sub
    f64.add
    local.tee 3
    f64.sub
    local.tee 2
    local.get 2
    f64.mul
    local.get 3
    local.get 3
    f64.add
    local.get 2
    f64.mul
    local.get 3
    local.get 3
    f64.mul
    local.get 4
    f64.sub
    f64.add
    f64.add
    f64.store)
  (func $sqrt (type 9) (param f64) (result f64)
    local.get 0
    f64.sqrt)
  (func $emscripten_get_heap_size (type 1) (result i32)
    memory.size
    i32.const 16
    i32.shl)
  (func $__errno_location (type 1) (result i32)
    i32.const 1032)
  (func $emscripten_resize_heap (type 0) (param i32) (result i32)
    i32.const 0)
  (func $sbrk (type 0) (param i32) (result i32)
    (local i32 i32)
    i32.const 1024
    i32.load
    local.tee 1
    local.get 0
    i32.const 7
    i32.add
    i32.const -8
    i32.and
    local.tee 2
    i32.add
    local.set 0
    block  ;; label = @1
      local.get 2
      i32.const 0
      local.get 0
      local.get 1
      i32.le_u
      select
      br_if 0 (;@1;)
      call $emscripten_get_heap_size
      local.get 0
      i32.lt_u
      if  ;; label = @2
        local.get 0
        call $emscripten_resize_heap
        i32.eqz
        br_if 1 (;@1;)
      end
      i32.const 1024
      local.get 0
      i32.store
      local.get 1
      return
    end
    call $__errno_location
    i32.const 48
    i32.store
    i32.const -1)
  (func $dlmalloc (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32 i32 i32 i32)
    global.get $__stack_pointer
    i32.const 16
    i32.sub
    local.tee 10
    global.set $__stack_pointer
    block  ;; label = @1
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              block  ;; label = @6
                block  ;; label = @7
                  block  ;; label = @8
                    block  ;; label = @9
                      block  ;; label = @10
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              block  ;; label = @14
                                local.get 0
                                i32.const 244
                                i32.le_u
                                if  ;; label = @15
                                  i32.const 1036
                                  i32.load
                                  local.tee 6
                                  i32.const 16
                                  local.get 0
                                  i32.const 11
                                  i32.add
                                  i32.const -8
                                  i32.and
                                  local.get 0
                                  i32.const 11
                                  i32.lt_u
                                  select
                                  local.tee 5
                                  i32.const 3
                                  i32.shr_u
                                  local.tee 1
                                  i32.shr_u
                                  local.tee 0
                                  i32.const 3
                                  i32.and
                                  if  ;; label = @16
                                    block  ;; label = @17
                                      local.get 0
                                      i32.const -1
                                      i32.xor
                                      i32.const 1
                                      i32.and
                                      local.get 1
                                      i32.add
                                      local.tee 3
                                      i32.const 3
                                      i32.shl
                                      local.tee 1
                                      i32.const 1076
                                      i32.add
                                      local.tee 0
                                      local.get 1
                                      i32.const 1084
                                      i32.add
                                      i32.load
                                      local.tee 1
                                      i32.load offset=8
                                      local.tee 5
                                      i32.eq
                                      if  ;; label = @18
                                        i32.const 1036
                                        local.get 6
                                        i32.const -2
                                        local.get 3
                                        i32.rotl
                                        i32.and
                                        i32.store
                                        br 1 (;@17;)
                                      end
                                      local.get 5
                                      local.get 0
                                      i32.store offset=12
                                      local.get 0
                                      local.get 5
                                      i32.store offset=8
                                    end
                                    local.get 1
                                    i32.const 8
                                    i32.add
                                    local.set 0
                                    local.get 1
                                    local.get 3
                                    i32.const 3
                                    i32.shl
                                    local.tee 3
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 1
                                    local.get 3
                                    i32.add
                                    local.tee 1
                                    local.get 1
                                    i32.load offset=4
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    br 15 (;@1;)
                                  end
                                  local.get 5
                                  i32.const 1044
                                  i32.load
                                  local.tee 8
                                  i32.le_u
                                  br_if 1 (;@14;)
                                  local.get 0
                                  if  ;; label = @16
                                    block  ;; label = @17
                                      local.get 0
                                      local.get 1
                                      i32.shl
                                      i32.const 2
                                      local.get 1
                                      i32.shl
                                      local.tee 0
                                      i32.const 0
                                      local.get 0
                                      i32.sub
                                      i32.or
                                      i32.and
                                      i32.ctz
                                      local.tee 1
                                      i32.const 3
                                      i32.shl
                                      local.tee 0
                                      i32.const 1076
                                      i32.add
                                      local.tee 3
                                      local.get 0
                                      i32.const 1084
                                      i32.add
                                      i32.load
                                      local.tee 0
                                      i32.load offset=8
                                      local.tee 2
                                      i32.eq
                                      if  ;; label = @18
                                        i32.const 1036
                                        local.get 6
                                        i32.const -2
                                        local.get 1
                                        i32.rotl
                                        i32.and
                                        local.tee 6
                                        i32.store
                                        br 1 (;@17;)
                                      end
                                      local.get 2
                                      local.get 3
                                      i32.store offset=12
                                      local.get 3
                                      local.get 2
                                      i32.store offset=8
                                    end
                                    local.get 0
                                    local.get 5
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    local.get 0
                                    local.get 5
                                    i32.add
                                    local.tee 2
                                    local.get 1
                                    i32.const 3
                                    i32.shl
                                    local.tee 1
                                    local.get 5
                                    i32.sub
                                    local.tee 3
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    local.get 0
                                    local.get 1
                                    i32.add
                                    local.get 3
                                    i32.store
                                    local.get 8
                                    if  ;; label = @17
                                      local.get 8
                                      i32.const -8
                                      i32.and
                                      i32.const 1076
                                      i32.add
                                      local.set 5
                                      i32.const 1056
                                      i32.load
                                      local.set 1
                                      block (result i32)  ;; label = @18
                                        local.get 6
                                        i32.const 1
                                        local.get 8
                                        i32.const 3
                                        i32.shr_u
                                        i32.shl
                                        local.tee 4
                                        i32.and
                                        i32.eqz
                                        if  ;; label = @19
                                          i32.const 1036
                                          local.get 4
                                          local.get 6
                                          i32.or
                                          i32.store
                                          local.get 5
                                          br 1 (;@18;)
                                        end
                                        local.get 5
                                        i32.load offset=8
                                      end
                                      local.set 4
                                      local.get 5
                                      local.get 1
                                      i32.store offset=8
                                      local.get 4
                                      local.get 1
                                      i32.store offset=12
                                      local.get 1
                                      local.get 5
                                      i32.store offset=12
                                      local.get 1
                                      local.get 4
                                      i32.store offset=8
                                    end
                                    local.get 0
                                    i32.const 8
                                    i32.add
                                    local.set 0
                                    i32.const 1056
                                    local.get 2
                                    i32.store
                                    i32.const 1044
                                    local.get 3
                                    i32.store
                                    br 15 (;@1;)
                                  end
                                  i32.const 1040
                                  i32.load
                                  local.tee 11
                                  i32.eqz
                                  br_if 1 (;@14;)
                                  local.get 11
                                  i32.ctz
                                  i32.const 2
                                  i32.shl
                                  i32.const 1340
                                  i32.add
                                  i32.load
                                  local.tee 2
                                  i32.load offset=4
                                  i32.const -8
                                  i32.and
                                  local.get 5
                                  i32.sub
                                  local.set 1
                                  local.get 2
                                  local.set 3
                                  loop  ;; label = @16
                                    block  ;; label = @17
                                      local.get 3
                                      i32.load offset=16
                                      local.tee 0
                                      i32.eqz
                                      if  ;; label = @18
                                        local.get 3
                                        i32.load offset=20
                                        local.tee 0
                                        i32.eqz
                                        br_if 1 (;@17;)
                                      end
                                      local.get 0
                                      i32.load offset=4
                                      i32.const -8
                                      i32.and
                                      local.get 5
                                      i32.sub
                                      local.tee 3
                                      local.get 1
                                      local.get 1
                                      local.get 3
                                      i32.gt_u
                                      local.tee 3
                                      select
                                      local.set 1
                                      local.get 0
                                      local.get 2
                                      local.get 3
                                      select
                                      local.set 2
                                      local.get 0
                                      local.set 3
                                      br 1 (;@16;)
                                    end
                                  end
                                  local.get 2
                                  i32.load offset=24
                                  local.set 9
                                  local.get 2
                                  local.get 2
                                  i32.load offset=12
                                  local.tee 4
                                  i32.ne
                                  if  ;; label = @16
                                    i32.const 1052
                                    i32.load
                                    drop
                                    local.get 2
                                    i32.load offset=8
                                    local.tee 0
                                    local.get 4
                                    i32.store offset=12
                                    local.get 4
                                    local.get 0
                                    i32.store offset=8
                                    br 14 (;@2;)
                                  end
                                  local.get 2
                                  i32.const 20
                                  i32.add
                                  local.tee 3
                                  i32.load
                                  local.tee 0
                                  i32.eqz
                                  if  ;; label = @16
                                    local.get 2
                                    i32.load offset=16
                                    local.tee 0
                                    i32.eqz
                                    br_if 3 (;@13;)
                                    local.get 2
                                    i32.const 16
                                    i32.add
                                    local.set 3
                                  end
                                  loop  ;; label = @16
                                    local.get 3
                                    local.set 7
                                    local.get 0
                                    local.tee 4
                                    i32.const 20
                                    i32.add
                                    local.tee 3
                                    i32.load
                                    local.tee 0
                                    br_if 0 (;@16;)
                                    local.get 4
                                    i32.const 16
                                    i32.add
                                    local.set 3
                                    local.get 4
                                    i32.load offset=16
                                    local.tee 0
                                    br_if 0 (;@16;)
                                  end
                                  local.get 7
                                  i32.const 0
                                  i32.store
                                  br 13 (;@2;)
                                end
                                i32.const -1
                                local.set 5
                                local.get 0
                                i32.const -65
                                i32.gt_u
                                br_if 0 (;@14;)
                                local.get 0
                                i32.const 11
                                i32.add
                                local.tee 0
                                i32.const -8
                                i32.and
                                local.set 5
                                i32.const 1040
                                i32.load
                                local.tee 8
                                i32.eqz
                                br_if 0 (;@14;)
                                i32.const 0
                                local.get 5
                                i32.sub
                                local.set 1
                                block  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block (result i32)  ;; label = @18
                                        i32.const 0
                                        local.get 5
                                        i32.const 256
                                        i32.lt_u
                                        br_if 0 (;@18;)
                                        drop
                                        i32.const 31
                                        local.tee 7
                                        local.get 5
                                        i32.const 16777215
                                        i32.gt_u
                                        br_if 0 (;@18;)
                                        drop
                                        local.get 5
                                        i32.const 38
                                        local.get 0
                                        i32.const 8
                                        i32.shr_u
                                        i32.clz
                                        local.tee 0
                                        i32.sub
                                        i32.shr_u
                                        i32.const 1
                                        i32.and
                                        local.get 0
                                        i32.const 1
                                        i32.shl
                                        i32.sub
                                        i32.const 62
                                        i32.add
                                      end
                                      local.tee 7
                                      i32.const 2
                                      i32.shl
                                      i32.const 1340
                                      i32.add
                                      i32.load
                                      local.tee 3
                                      i32.eqz
                                      if  ;; label = @18
                                        i32.const 0
                                        local.set 0
                                        br 1 (;@17;)
                                      end
                                      i32.const 0
                                      local.set 0
                                      local.get 5
                                      i32.const 25
                                      local.get 7
                                      i32.const 1
                                      i32.shr_u
                                      i32.sub
                                      i32.const 0
                                      local.get 7
                                      i32.const 31
                                      i32.ne
                                      select
                                      i32.shl
                                      local.set 2
                                      loop  ;; label = @18
                                        block  ;; label = @19
                                          local.get 3
                                          i32.load offset=4
                                          i32.const -8
                                          i32.and
                                          local.get 5
                                          i32.sub
                                          local.tee 6
                                          local.get 1
                                          i32.ge_u
                                          br_if 0 (;@19;)
                                          local.get 3
                                          local.set 4
                                          local.get 6
                                          local.tee 1
                                          br_if 0 (;@19;)
                                          i32.const 0
                                          local.set 1
                                          local.get 3
                                          local.set 0
                                          br 3 (;@16;)
                                        end
                                        local.get 0
                                        local.get 3
                                        i32.load offset=20
                                        local.tee 6
                                        local.get 6
                                        local.get 3
                                        local.get 2
                                        i32.const 29
                                        i32.shr_u
                                        i32.const 4
                                        i32.and
                                        i32.add
                                        i32.load offset=16
                                        local.tee 3
                                        i32.eq
                                        select
                                        local.get 0
                                        local.get 6
                                        select
                                        local.set 0
                                        local.get 2
                                        i32.const 1
                                        i32.shl
                                        local.set 2
                                        local.get 3
                                        br_if 0 (;@18;)
                                      end
                                    end
                                    local.get 0
                                    local.get 4
                                    i32.or
                                    i32.eqz
                                    if  ;; label = @17
                                      i32.const 0
                                      local.set 4
                                      i32.const 2
                                      local.get 7
                                      i32.shl
                                      local.tee 0
                                      i32.const 0
                                      local.get 0
                                      i32.sub
                                      i32.or
                                      local.get 8
                                      i32.and
                                      local.tee 0
                                      i32.eqz
                                      br_if 3 (;@14;)
                                      local.get 0
                                      i32.ctz
                                      i32.const 2
                                      i32.shl
                                      i32.const 1340
                                      i32.add
                                      i32.load
                                      local.set 0
                                    end
                                    local.get 0
                                    i32.eqz
                                    br_if 1 (;@15;)
                                  end
                                  loop  ;; label = @16
                                    local.get 0
                                    i32.load offset=4
                                    i32.const -8
                                    i32.and
                                    local.get 5
                                    i32.sub
                                    local.tee 6
                                    local.get 1
                                    i32.lt_u
                                    local.set 2
                                    local.get 6
                                    local.get 1
                                    local.get 2
                                    select
                                    local.set 1
                                    local.get 0
                                    local.get 4
                                    local.get 2
                                    select
                                    local.set 4
                                    local.get 0
                                    i32.load offset=16
                                    local.tee 3
                                    i32.eqz
                                    if  ;; label = @17
                                      local.get 0
                                      i32.load offset=20
                                      local.set 3
                                    end
                                    local.get 3
                                    local.tee 0
                                    br_if 0 (;@16;)
                                  end
                                end
                                local.get 4
                                i32.eqz
                                br_if 0 (;@14;)
                                local.get 1
                                i32.const 1044
                                i32.load
                                local.get 5
                                i32.sub
                                i32.ge_u
                                br_if 0 (;@14;)
                                local.get 4
                                i32.load offset=24
                                local.set 7
                                local.get 4
                                local.get 4
                                i32.load offset=12
                                local.tee 2
                                i32.ne
                                if  ;; label = @15
                                  i32.const 1052
                                  i32.load
                                  drop
                                  local.get 4
                                  i32.load offset=8
                                  local.tee 0
                                  local.get 2
                                  i32.store offset=12
                                  local.get 2
                                  local.get 0
                                  i32.store offset=8
                                  br 12 (;@3;)
                                end
                                local.get 4
                                i32.const 20
                                i32.add
                                local.tee 3
                                i32.load
                                local.tee 0
                                i32.eqz
                                if  ;; label = @15
                                  local.get 4
                                  i32.load offset=16
                                  local.tee 0
                                  i32.eqz
                                  br_if 3 (;@12;)
                                  local.get 4
                                  i32.const 16
                                  i32.add
                                  local.set 3
                                end
                                loop  ;; label = @15
                                  local.get 3
                                  local.set 6
                                  local.get 0
                                  local.tee 2
                                  i32.const 20
                                  i32.add
                                  local.tee 3
                                  i32.load
                                  local.tee 0
                                  br_if 0 (;@15;)
                                  local.get 2
                                  i32.const 16
                                  i32.add
                                  local.set 3
                                  local.get 2
                                  i32.load offset=16
                                  local.tee 0
                                  br_if 0 (;@15;)
                                end
                                local.get 6
                                i32.const 0
                                i32.store
                                br 11 (;@3;)
                              end
                              local.get 5
                              i32.const 1044
                              i32.load
                              local.tee 0
                              i32.le_u
                              if  ;; label = @14
                                i32.const 1056
                                i32.load
                                local.set 1
                                block  ;; label = @15
                                  local.get 0
                                  local.get 5
                                  i32.sub
                                  local.tee 3
                                  i32.const 16
                                  i32.ge_u
                                  if  ;; label = @16
                                    local.get 1
                                    local.get 5
                                    i32.add
                                    local.tee 2
                                    local.get 3
                                    i32.const 1
                                    i32.or
                                    i32.store offset=4
                                    local.get 0
                                    local.get 1
                                    i32.add
                                    local.get 3
                                    i32.store
                                    local.get 1
                                    local.get 5
                                    i32.const 3
                                    i32.or
                                    i32.store offset=4
                                    br 1 (;@15;)
                                  end
                                  local.get 1
                                  local.get 0
                                  i32.const 3
                                  i32.or
                                  i32.store offset=4
                                  local.get 0
                                  local.get 1
                                  i32.add
                                  local.tee 0
                                  local.get 0
                                  i32.load offset=4
                                  i32.const 1
                                  i32.or
                                  i32.store offset=4
                                  i32.const 0
                                  local.set 2
                                  i32.const 0
                                  local.set 3
                                end
                                i32.const 1044
                                local.get 3
                                i32.store
                                i32.const 1056
                                local.get 2
                                i32.store
                                local.get 1
                                i32.const 8
                                i32.add
                                local.set 0
                                br 13 (;@1;)
                              end
                              local.get 5
                              i32.const 1048
                              i32.load
                              local.tee 2
                              i32.lt_u
                              if  ;; label = @14
                                i32.const 1048
                                local.get 2
                                local.get 5
                                i32.sub
                                local.tee 1
                                i32.store
                                i32.const 1060
                                i32.const 1060
                                i32.load
                                local.tee 0
                                local.get 5
                                i32.add
                                local.tee 3
                                i32.store
                                local.get 3
                                local.get 1
                                i32.const 1
                                i32.or
                                i32.store offset=4
                                local.get 0
                                local.get 5
                                i32.const 3
                                i32.or
                                i32.store offset=4
                                local.get 0
                                i32.const 8
                                i32.add
                                local.set 0
                                br 13 (;@1;)
                              end
                              i32.const 0
                              local.set 0
                              local.get 5
                              i32.const 47
                              i32.add
                              local.tee 8
                              block (result i32)  ;; label = @14
                                i32.const 1508
                                i32.load
                                if  ;; label = @15
                                  i32.const 1516
                                  i32.load
                                  br 1 (;@14;)
                                end
                                i32.const 1520
                                i64.const -1
                                i64.store align=4
                                i32.const 1512
                                i64.const 17592186048512
                                i64.store align=4
                                i32.const 1508
                                local.get 10
                                i32.const 12
                                i32.add
                                i32.const -16
                                i32.and
                                i32.const 1431655768
                                i32.xor
                                i32.store
                                i32.const 1528
                                i32.const 0
                                i32.store
                                i32.const 1480
                                i32.const 0
                                i32.store
                                i32.const 4096
                              end
                              local.tee 1
                              i32.add
                              local.tee 6
                              i32.const 0
                              local.get 1
                              i32.sub
                              local.tee 7
                              i32.and
                              local.tee 4
                              local.get 5
                              i32.le_u
                              br_if 12 (;@1;)
                              i32.const 1476
                              i32.load
                              local.tee 1
                              if  ;; label = @14
                                i32.const 1468
                                i32.load
                                local.tee 3
                                local.get 4
                                i32.add
                                local.tee 9
                                local.get 3
                                i32.le_u
                                br_if 13 (;@1;)
                                local.get 1
                                local.get 9
                                i32.lt_u
                                br_if 13 (;@1;)
                              end
                              block  ;; label = @14
                                i32.const 1480
                                i32.load8_u
                                i32.const 4
                                i32.and
                                i32.eqz
                                if  ;; label = @15
                                  block  ;; label = @16
                                    block  ;; label = @17
                                      block  ;; label = @18
                                        block  ;; label = @19
                                          i32.const 1060
                                          i32.load
                                          local.tee 1
                                          if  ;; label = @20
                                            i32.const 1484
                                            local.set 0
                                            loop  ;; label = @21
                                              local.get 1
                                              local.get 0
                                              i32.load
                                              local.tee 3
                                              i32.ge_u
                                              if  ;; label = @22
                                                local.get 3
                                                local.get 0
                                                i32.load offset=4
                                                i32.add
                                                local.get 1
                                                i32.gt_u
                                                br_if 3 (;@19;)
                                              end
                                              local.get 0
                                              i32.load offset=8
                                              local.tee 0
                                              br_if 0 (;@21;)
                                            end
                                          end
                                          i32.const 0
                                          call $sbrk
                                          local.tee 2
                                          i32.const -1
                                          i32.eq
                                          br_if 3 (;@16;)
                                          local.get 4
                                          local.set 6
                                          i32.const 1512
                                          i32.load
                                          local.tee 0
                                          i32.const 1
                                          i32.sub
                                          local.tee 1
                                          local.get 2
                                          i32.and
                                          if  ;; label = @20
                                            local.get 4
                                            local.get 2
                                            i32.sub
                                            local.get 1
                                            local.get 2
                                            i32.add
                                            i32.const 0
                                            local.get 0
                                            i32.sub
                                            i32.and
                                            i32.add
                                            local.set 6
                                          end
                                          local.get 5
                                          local.get 6
                                          i32.ge_u
                                          br_if 3 (;@16;)
                                          i32.const 1476
                                          i32.load
                                          local.tee 0
                                          if  ;; label = @20
                                            i32.const 1468
                                            i32.load
                                            local.tee 1
                                            local.get 6
                                            i32.add
                                            local.tee 3
                                            local.get 1
                                            i32.le_u
                                            br_if 4 (;@16;)
                                            local.get 0
                                            local.get 3
                                            i32.lt_u
                                            br_if 4 (;@16;)
                                          end
                                          local.get 6
                                          call $sbrk
                                          local.tee 0
                                          local.get 2
                                          i32.ne
                                          br_if 1 (;@18;)
                                          br 5 (;@14;)
                                        end
                                        local.get 6
                                        local.get 2
                                        i32.sub
                                        local.get 7
                                        i32.and
                                        local.tee 6
                                        call $sbrk
                                        local.tee 2
                                        local.get 0
                                        i32.load
                                        local.get 0
                                        i32.load offset=4
                                        i32.add
                                        i32.eq
                                        br_if 1 (;@17;)
                                        local.get 2
                                        local.set 0
                                      end
                                      local.get 0
                                      i32.const -1
                                      i32.eq
                                      br_if 1 (;@16;)
                                      local.get 5
                                      i32.const 48
                                      i32.add
                                      local.get 6
                                      i32.le_u
                                      if  ;; label = @18
                                        local.get 0
                                        local.set 2
                                        br 4 (;@14;)
                                      end
                                      i32.const 1516
                                      i32.load
                                      local.tee 1
                                      local.get 8
                                      local.get 6
                                      i32.sub
                                      i32.add
                                      i32.const 0
                                      local.get 1
                                      i32.sub
                                      i32.and
                                      local.tee 1
                                      call $sbrk
                                      i32.const -1
                                      i32.eq
                                      br_if 1 (;@16;)
                                      local.get 1
                                      local.get 6
                                      i32.add
                                      local.set 6
                                      local.get 0
                                      local.set 2
                                      br 3 (;@14;)
                                    end
                                    local.get 2
                                    i32.const -1
                                    i32.ne
                                    br_if 2 (;@14;)
                                  end
                                  i32.const 1480
                                  i32.const 1480
                                  i32.load
                                  i32.const 4
                                  i32.or
                                  i32.store
                                end
                                local.get 4
                                call $sbrk
                                local.set 2
                                i32.const 0
                                call $sbrk
                                local.set 0
                                local.get 2
                                i32.const -1
                                i32.eq
                                br_if 5 (;@9;)
                                local.get 0
                                i32.const -1
                                i32.eq
                                br_if 5 (;@9;)
                                local.get 0
                                local.get 2
                                i32.le_u
                                br_if 5 (;@9;)
                                local.get 0
                                local.get 2
                                i32.sub
                                local.tee 6
                                local.get 5
                                i32.const 40
                                i32.add
                                i32.le_u
                                br_if 5 (;@9;)
                              end
                              i32.const 1468
                              i32.const 1468
                              i32.load
                              local.get 6
                              i32.add
                              local.tee 0
                              i32.store
                              i32.const 1472
                              i32.load
                              local.get 0
                              i32.lt_u
                              if  ;; label = @14
                                i32.const 1472
                                local.get 0
                                i32.store
                              end
                              block  ;; label = @14
                                i32.const 1060
                                i32.load
                                local.tee 1
                                if  ;; label = @15
                                  i32.const 1484
                                  local.set 0
                                  loop  ;; label = @16
                                    local.get 2
                                    local.get 0
                                    i32.load
                                    local.tee 3
                                    local.get 0
                                    i32.load offset=4
                                    local.tee 4
                                    i32.add
                                    i32.eq
                                    br_if 2 (;@14;)
                                    local.get 0
                                    i32.load offset=8
                                    local.tee 0
                                    br_if 0 (;@16;)
                                  end
                                  br 4 (;@11;)
                                end
                                i32.const 1052
                                i32.load
                                local.tee 0
                                i32.const 0
                                local.get 0
                                local.get 2
                                i32.le_u
                                select
                                i32.eqz
                                if  ;; label = @15
                                  i32.const 1052
                                  local.get 2
                                  i32.store
                                end
                                i32.const 0
                                local.set 0
                                i32.const 1488
                                local.get 6
                                i32.store
                                i32.const 1484
                                local.get 2
                                i32.store
                                i32.const 1068
                                i32.const -1
                                i32.store
                                i32.const 1072
                                i32.const 1508
                                i32.load
                                i32.store
                                i32.const 1496
                                i32.const 0
                                i32.store
                                loop  ;; label = @15
                                  local.get 0
                                  i32.const 3
                                  i32.shl
                                  local.tee 1
                                  i32.const 1084
                                  i32.add
                                  local.get 1
                                  i32.const 1076
                                  i32.add
                                  local.tee 3
                                  i32.store
                                  local.get 1
                                  i32.const 1088
                                  i32.add
                                  local.get 3
                                  i32.store
                                  local.get 0
                                  i32.const 1
                                  i32.add
                                  local.tee 0
                                  i32.const 32
                                  i32.ne
                                  br_if 0 (;@15;)
                                end
                                i32.const 1048
                                local.get 6
                                i32.const 40
                                i32.sub
                                local.tee 0
                                i32.const -8
                                local.get 2
                                i32.sub
                                i32.const 7
                                i32.and
                                local.tee 1
                                i32.sub
                                local.tee 3
                                i32.store
                                i32.const 1060
                                local.get 1
                                local.get 2
                                i32.add
                                local.tee 1
                                i32.store
                                local.get 1
                                local.get 3
                                i32.const 1
                                i32.or
                                i32.store offset=4
                                local.get 0
                                local.get 2
                                i32.add
                                i32.const 40
                                i32.store offset=4
                                i32.const 1064
                                i32.const 1524
                                i32.load
                                i32.store
                                br 4 (;@10;)
                              end
                              local.get 1
                              local.get 2
                              i32.ge_u
                              br_if 2 (;@11;)
                              local.get 1
                              local.get 3
                              i32.lt_u
                              br_if 2 (;@11;)
                              local.get 0
                              i32.load offset=12
                              i32.const 8
                              i32.and
                              br_if 2 (;@11;)
                              local.get 0
                              local.get 4
                              local.get 6
                              i32.add
                              i32.store offset=4
                              i32.const 1060
                              local.get 1
                              i32.const -8
                              local.get 1
                              i32.sub
                              i32.const 7
                              i32.and
                              local.tee 0
                              i32.add
                              local.tee 3
                              i32.store
                              i32.const 1048
                              i32.const 1048
                              i32.load
                              local.get 6
                              i32.add
                              local.tee 2
                              local.get 0
                              i32.sub
                              local.tee 0
                              i32.store
                              local.get 3
                              local.get 0
                              i32.const 1
                              i32.or
                              i32.store offset=4
                              local.get 1
                              local.get 2
                              i32.add
                              i32.const 40
                              i32.store offset=4
                              i32.const 1064
                              i32.const 1524
                              i32.load
                              i32.store
                              br 3 (;@10;)
                            end
                            i32.const 0
                            local.set 4
                            br 10 (;@2;)
                          end
                          i32.const 0
                          local.set 2
                          br 8 (;@3;)
                        end
                        i32.const 1052
                        i32.load
                        local.tee 4
                        local.get 2
                        i32.gt_u
                        if  ;; label = @11
                          i32.const 1052
                          local.get 2
                          i32.store
                          local.get 2
                          local.set 4
                        end
                        local.get 2
                        local.get 6
                        i32.add
                        local.set 3
                        i32.const 1484
                        local.set 0
                        block  ;; label = @11
                          block  ;; label = @12
                            block  ;; label = @13
                              loop  ;; label = @14
                                local.get 3
                                local.get 0
                                i32.load
                                i32.ne
                                if  ;; label = @15
                                  local.get 0
                                  i32.load offset=8
                                  local.tee 0
                                  br_if 1 (;@14;)
                                  br 2 (;@13;)
                                end
                              end
                              local.get 0
                              i32.load8_u offset=12
                              i32.const 8
                              i32.and
                              i32.eqz
                              br_if 1 (;@12;)
                            end
                            i32.const 1484
                            local.set 0
                            loop  ;; label = @13
                              local.get 1
                              local.get 0
                              i32.load
                              local.tee 3
                              i32.ge_u
                              if  ;; label = @14
                                local.get 3
                                local.get 0
                                i32.load offset=4
                                i32.add
                                local.tee 3
                                local.get 1
                                i32.gt_u
                                br_if 3 (;@11;)
                              end
                              local.get 0
                              i32.load offset=8
                              local.set 0
                              br 0 (;@13;)
                            end
                            unreachable
                          end
                          local.get 0
                          local.get 2
                          i32.store
                          local.get 0
                          local.get 0
                          i32.load offset=4
                          local.get 6
                          i32.add
                          i32.store offset=4
                          local.get 2
                          i32.const -8
                          local.get 2
                          i32.sub
                          i32.const 7
                          i32.and
                          i32.add
                          local.tee 7
                          local.get 5
                          i32.const 3
                          i32.or
                          i32.store offset=4
                          local.get 3
                          i32.const -8
                          local.get 3
                          i32.sub
                          i32.const 7
                          i32.and
                          i32.add
                          local.tee 6
                          local.get 5
                          local.get 7
                          i32.add
                          local.tee 5
                          i32.sub
                          local.set 0
                          local.get 1
                          local.get 6
                          i32.eq
                          if  ;; label = @12
                            i32.const 1060
                            local.get 5
                            i32.store
                            i32.const 1048
                            i32.const 1048
                            i32.load
                            local.get 0
                            i32.add
                            local.tee 0
                            i32.store
                            local.get 5
                            local.get 0
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            br 8 (;@4;)
                          end
                          i32.const 1056
                          i32.load
                          local.get 6
                          i32.eq
                          if  ;; label = @12
                            i32.const 1056
                            local.get 5
                            i32.store
                            i32.const 1044
                            i32.const 1044
                            i32.load
                            local.get 0
                            i32.add
                            local.tee 0
                            i32.store
                            local.get 5
                            local.get 0
                            i32.const 1
                            i32.or
                            i32.store offset=4
                            local.get 0
                            local.get 5
                            i32.add
                            local.get 0
                            i32.store
                            br 8 (;@4;)
                          end
                          local.get 6
                          i32.load offset=4
                          local.tee 1
                          i32.const 3
                          i32.and
                          i32.const 1
                          i32.ne
                          br_if 6 (;@5;)
                          local.get 1
                          i32.const -8
                          i32.and
                          local.set 8
                          local.get 1
                          i32.const 255
                          i32.le_u
                          if  ;; label = @12
                            local.get 1
                            i32.const 3
                            i32.shr_u
                            local.tee 4
                            i32.const 3
                            i32.shl
                            i32.const 1076
                            i32.add
                            local.set 2
                            local.get 6
                            i32.load offset=12
                            local.tee 1
                            local.get 6
                            i32.load offset=8
                            local.tee 3
                            i32.eq
                            if  ;; label = @13
                              i32.const 1036
                              i32.const 1036
                              i32.load
                              i32.const -2
                              local.get 4
                              i32.rotl
                              i32.and
                              i32.store
                              br 7 (;@6;)
                            end
                            local.get 3
                            local.get 1
                            i32.store offset=12
                            local.get 1
                            local.get 3
                            i32.store offset=8
                            br 6 (;@6;)
                          end
                          local.get 6
                          i32.load offset=24
                          local.set 9
                          local.get 6
                          local.get 6
                          i32.load offset=12
                          local.tee 2
                          i32.ne
                          if  ;; label = @12
                            local.get 6
                            i32.load offset=8
                            local.tee 1
                            local.get 2
                            i32.store offset=12
                            local.get 2
                            local.get 1
                            i32.store offset=8
                            br 5 (;@7;)
                          end
                          local.get 6
                          i32.const 20
                          i32.add
                          local.tee 3
                          i32.load
                          local.tee 1
                          i32.eqz
                          if  ;; label = @12
                            local.get 6
                            i32.load offset=16
                            local.tee 1
                            i32.eqz
                            br_if 4 (;@8;)
                            local.get 6
                            i32.const 16
                            i32.add
                            local.set 3
                          end
                          loop  ;; label = @12
                            local.get 3
                            local.set 4
                            local.get 1
                            local.tee 2
                            i32.const 20
                            i32.add
                            local.tee 3
                            i32.load
                            local.tee 1
                            br_if 0 (;@12;)
                            local.get 2
                            i32.const 16
                            i32.add
                            local.set 3
                            local.get 2
                            i32.load offset=16
                            local.tee 1
                            br_if 0 (;@12;)
                          end
                          local.get 4
                          i32.const 0
                          i32.store
                          br 4 (;@7;)
                        end
                        i32.const 1048
                        local.get 6
                        i32.const 40
                        i32.sub
                        local.tee 0
                        i32.const -8
                        local.get 2
                        i32.sub
                        i32.const 7
                        i32.and
                        local.tee 4
                        i32.sub
                        local.tee 7
                        i32.store
                        i32.const 1060
                        local.get 2
                        local.get 4
                        i32.add
                        local.tee 4
                        i32.store
                        local.get 4
                        local.get 7
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 0
                        local.get 2
                        i32.add
                        i32.const 40
                        i32.store offset=4
                        i32.const 1064
                        i32.const 1524
                        i32.load
                        i32.store
                        local.get 1
                        local.get 3
                        i32.const 39
                        local.get 3
                        i32.sub
                        i32.const 7
                        i32.and
                        i32.add
                        i32.const 47
                        i32.sub
                        local.tee 0
                        local.get 0
                        local.get 1
                        i32.const 16
                        i32.add
                        i32.lt_u
                        select
                        local.tee 4
                        i32.const 27
                        i32.store offset=4
                        local.get 4
                        i32.const 1492
                        i64.load align=4
                        i64.store offset=16 align=4
                        local.get 4
                        i32.const 1484
                        i64.load align=4
                        i64.store offset=8 align=4
                        i32.const 1492
                        local.get 4
                        i32.const 8
                        i32.add
                        i32.store
                        i32.const 1488
                        local.get 6
                        i32.store
                        i32.const 1484
                        local.get 2
                        i32.store
                        i32.const 1496
                        i32.const 0
                        i32.store
                        local.get 4
                        i32.const 24
                        i32.add
                        local.set 0
                        loop  ;; label = @11
                          local.get 0
                          i32.const 7
                          i32.store offset=4
                          local.get 0
                          i32.const 8
                          i32.add
                          local.set 2
                          local.get 0
                          i32.const 4
                          i32.add
                          local.set 0
                          local.get 2
                          local.get 3
                          i32.lt_u
                          br_if 0 (;@11;)
                        end
                        local.get 1
                        local.get 4
                        i32.eq
                        br_if 0 (;@10;)
                        local.get 4
                        local.get 4
                        i32.load offset=4
                        i32.const -2
                        i32.and
                        i32.store offset=4
                        local.get 1
                        local.get 4
                        local.get 1
                        i32.sub
                        local.tee 2
                        i32.const 1
                        i32.or
                        i32.store offset=4
                        local.get 4
                        local.get 2
                        i32.store
                        local.get 2
                        i32.const 255
                        i32.le_u
                        if  ;; label = @11
                          local.get 2
                          i32.const -8
                          i32.and
                          i32.const 1076
                          i32.add
                          local.set 0
                          block (result i32)  ;; label = @12
                            i32.const 1036
                            i32.load
                            local.tee 3
                            i32.const 1
                            local.get 2
                            i32.const 3
                            i32.shr_u
                            i32.shl
                            local.tee 2
                            i32.and
                            i32.eqz
                            if  ;; label = @13
                              i32.const 1036
                              local.get 2
                              local.get 3
                              i32.or
                              i32.store
                              local.get 0
                              br 1 (;@12;)
                            end
                            local.get 0
                            i32.load offset=8
                          end
                          local.set 3
                          local.get 0
                          local.get 1
                          i32.store offset=8
                          local.get 3
                          local.get 1
                          i32.store offset=12
                          local.get 1
                          local.get 0
                          i32.store offset=12
                          local.get 1
                          local.get 3
                          i32.store offset=8
                          br 1 (;@10;)
                        end
                        i32.const 31
                        local.set 0
                        local.get 2
                        i32.const 16777215
                        i32.le_u
                        if  ;; label = @11
                          local.get 2
                          i32.const 38
                          local.get 2
                          i32.const 8
                          i32.shr_u
                          i32.clz
                          local.tee 0
                          i32.sub
                          i32.shr_u
                          i32.const 1
                          i32.and
                          local.get 0
                          i32.const 1
                          i32.shl
                          i32.sub
                          i32.const 62
                          i32.add
                          local.set 0
                        end
                        local.get 1
                        local.get 0
                        i32.store offset=28
                        local.get 1
                        i64.const 0
                        i64.store offset=16 align=4
                        local.get 0
                        i32.const 2
                        i32.shl
                        i32.const 1340
                        i32.add
                        local.set 3
                        block  ;; label = @11
                          block  ;; label = @12
                            i32.const 1040
                            i32.load
                            local.tee 4
                            i32.const 1
                            local.get 0
                            i32.shl
                            local.tee 6
                            i32.and
                            i32.eqz
                            if  ;; label = @13
                              i32.const 1040
                              local.get 4
                              local.get 6
                              i32.or
                              i32.store
                              local.get 3
                              local.get 1
                              i32.store
                              local.get 1
                              local.get 3
                              i32.store offset=24
                              br 1 (;@12;)
                            end
                            local.get 2
                            i32.const 25
                            local.get 0
                            i32.const 1
                            i32.shr_u
                            i32.sub
                            i32.const 0
                            local.get 0
                            i32.const 31
                            i32.ne
                            select
                            i32.shl
                            local.set 0
                            local.get 3
                            i32.load
                            local.set 4
                            loop  ;; label = @13
                              local.get 4
                              local.tee 3
                              i32.load offset=4
                              i32.const -8
                              i32.and
                              local.get 2
                              i32.eq
                              br_if 2 (;@11;)
                              local.get 0
                              i32.const 29
                              i32.shr_u
                              local.set 4
                              local.get 0
                              i32.const 1
                              i32.shl
                              local.set 0
                              local.get 3
                              local.get 4
                              i32.const 4
                              i32.and
                              i32.add
                              i32.const 16
                              i32.add
                              local.tee 6
                              i32.load
                              local.tee 4
                              br_if 0 (;@13;)
                            end
                            local.get 6
                            local.get 1
                            i32.store
                            local.get 1
                            local.get 3
                            i32.store offset=24
                          end
                          local.get 1
                          local.get 1
                          i32.store offset=12
                          local.get 1
                          local.get 1
                          i32.store offset=8
                          br 1 (;@10;)
                        end
                        local.get 3
                        i32.load offset=8
                        local.tee 0
                        local.get 1
                        i32.store offset=12
                        local.get 3
                        local.get 1
                        i32.store offset=8
                        local.get 1
                        i32.const 0
                        i32.store offset=24
                        local.get 1
                        local.get 3
                        i32.store offset=12
                        local.get 1
                        local.get 0
                        i32.store offset=8
                      end
                      i32.const 1048
                      i32.load
                      local.tee 0
                      local.get 5
                      i32.le_u
                      br_if 0 (;@9;)
                      i32.const 1048
                      local.get 0
                      local.get 5
                      i32.sub
                      local.tee 1
                      i32.store
                      i32.const 1060
                      i32.const 1060
                      i32.load
                      local.tee 0
                      local.get 5
                      i32.add
                      local.tee 3
                      i32.store
                      local.get 3
                      local.get 1
                      i32.const 1
                      i32.or
                      i32.store offset=4
                      local.get 0
                      local.get 5
                      i32.const 3
                      i32.or
                      i32.store offset=4
                      local.get 0
                      i32.const 8
                      i32.add
                      local.set 0
                      br 8 (;@1;)
                    end
                    call $__errno_location
                    i32.const 48
                    i32.store
                    i32.const 0
                    local.set 0
                    br 7 (;@1;)
                  end
                  i32.const 0
                  local.set 2
                end
                local.get 9
                i32.eqz
                br_if 0 (;@6;)
                block  ;; label = @7
                  local.get 6
                  i32.load offset=28
                  local.tee 3
                  i32.const 2
                  i32.shl
                  i32.const 1340
                  i32.add
                  local.tee 1
                  i32.load
                  local.get 6
                  i32.eq
                  if  ;; label = @8
                    local.get 1
                    local.get 2
                    i32.store
                    local.get 2
                    br_if 1 (;@7;)
                    i32.const 1040
                    i32.const 1040
                    i32.load
                    i32.const -2
                    local.get 3
                    i32.rotl
                    i32.and
                    i32.store
                    br 2 (;@6;)
                  end
                  local.get 9
                  i32.const 16
                  i32.const 20
                  local.get 9
                  i32.load offset=16
                  local.get 6
                  i32.eq
                  select
                  i32.add
                  local.get 2
                  i32.store
                  local.get 2
                  i32.eqz
                  br_if 1 (;@6;)
                end
                local.get 2
                local.get 9
                i32.store offset=24
                local.get 6
                i32.load offset=16
                local.tee 1
                if  ;; label = @7
                  local.get 2
                  local.get 1
                  i32.store offset=16
                  local.get 1
                  local.get 2
                  i32.store offset=24
                end
                local.get 6
                i32.load offset=20
                local.tee 1
                i32.eqz
                br_if 0 (;@6;)
                local.get 2
                local.get 1
                i32.store offset=20
                local.get 1
                local.get 2
                i32.store offset=24
              end
              local.get 0
              local.get 8
              i32.add
              local.set 0
              local.get 6
              local.get 8
              i32.add
              local.tee 6
              i32.load offset=4
              local.set 1
            end
            local.get 6
            local.get 1
            i32.const -2
            i32.and
            i32.store offset=4
            local.get 5
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 0
            local.get 5
            i32.add
            local.get 0
            i32.store
            local.get 0
            i32.const 255
            i32.le_u
            if  ;; label = @5
              local.get 0
              i32.const -8
              i32.and
              i32.const 1076
              i32.add
              local.set 1
              block (result i32)  ;; label = @6
                i32.const 1036
                i32.load
                local.tee 3
                i32.const 1
                local.get 0
                i32.const 3
                i32.shr_u
                i32.shl
                local.tee 0
                i32.and
                i32.eqz
                if  ;; label = @7
                  i32.const 1036
                  local.get 0
                  local.get 3
                  i32.or
                  i32.store
                  local.get 1
                  br 1 (;@6;)
                end
                local.get 1
                i32.load offset=8
              end
              local.set 0
              local.get 1
              local.get 5
              i32.store offset=8
              local.get 0
              local.get 5
              i32.store offset=12
              local.get 5
              local.get 1
              i32.store offset=12
              local.get 5
              local.get 0
              i32.store offset=8
              br 1 (;@4;)
            end
            i32.const 31
            local.set 1
            local.get 0
            i32.const 16777215
            i32.le_u
            if  ;; label = @5
              local.get 0
              i32.const 38
              local.get 0
              i32.const 8
              i32.shr_u
              i32.clz
              local.tee 1
              i32.sub
              i32.shr_u
              i32.const 1
              i32.and
              local.get 1
              i32.const 1
              i32.shl
              i32.sub
              i32.const 62
              i32.add
              local.set 1
            end
            local.get 5
            local.get 1
            i32.store offset=28
            local.get 5
            i64.const 0
            i64.store offset=16 align=4
            local.get 1
            i32.const 2
            i32.shl
            i32.const 1340
            i32.add
            local.set 3
            block  ;; label = @5
              block  ;; label = @6
                i32.const 1040
                i32.load
                local.tee 2
                i32.const 1
                local.get 1
                i32.shl
                local.tee 4
                i32.and
                i32.eqz
                if  ;; label = @7
                  i32.const 1040
                  local.get 2
                  local.get 4
                  i32.or
                  i32.store
                  local.get 3
                  local.get 5
                  i32.store
                  local.get 5
                  local.get 3
                  i32.store offset=24
                  br 1 (;@6;)
                end
                local.get 0
                i32.const 25
                local.get 1
                i32.const 1
                i32.shr_u
                i32.sub
                i32.const 0
                local.get 1
                i32.const 31
                i32.ne
                select
                i32.shl
                local.set 1
                local.get 3
                i32.load
                local.set 2
                loop  ;; label = @7
                  local.get 2
                  local.tee 3
                  i32.load offset=4
                  i32.const -8
                  i32.and
                  local.get 0
                  i32.eq
                  br_if 2 (;@5;)
                  local.get 1
                  i32.const 29
                  i32.shr_u
                  local.set 2
                  local.get 1
                  i32.const 1
                  i32.shl
                  local.set 1
                  local.get 3
                  local.get 2
                  i32.const 4
                  i32.and
                  i32.add
                  i32.const 16
                  i32.add
                  local.tee 4
                  i32.load
                  local.tee 2
                  br_if 0 (;@7;)
                end
                local.get 4
                local.get 5
                i32.store
                local.get 5
                local.get 3
                i32.store offset=24
              end
              local.get 5
              local.get 5
              i32.store offset=12
              local.get 5
              local.get 5
              i32.store offset=8
              br 1 (;@4;)
            end
            local.get 3
            i32.load offset=8
            local.tee 0
            local.get 5
            i32.store offset=12
            local.get 3
            local.get 5
            i32.store offset=8
            local.get 5
            i32.const 0
            i32.store offset=24
            local.get 5
            local.get 3
            i32.store offset=12
            local.get 5
            local.get 0
            i32.store offset=8
          end
          local.get 7
          i32.const 8
          i32.add
          local.set 0
          br 2 (;@1;)
        end
        block  ;; label = @3
          local.get 7
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 4
            i32.load offset=28
            local.tee 3
            i32.const 2
            i32.shl
            i32.const 1340
            i32.add
            local.tee 0
            i32.load
            local.get 4
            i32.eq
            if  ;; label = @5
              local.get 0
              local.get 2
              i32.store
              local.get 2
              br_if 1 (;@4;)
              i32.const 1040
              local.get 8
              i32.const -2
              local.get 3
              i32.rotl
              i32.and
              local.tee 8
              i32.store
              br 2 (;@3;)
            end
            local.get 7
            i32.const 16
            i32.const 20
            local.get 7
            i32.load offset=16
            local.get 4
            i32.eq
            select
            i32.add
            local.get 2
            i32.store
            local.get 2
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 2
          local.get 7
          i32.store offset=24
          local.get 4
          i32.load offset=16
          local.tee 0
          if  ;; label = @4
            local.get 2
            local.get 0
            i32.store offset=16
            local.get 0
            local.get 2
            i32.store offset=24
          end
          local.get 4
          i32.load offset=20
          local.tee 0
          i32.eqz
          br_if 0 (;@3;)
          local.get 2
          local.get 0
          i32.store offset=20
          local.get 0
          local.get 2
          i32.store offset=24
        end
        block  ;; label = @3
          local.get 1
          i32.const 15
          i32.le_u
          if  ;; label = @4
            local.get 4
            local.get 1
            local.get 5
            i32.add
            local.tee 0
            i32.const 3
            i32.or
            i32.store offset=4
            local.get 0
            local.get 4
            i32.add
            local.tee 0
            local.get 0
            i32.load offset=4
            i32.const 1
            i32.or
            i32.store offset=4
            br 1 (;@3;)
          end
          local.get 4
          local.get 5
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 4
          local.get 5
          i32.add
          local.tee 2
          local.get 1
          i32.const 1
          i32.or
          i32.store offset=4
          local.get 1
          local.get 2
          i32.add
          local.get 1
          i32.store
          local.get 1
          i32.const 255
          i32.le_u
          if  ;; label = @4
            local.get 1
            i32.const -8
            i32.and
            i32.const 1076
            i32.add
            local.set 0
            block (result i32)  ;; label = @5
              i32.const 1036
              i32.load
              local.tee 3
              i32.const 1
              local.get 1
              i32.const 3
              i32.shr_u
              i32.shl
              local.tee 1
              i32.and
              i32.eqz
              if  ;; label = @6
                i32.const 1036
                local.get 1
                local.get 3
                i32.or
                i32.store
                local.get 0
                br 1 (;@5;)
              end
              local.get 0
              i32.load offset=8
            end
            local.set 1
            local.get 0
            local.get 2
            i32.store offset=8
            local.get 1
            local.get 2
            i32.store offset=12
            local.get 2
            local.get 0
            i32.store offset=12
            local.get 2
            local.get 1
            i32.store offset=8
            br 1 (;@3;)
          end
          i32.const 31
          local.set 0
          local.get 1
          i32.const 16777215
          i32.le_u
          if  ;; label = @4
            local.get 1
            i32.const 38
            local.get 1
            i32.const 8
            i32.shr_u
            i32.clz
            local.tee 0
            i32.sub
            i32.shr_u
            i32.const 1
            i32.and
            local.get 0
            i32.const 1
            i32.shl
            i32.sub
            i32.const 62
            i32.add
            local.set 0
          end
          local.get 2
          local.get 0
          i32.store offset=28
          local.get 2
          i64.const 0
          i64.store offset=16 align=4
          local.get 0
          i32.const 2
          i32.shl
          i32.const 1340
          i32.add
          local.set 3
          block  ;; label = @4
            block  ;; label = @5
              local.get 8
              i32.const 1
              local.get 0
              i32.shl
              local.tee 5
              i32.and
              i32.eqz
              if  ;; label = @6
                i32.const 1040
                local.get 5
                local.get 8
                i32.or
                i32.store
                local.get 3
                local.get 2
                i32.store
                local.get 2
                local.get 3
                i32.store offset=24
                br 1 (;@5;)
              end
              local.get 1
              i32.const 25
              local.get 0
              i32.const 1
              i32.shr_u
              i32.sub
              i32.const 0
              local.get 0
              i32.const 31
              i32.ne
              select
              i32.shl
              local.set 0
              local.get 3
              i32.load
              local.set 5
              loop  ;; label = @6
                local.get 5
                local.tee 3
                i32.load offset=4
                i32.const -8
                i32.and
                local.get 1
                i32.eq
                br_if 2 (;@4;)
                local.get 0
                i32.const 29
                i32.shr_u
                local.set 5
                local.get 0
                i32.const 1
                i32.shl
                local.set 0
                local.get 3
                local.get 5
                i32.const 4
                i32.and
                i32.add
                i32.const 16
                i32.add
                local.tee 6
                i32.load
                local.tee 5
                br_if 0 (;@6;)
              end
              local.get 6
              local.get 2
              i32.store
              local.get 2
              local.get 3
              i32.store offset=24
            end
            local.get 2
            local.get 2
            i32.store offset=12
            local.get 2
            local.get 2
            i32.store offset=8
            br 1 (;@3;)
          end
          local.get 3
          i32.load offset=8
          local.tee 0
          local.get 2
          i32.store offset=12
          local.get 3
          local.get 2
          i32.store offset=8
          local.get 2
          i32.const 0
          i32.store offset=24
          local.get 2
          local.get 3
          i32.store offset=12
          local.get 2
          local.get 0
          i32.store offset=8
        end
        local.get 4
        i32.const 8
        i32.add
        local.set 0
        br 1 (;@1;)
      end
      block  ;; label = @2
        local.get 9
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 2
          i32.load offset=28
          local.tee 3
          i32.const 2
          i32.shl
          i32.const 1340
          i32.add
          local.tee 0
          i32.load
          local.get 2
          i32.eq
          if  ;; label = @4
            local.get 0
            local.get 4
            i32.store
            local.get 4
            br_if 1 (;@3;)
            i32.const 1040
            local.get 11
            i32.const -2
            local.get 3
            i32.rotl
            i32.and
            i32.store
            br 2 (;@2;)
          end
          local.get 9
          i32.const 16
          i32.const 20
          local.get 9
          i32.load offset=16
          local.get 2
          i32.eq
          select
          i32.add
          local.get 4
          i32.store
          local.get 4
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 4
        local.get 9
        i32.store offset=24
        local.get 2
        i32.load offset=16
        local.tee 0
        if  ;; label = @3
          local.get 4
          local.get 0
          i32.store offset=16
          local.get 0
          local.get 4
          i32.store offset=24
        end
        local.get 2
        i32.load offset=20
        local.tee 0
        i32.eqz
        br_if 0 (;@2;)
        local.get 4
        local.get 0
        i32.store offset=20
        local.get 0
        local.get 4
        i32.store offset=24
      end
      block  ;; label = @2
        local.get 1
        i32.const 15
        i32.le_u
        if  ;; label = @3
          local.get 2
          local.get 1
          local.get 5
          i32.add
          local.tee 0
          i32.const 3
          i32.or
          i32.store offset=4
          local.get 0
          local.get 2
          i32.add
          local.tee 0
          local.get 0
          i32.load offset=4
          i32.const 1
          i32.or
          i32.store offset=4
          br 1 (;@2;)
        end
        local.get 2
        local.get 5
        i32.const 3
        i32.or
        i32.store offset=4
        local.get 2
        local.get 5
        i32.add
        local.tee 3
        local.get 1
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 1
        local.get 3
        i32.add
        local.get 1
        i32.store
        local.get 8
        if  ;; label = @3
          local.get 8
          i32.const -8
          i32.and
          i32.const 1076
          i32.add
          local.set 5
          i32.const 1056
          i32.load
          local.set 0
          block (result i32)  ;; label = @4
            i32.const 1
            local.get 8
            i32.const 3
            i32.shr_u
            i32.shl
            local.tee 4
            local.get 6
            i32.and
            i32.eqz
            if  ;; label = @5
              i32.const 1036
              local.get 4
              local.get 6
              i32.or
              i32.store
              local.get 5
              br 1 (;@4;)
            end
            local.get 5
            i32.load offset=8
          end
          local.set 4
          local.get 5
          local.get 0
          i32.store offset=8
          local.get 4
          local.get 0
          i32.store offset=12
          local.get 0
          local.get 5
          i32.store offset=12
          local.get 0
          local.get 4
          i32.store offset=8
        end
        i32.const 1056
        local.get 3
        i32.store
        i32.const 1044
        local.get 1
        i32.store
      end
      local.get 2
      i32.const 8
      i32.add
      local.set 0
    end
    local.get 10
    i32.const 16
    i32.add
    global.set $__stack_pointer
    local.get 0)
  (func $dlfree (type 2) (param i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    block  ;; label = @1
      local.get 0
      i32.eqz
      br_if 0 (;@1;)
      local.get 0
      i32.const 8
      i32.sub
      local.tee 2
      local.get 0
      i32.const 4
      i32.sub
      i32.load
      local.tee 1
      i32.const -8
      i32.and
      local.tee 0
      i32.add
      local.set 5
      block  ;; label = @2
        local.get 1
        i32.const 1
        i32.and
        br_if 0 (;@2;)
        local.get 1
        i32.const 3
        i32.and
        i32.eqz
        br_if 1 (;@1;)
        local.get 2
        local.get 2
        i32.load
        local.tee 1
        i32.sub
        local.tee 2
        i32.const 1052
        i32.load
        local.tee 4
        i32.lt_u
        br_if 1 (;@1;)
        local.get 0
        local.get 1
        i32.add
        local.set 0
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1056
            i32.load
            local.get 2
            i32.ne
            if  ;; label = @5
              local.get 1
              i32.const 255
              i32.le_u
              if  ;; label = @6
                local.get 1
                i32.const 3
                i32.shr_u
                local.tee 7
                i32.const 3
                i32.shl
                i32.const 1076
                i32.add
                local.set 3
                local.get 2
                i32.load offset=12
                local.tee 1
                local.get 2
                i32.load offset=8
                local.tee 4
                i32.eq
                if  ;; label = @7
                  i32.const 1036
                  i32.const 1036
                  i32.load
                  i32.const -2
                  local.get 7
                  i32.rotl
                  i32.and
                  i32.store
                  br 5 (;@2;)
                end
                local.get 4
                local.get 1
                i32.store offset=12
                local.get 1
                local.get 4
                i32.store offset=8
                br 4 (;@2;)
              end
              local.get 2
              i32.load offset=24
              local.set 6
              local.get 2
              local.get 2
              i32.load offset=12
              local.tee 3
              i32.ne
              if  ;; label = @6
                local.get 2
                i32.load offset=8
                local.tee 1
                local.get 3
                i32.store offset=12
                local.get 3
                local.get 1
                i32.store offset=8
                br 3 (;@3;)
              end
              local.get 2
              i32.const 20
              i32.add
              local.tee 4
              i32.load
              local.tee 1
              i32.eqz
              if  ;; label = @6
                local.get 2
                i32.load offset=16
                local.tee 1
                i32.eqz
                br_if 2 (;@4;)
                local.get 2
                i32.const 16
                i32.add
                local.set 4
              end
              loop  ;; label = @6
                local.get 4
                local.set 7
                local.get 1
                local.tee 3
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 1
                br_if 0 (;@6;)
                local.get 3
                i32.const 16
                i32.add
                local.set 4
                local.get 3
                i32.load offset=16
                local.tee 1
                br_if 0 (;@6;)
              end
              local.get 7
              i32.const 0
              i32.store
              br 2 (;@3;)
            end
            local.get 5
            i32.load offset=4
            local.tee 1
            i32.const 3
            i32.and
            i32.const 3
            i32.ne
            br_if 2 (;@2;)
            i32.const 1044
            local.get 0
            i32.store
            local.get 5
            local.get 1
            i32.const -2
            i32.and
            i32.store offset=4
            local.get 2
            local.get 0
            i32.const 1
            i32.or
            i32.store offset=4
            local.get 5
            local.get 0
            i32.store
            return
          end
          i32.const 0
          local.set 3
        end
        local.get 6
        i32.eqz
        br_if 0 (;@2;)
        block  ;; label = @3
          local.get 2
          i32.load offset=28
          local.tee 4
          i32.const 2
          i32.shl
          i32.const 1340
          i32.add
          local.tee 1
          i32.load
          local.get 2
          i32.eq
          if  ;; label = @4
            local.get 1
            local.get 3
            i32.store
            local.get 3
            br_if 1 (;@3;)
            i32.const 1040
            i32.const 1040
            i32.load
            i32.const -2
            local.get 4
            i32.rotl
            i32.and
            i32.store
            br 2 (;@2;)
          end
          local.get 6
          i32.const 16
          i32.const 20
          local.get 6
          i32.load offset=16
          local.get 2
          i32.eq
          select
          i32.add
          local.get 3
          i32.store
          local.get 3
          i32.eqz
          br_if 1 (;@2;)
        end
        local.get 3
        local.get 6
        i32.store offset=24
        local.get 2
        i32.load offset=16
        local.tee 1
        if  ;; label = @3
          local.get 3
          local.get 1
          i32.store offset=16
          local.get 1
          local.get 3
          i32.store offset=24
        end
        local.get 2
        i32.load offset=20
        local.tee 1
        i32.eqz
        br_if 0 (;@2;)
        local.get 3
        local.get 1
        i32.store offset=20
        local.get 1
        local.get 3
        i32.store offset=24
      end
      local.get 2
      local.get 5
      i32.ge_u
      br_if 0 (;@1;)
      local.get 5
      i32.load offset=4
      local.tee 1
      i32.const 1
      i32.and
      i32.eqz
      br_if 0 (;@1;)
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            block  ;; label = @5
              local.get 1
              i32.const 2
              i32.and
              i32.eqz
              if  ;; label = @6
                i32.const 1060
                i32.load
                local.get 5
                i32.eq
                if  ;; label = @7
                  i32.const 1060
                  local.get 2
                  i32.store
                  i32.const 1048
                  i32.const 1048
                  i32.load
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store
                  local.get 2
                  local.get 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 2
                  i32.const 1056
                  i32.load
                  i32.ne
                  br_if 6 (;@1;)
                  i32.const 1044
                  i32.const 0
                  i32.store
                  i32.const 1056
                  i32.const 0
                  i32.store
                  return
                end
                i32.const 1056
                i32.load
                local.get 5
                i32.eq
                if  ;; label = @7
                  i32.const 1056
                  local.get 2
                  i32.store
                  i32.const 1044
                  i32.const 1044
                  i32.load
                  local.get 0
                  i32.add
                  local.tee 0
                  i32.store
                  local.get 2
                  local.get 0
                  i32.const 1
                  i32.or
                  i32.store offset=4
                  local.get 0
                  local.get 2
                  i32.add
                  local.get 0
                  i32.store
                  return
                end
                local.get 1
                i32.const -8
                i32.and
                local.get 0
                i32.add
                local.set 0
                local.get 1
                i32.const 255
                i32.le_u
                if  ;; label = @7
                  local.get 1
                  i32.const 3
                  i32.shr_u
                  local.tee 7
                  i32.const 3
                  i32.shl
                  i32.const 1076
                  i32.add
                  local.set 3
                  local.get 5
                  i32.load offset=12
                  local.tee 1
                  local.get 5
                  i32.load offset=8
                  local.tee 4
                  i32.eq
                  if  ;; label = @8
                    i32.const 1036
                    i32.const 1036
                    i32.load
                    i32.const -2
                    local.get 7
                    i32.rotl
                    i32.and
                    i32.store
                    br 5 (;@3;)
                  end
                  local.get 4
                  local.get 1
                  i32.store offset=12
                  local.get 1
                  local.get 4
                  i32.store offset=8
                  br 4 (;@3;)
                end
                local.get 5
                i32.load offset=24
                local.set 6
                local.get 5
                local.get 5
                i32.load offset=12
                local.tee 3
                i32.ne
                if  ;; label = @7
                  i32.const 1052
                  i32.load
                  drop
                  local.get 5
                  i32.load offset=8
                  local.tee 1
                  local.get 3
                  i32.store offset=12
                  local.get 3
                  local.get 1
                  i32.store offset=8
                  br 3 (;@4;)
                end
                local.get 5
                i32.const 20
                i32.add
                local.tee 4
                i32.load
                local.tee 1
                i32.eqz
                if  ;; label = @7
                  local.get 5
                  i32.load offset=16
                  local.tee 1
                  i32.eqz
                  br_if 2 (;@5;)
                  local.get 5
                  i32.const 16
                  i32.add
                  local.set 4
                end
                loop  ;; label = @7
                  local.get 4
                  local.set 7
                  local.get 1
                  local.tee 3
                  i32.const 20
                  i32.add
                  local.tee 4
                  i32.load
                  local.tee 1
                  br_if 0 (;@7;)
                  local.get 3
                  i32.const 16
                  i32.add
                  local.set 4
                  local.get 3
                  i32.load offset=16
                  local.tee 1
                  br_if 0 (;@7;)
                end
                local.get 7
                i32.const 0
                i32.store
                br 2 (;@4;)
              end
              local.get 5
              local.get 1
              i32.const -2
              i32.and
              i32.store offset=4
              local.get 2
              local.get 0
              i32.const 1
              i32.or
              i32.store offset=4
              local.get 0
              local.get 2
              i32.add
              local.get 0
              i32.store
              br 3 (;@2;)
            end
            i32.const 0
            local.set 3
          end
          local.get 6
          i32.eqz
          br_if 0 (;@3;)
          block  ;; label = @4
            local.get 5
            i32.load offset=28
            local.tee 4
            i32.const 2
            i32.shl
            i32.const 1340
            i32.add
            local.tee 1
            i32.load
            local.get 5
            i32.eq
            if  ;; label = @5
              local.get 1
              local.get 3
              i32.store
              local.get 3
              br_if 1 (;@4;)
              i32.const 1040
              i32.const 1040
              i32.load
              i32.const -2
              local.get 4
              i32.rotl
              i32.and
              i32.store
              br 2 (;@3;)
            end
            local.get 6
            i32.const 16
            i32.const 20
            local.get 6
            i32.load offset=16
            local.get 5
            i32.eq
            select
            i32.add
            local.get 3
            i32.store
            local.get 3
            i32.eqz
            br_if 1 (;@3;)
          end
          local.get 3
          local.get 6
          i32.store offset=24
          local.get 5
          i32.load offset=16
          local.tee 1
          if  ;; label = @4
            local.get 3
            local.get 1
            i32.store offset=16
            local.get 1
            local.get 3
            i32.store offset=24
          end
          local.get 5
          i32.load offset=20
          local.tee 1
          i32.eqz
          br_if 0 (;@3;)
          local.get 3
          local.get 1
          i32.store offset=20
          local.get 1
          local.get 3
          i32.store offset=24
        end
        local.get 2
        local.get 0
        i32.const 1
        i32.or
        i32.store offset=4
        local.get 0
        local.get 2
        i32.add
        local.get 0
        i32.store
        local.get 2
        i32.const 1056
        i32.load
        i32.ne
        br_if 0 (;@2;)
        i32.const 1044
        local.get 0
        i32.store
        return
      end
      local.get 0
      i32.const 255
      i32.le_u
      if  ;; label = @2
        local.get 0
        i32.const -8
        i32.and
        i32.const 1076
        i32.add
        local.set 1
        block (result i32)  ;; label = @3
          i32.const 1036
          i32.load
          local.tee 4
          i32.const 1
          local.get 0
          i32.const 3
          i32.shr_u
          i32.shl
          local.tee 0
          i32.and
          i32.eqz
          if  ;; label = @4
            i32.const 1036
            local.get 0
            local.get 4
            i32.or
            i32.store
            local.get 1
            br 1 (;@3;)
          end
          local.get 1
          i32.load offset=8
        end
        local.set 0
        local.get 1
        local.get 2
        i32.store offset=8
        local.get 0
        local.get 2
        i32.store offset=12
        local.get 2
        local.get 1
        i32.store offset=12
        local.get 2
        local.get 0
        i32.store offset=8
        return
      end
      i32.const 31
      local.set 1
      local.get 0
      i32.const 16777215
      i32.le_u
      if  ;; label = @2
        local.get 0
        i32.const 38
        local.get 0
        i32.const 8
        i32.shr_u
        i32.clz
        local.tee 1
        i32.sub
        i32.shr_u
        i32.const 1
        i32.and
        local.get 1
        i32.const 1
        i32.shl
        i32.sub
        i32.const 62
        i32.add
        local.set 1
      end
      local.get 2
      local.get 1
      i32.store offset=28
      local.get 2
      i64.const 0
      i64.store offset=16 align=4
      local.get 1
      i32.const 2
      i32.shl
      i32.const 1340
      i32.add
      local.set 4
      block  ;; label = @2
        block  ;; label = @3
          block  ;; label = @4
            i32.const 1040
            i32.load
            local.tee 3
            i32.const 1
            local.get 1
            i32.shl
            local.tee 5
            i32.and
            i32.eqz
            if  ;; label = @5
              i32.const 1040
              local.get 3
              local.get 5
              i32.or
              i32.store
              local.get 4
              local.get 2
              i32.store
              local.get 2
              local.get 4
              i32.store offset=24
              br 1 (;@4;)
            end
            local.get 0
            i32.const 25
            local.get 1
            i32.const 1
            i32.shr_u
            i32.sub
            i32.const 0
            local.get 1
            i32.const 31
            i32.ne
            select
            i32.shl
            local.set 1
            local.get 4
            i32.load
            local.set 3
            loop  ;; label = @5
              local.get 3
              local.tee 4
              i32.load offset=4
              i32.const -8
              i32.and
              local.get 0
              i32.eq
              br_if 2 (;@3;)
              local.get 1
              i32.const 29
              i32.shr_u
              local.set 3
              local.get 1
              i32.const 1
              i32.shl
              local.set 1
              local.get 4
              local.get 3
              i32.const 4
              i32.and
              i32.add
              i32.const 16
              i32.add
              local.tee 5
              i32.load
              local.tee 3
              br_if 0 (;@5;)
            end
            local.get 5
            local.get 2
            i32.store
            local.get 2
            local.get 4
            i32.store offset=24
          end
          local.get 2
          local.get 2
          i32.store offset=12
          local.get 2
          local.get 2
          i32.store offset=8
          br 1 (;@2;)
        end
        local.get 4
        i32.load offset=8
        local.tee 0
        local.get 2
        i32.store offset=12
        local.get 4
        local.get 2
        i32.store offset=8
        local.get 2
        i32.const 0
        i32.store offset=24
        local.get 2
        local.get 4
        i32.store offset=12
        local.get 2
        local.get 0
        i32.store offset=8
      end
      i32.const 1068
      i32.const 1068
      i32.load
      i32.const 1
      i32.sub
      local.tee 2
      i32.const -1
      local.get 2
      select
      i32.store
    end)
  (func $stackSave (type 1) (result i32)
    global.get $__stack_pointer)
  (func $stackRestore (type 2) (param i32)
    local.get 0
    global.set $__stack_pointer)
  (func $stackAlloc (type 0) (param i32) (result i32)
    (local i32)
    global.get $__stack_pointer
    local.get 0
    i32.sub
    i32.const -16
    i32.and
    local.tee 1
    global.set $__stack_pointer
    local.get 1)
  (table (;0;) 2 2 funcref)
  (memory (;0;) 32768 32768)
  (global $__stack_pointer (mut i32) (i32.const 67072))
  (export "memory" (memory 0))
  (export "function" (func $function))
  (export "get_output_size" (func $get_output_size))
  (export "alloc" (func $alloc))
  (export "dealloc" (func $dealloc))
  (export "__indirect_function_table" (table 0))
  (export "_initialize" (func $_initialize))
  (export "__errno_location" (func $__errno_location))
  (export "stackSave" (func $stackSave))
  (export "stackRestore" (func $stackRestore))
  (export "stackAlloc" (func $stackAlloc))
  (elem (;0;) (i32.const 1) func $__wasm_call_ctors)
  (data $.data (i32.const 1025) "\06\01"))
