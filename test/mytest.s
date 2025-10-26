.data
.balign    8
.text
f.6:                                     # !2
    movl    4(%edi), %ecx                # !2
    addl    %ebx, %eax                   # !2
    addl    %ecx, %eax                   # !2
    ret                                  # !2
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
    movl    $10, %eax                    # !1
    movl    min_caml_hp, %edi            # !2
    addl    $8, min_caml_hp              # !2
    movl    $f.6, %ebx                   # !2
    movl    %ebx, 0(%edi)                # !2
    movl    %eax, 4(%edi)                # !2
    movl    $10, %eax                    # !5
    movl    $20, %ebx                    # !5
    call    *(%edi)                      # !5
    call    min_caml_print_int           # !5
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
