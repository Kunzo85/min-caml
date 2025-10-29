.data
.balign    8
.text
func.32:                                 # !17
    addl    $30, %eax                    # !19
    addl    %ebx, %eax                   # !19
    ret                                  # !19
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
    movl    $30, %eax                    # !3
    movl    $0, %ebx                     # !16
    movl    %ebx, 0(%ebp)                # !22
    movl    %eax, %ebx                   # !22
    addl    $8, %ebp                     # !22
    call    func.32                      # !22
    subl    $8, %ebp                     # !22
    addl    $0, %eax                     # !30
    movl    %eax, %ebx                   # !33
    addl    $0, %ebx                     # !33
    movl    0(%ebp), %eax                # !35
    subl    %ebx, %eax                   # !35
    movl    %eax, 4(%ebp)                # !50
    addl    $8, %ebp                     # !50
    call    min_caml_create_array        # !50
    subl    $8, %ebp                     # !50
    movl    4(%ebp), %ebx                # !52
    subl    $1, %ebx                     # !52
    movl    $120, %ecx                   # !52
    movl    %ecx, (%eax,%ebx,4)          # !52
    movl    %ecx, (%eax,%ebx,4)          # !53
    movl    (%eax,%ebx,4), %ecx          # !54
    movl    (%eax,%ebx,4), %eax          # !55
    addl    $-90, %ecx                   # !56
    addl    %ecx, %eax                   # !56
    addl    $8, %ebp                     # !56
    call    min_caml_print_int           # !56
    subl    $8, %ebp                     # !56
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
