.data
.balign    8
.text
g.13:                                    # !1
    addl    %ebx, %eax                   # !1
    addl    %ecx, %eax                   # !1
    ret                                  # !1
f.17:                                    # !2
    cmpl    $1, %eax                     # !3
    jg    jle_else.35                    # !3
    ret                                  # !3
jle_else.35:                             # !3
    movl    %eax, %ebx                   # !4
    addl    %eax, %ebx                   # !4
    movl    %eax, %ecx                   # !7
    subl    $1, %ecx                     # !7
    movl    %eax, %edx                   # !10
    subl    $2, %edx                     # !10
    movl    %eax, 0(%ebp)                # !4
    movl    %ebx, %eax                   # !4
    movl    %ecx, %ebx                   # !4
    movl    %edx, %ecx                   # !4
    addl    $8, %ebp                     # !4
    call    g.13                         # !4
    subl    $8, %ebp                     # !4
    movl    0(%ebp), %ebx                # !13
    subl    $2, %ebx                     # !13
    movl    %eax, 4(%ebp)                # !13
    movl    %ebx, %eax                   # !13
    addl    $8, %ebp                     # !13
    call    f.17                         # !13
    subl    $8, %ebp                     # !13
    movl    4(%ebp), %ebx                # !4
    addl    %ebx, %eax                   # !4
    ret                                  # !4
.globl    min_caml_start
min_caml_start:
.globl    _min_caml_start
_min_caml_start: # for cygwin
    pushl    %eax
    pushl    %ebx
    pushl    %ecx
    pushl    %edx
    pushl    %esi
    pushl    %edi
    pushl    %ebp
    movl    32(%esp),%ebp
    movl    36(%esp),%eax
    movl    %eax,min_caml_hp
    movl    $10, %eax                    # !14
    call    f.17                         # !14
    call    min_caml_print_int           # !15
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
