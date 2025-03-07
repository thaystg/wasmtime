;;! target = "riscv64"
;;!
;;! settings = ['enable_heap_access_spectre_mitigation=false']
;;!
;;! compile = true
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
;;! offset_guard_size = 0xffffffff
;;! index_type = "i64"
;;! style = { kind = "dynamic", bound = "heap_bound" }

;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; !!! GENERATED BY 'make-load-store-tests.sh' DO NOT EDIT !!!
;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(module
  (memory i64 1)

  (func (export "do_store") (param i64 i32)
    local.get 0
    local.get 1
    i32.store8 offset=0xffff0000)

  (func (export "do_load") (param i64) (result i32)
    local.get 0
    i32.load8_u offset=0xffff0000))

;; function u0:0:
;; block0:
;;   auipc a7,0; ld a7,12(a7); j 12; .8byte 0xffff0001
;;   add t4,a0,a7
;;   ult t1,t4,a0##ty=i64
;;   trap_if t1,heap_oob
;;   ld t0,8(a2)
;;   ule t0,t4,t0##ty=i64
;;   bne t0,zero,taken(label1),not_taken(label3)
;; block1:
;;   ld t1,0(a2)
;;   add t1,t1,a0
;;   auipc t0,0; ld t0,12(t0); j 12; .8byte 0xffff0000
;;   add t2,t1,t0
;;   sb a1,0(t2)
;;   j label2
;; block2:
;;   ret
;; block3:
;;   udf##trap_code=heap_oob
;;
;; function u0:1:
;; block0:
;;   auipc a7,0; ld a7,12(a7); j 12; .8byte 0xffff0001
;;   add t4,a0,a7
;;   ult t1,t4,a0##ty=i64
;;   trap_if t1,heap_oob
;;   ld t0,8(a1)
;;   ule t0,t4,t0##ty=i64
;;   bne t0,zero,taken(label1),not_taken(label3)
;; block1:
;;   ld t1,0(a1)
;;   add t1,t1,a0
;;   auipc t0,0; ld t0,12(t0); j 12; .8byte 0xffff0000
;;   add t2,t1,t0
;;   lbu a0,0(t2)
;;   j label2
;; block2:
;;   ret
;; block3:
;;   udf##trap_code=heap_oob