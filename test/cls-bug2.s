.data
.balign    8
.text
f.9:                                     # !2
    cmpl    $0, %eax                     # !3
    jl    jge_else.26                    # !3
    movl    %eax, 0(%ebp)                # !4
    movl    %edi, 4(%ebp)                # !4
    addl    $8, %ebp                     # !4
    call    min_caml_print_int           # !4
    subl    $8, %ebp                     # !4
    movl    $1, %eax                     # !5
    movl    4(%ebp), %ebx                # !5
    addl    $8, %ebp                     # !5
    call    min_caml_create_array        # !5
    subl    $8, %ebp                     # !5
    movl    0(%eax), %edi                # !6
    movl    0(%ebp), %eax                # !6
    subl    $1, %eax                     # !6
    jmp    *(%edi)                       # !6
jge_else.26:                             # !3
    ret                                  # !3
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
    movl    min_caml_hp, %edi            # !2
    addl    $8, min_caml_hp              # !2
    movl    $f.9, %eax                   # !2
    movl    %eax, 0(%edi)                # !2
    movl    $9, %eax                     # !7
    call    *(%edi)                      # !7
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
