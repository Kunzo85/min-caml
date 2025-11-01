.data
.balign    8
.text
x.8:                                     # !2
    movl    %eax, %ebx                   # !3
    negl    %ebx                         # !3
    subl    %ebx, %eax                   # !3
    movl    %eax, %ebx                   # !4
    negl    %ebx                         # !4
    movl    %ebx, %ecx                   # !4
    negl    %ecx                         # !4
    subl    %ecx, %ebx                   # !4
    subl    %ebx, %eax                   # !4
    movl    %eax, %ebx                   # !5
    negl    %ebx                         # !5
    subl    %ebx, %eax                   # !5
    ret                                  # !5
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
    movl    $125, %eax                   # !6
    call    x.8                          # !6
    movl    %eax, %ebx                   # !6
    negl    %ebx                         # !6
    subl    %ebx, %eax                   # !6
    call    min_caml_print_int           # !8
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
