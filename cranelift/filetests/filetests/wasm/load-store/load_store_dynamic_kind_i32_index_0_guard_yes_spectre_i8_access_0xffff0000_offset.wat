;;! target = "x86_64"
;;!
;;! settings = ['enable_heap_access_spectre_mitigation=true']
;;!
;;! compile = false
;;!
;;! [globals.vmctx]
;;! type = "i64"
;;! vmctx = true
;;!
;;! [globals.heap_base]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 0, readonly = true }
;;!
;;! [globals.heap_bound]
;;! type = "i64"
;;! load = { base = "vmctx", offset = 8, readonly = true }
;;!
;;! [[heaps]]
;;! base = "heap_base"
;;! min_size = 0x10000
;;! offset_guard_size = 0
;;! index_type = "i32"
;;! style = { kind = "dynamic", bound = "heap_bound" }

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i32 1)

  (func (export "do_store") (param i32 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0xffff0000)

  (func (export "do_load") (param i32) (result i32)
    local.get 0
    i32.load8_u offset=0xffff0000))

;; function u0:0(i32, i32, i64 vmctx) fast {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned readonly gv0
;;
;;                                 block0(v0: i32, v1: i32, v2: i64):
;; @0040                               v3 = uextend.i64 v0
;; @0040                               v4 = iconst.i64 0xffff_0001
;; @0040                               v5 = uadd_overflow_trap v3, v4, heap_oob  ; v4 = 0xffff_0001
;; @0040                               v6 = global_value.i64 gv1
;; @0040                               v7 = global_value.i64 gv2
;; @0040                               v8 = iadd v7, v3
;; @0040                               v9 = iadd_imm v8, 0xffff_0000
;; @0040                               v10 = iconst.i64 0
;; @0040                               v11 = icmp ugt v5, v6
;; @0040                               v12 = select_spectre_guard v11, v10, v9  ; v10 = 0
;; @0040                               istore8 little heap v1, v12
;; @0047                               jump block1
;;
;;                                 block1:
;; @0047                               return
;; }
;;
;; function u0:1(i32, i64 vmctx) -> i32 fast {
;;     gv0 = vmctx
;;     gv1 = load.i64 notrap aligned readonly gv0+8
;;     gv2 = load.i64 notrap aligned readonly gv0
;;
;;                                 block0(v0: i32, v1: i64):
;; @004c                               v3 = uextend.i64 v0
;; @004c                               v4 = iconst.i64 0xffff_0001
;; @004c                               v5 = uadd_overflow_trap v3, v4, heap_oob  ; v4 = 0xffff_0001
;; @004c                               v6 = global_value.i64 gv1
;; @004c                               v7 = global_value.i64 gv2
;; @004c                               v8 = iadd v7, v3
;; @004c                               v9 = iadd_imm v8, 0xffff_0000
;; @004c                               v10 = iconst.i64 0
;; @004c                               v11 = icmp ugt v5, v6
;; @004c                               v12 = select_spectre_guard v11, v10, v9  ; v10 = 0
;; @004c                               v13 = uload8.i32 little heap v12
;; @0053                               jump block1(v13)
;;
;;                                 block1(v2: i32):
;; @0053                               return v2
;; }