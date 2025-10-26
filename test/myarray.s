.data
.balign    8
.text
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
    movl    $5, %eax                     # !1
    movl    $0, %ebx                     # !1
    call    min_caml_create_array        # !1
    movl    $2, %ebx                     # !3
    movl    %ebx, 0(%eax)                # !3
    movl    0(%eax), %ebx                # !4
    movl    0(%eax), %eax                # !4
    cmpl    %eax, %ebx                   # !4
    jne    je_else.26                    # !4
    movl    $1, %eax                     # !4
    call    min_caml_print_int           # !4
    jmp    je_cont.27                    # !4
je_else.26:                              # !4
    movl    $0, %eax                     # !4
    call    min_caml_print_int           # !4
je_cont.27:                              # !4
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
