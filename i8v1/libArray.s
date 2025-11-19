++
Array routines for the i8v1 architecture.
++
min_caml_create_array:
    sw       %ra  %sp  0
    sw       %r1  %sp  -1
    addi     %sp  %sp  -2
    jal      ~create_array_loop
    addi     %sp  %sp  2
    lw       %ra  %sp  0
    lw       %r2  %sp  -1
    movz     %r1  %hp  %zero
    add      %hp  %hp  %r2
    jr       %ra
create_array_loop:
    blt      %zero  %r1  create_array_loop_blt_then
    jr       %ra
create_array_loop_blt_then:
    addi     %r1  %r1  -1
    swv      %r2  %hp  %r1
    j        ~create_array_loop

min_caml_create_float_array:
    sw       %ra  %sp  0
    sw       %r1  %sp  -1
    addi     %sp  %sp  -2
    jal      ~create_float_array_loop
    addi     %sp  %sp  2
    lw       %ra  %sp  0
    lw       %r2  %sp  -1
    movz     %r1  %hp  %zero
    add      %hp  %hp  %r2
    jr       %ra
create_float_array_loop:
    blt      %zero  %r1  create_float_array_loop_blt_then
    jr       %ra
create_float_array_loop_blt_then:
    addi     %r1  %r1  -1
    fswv     %f0  %hp  %r1
    j        ~create_float_array_loop