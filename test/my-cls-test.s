.data
.balign    8
.text
f.9:                                     # !1
    addl    $1, %eax                     # !1
    ret                                  # !1
g.12:                                    # !3
    movl    4(%edi), %ebx                # !3
    addl    %ebx, %eax                   # !3
    ret                                  # !3
h.14:                                    # !4
    movl    4(%edi), %ebx                # !4
    movl    %ebx, 0(%ebp)                # !4
    addl    $8, %ebp                     # !4
    call    f.9                          # !4
    subl    $8, %ebp                     # !4
    movl    0(%ebp), %edi                # !4
    jmp    *(%edi)                       # !4
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
    movl    $10, %eax                    # !2
    movl    %eax, 0(%ebp)                # !2
    addl    $8, %ebp                     # !2
    call    f.9                          # !2
    subl    $8, %ebp                     # !2
    movl    min_caml_hp, %ebx            # !3
    addl    $8, min_caml_hp              # !3
    movl    $g.12, %ecx                  # !3
    movl    %ecx, 0(%ebx)                # !3
    movl    %eax, 4(%ebx)                # !3
    movl    min_caml_hp, %edi            # !4
    addl    $8, min_caml_hp              # !4
    movl    $h.14, %eax                  # !4
    movl    %eax, 0(%edi)                # !4
    movl    %ebx, 4(%edi)                # !4
    movl    $5, %eax                     # !5
    movl    %ebx, 4(%ebp)                # !5
    addl    $8, %ebp                     # !5
    call    *(%edi)                      # !5
    subl    $8, %ebp                     # !5
    movl    0(%ebp), %ebx                # !5
    movl    4(%ebp), %edi                # !5
    movl    %eax, 8(%ebp)                # !5
    movl    %ebx, %eax                   # !5
    addl    $16, %ebp                    # !5
    call    *(%edi)                      # !5
    subl    $16, %ebp                    # !5
    movl    8(%ebp), %ebx                # !5
    addl    %ebx, %eax                   # !5
    addl    $16, %ebp                    # !5
    call    min_caml_print_int           # !5
    subl    $16, %ebp                    # !5
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
