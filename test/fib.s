.section	".rodata"
.align	8
.section	".text"
fib.10:			!1
	cmp	%i2, 1			!2
	bg	ble_else.24
	nop
	retl
	nop
ble_else.24:
	sub	%i2, 1, %i3			!3
	st	%i2, [%i0 + 0]			!3
	mov	%i3, %i2			!3
	st	%o7, [%i0 + 4]			!3
	call	fib.10			!3
	add	%i0, 8, %i0	! delay slot			!3
	sub	%i0, 8, %i0			!3
	ld	[%i0 + 4], %o7			!3
	ld	[%i0 + 0], %i3			!3
	sub	%i3, 2, %i3			!3
	st	%i2, [%i0 + 4]			!3
	mov	%i3, %i2			!3
	st	%o7, [%i0 + 12]			!3
	call	fib.10			!3
	add	%i0, 16, %i0	! delay slot			!3
	sub	%i0, 16, %i0			!3
	ld	[%i0 + 12], %o7			!3
	ld	[%i0 + 4], %i3			!3
	add	%i3, %i2, %i2			!3
	retl
	nop
.global	min_caml_start
min_caml_start:
	save	%sp, -112, %sp
	set	30, %i2			!4			!4
	st	%o7, [%i0 + 4]			!4
	call	fib.10			!4
	add	%i0, 8, %i0	! delay slot			!4
	sub	%i0, 8, %i0			!4
	ld	[%i0 + 4], %o7			!4
	st	%o7, [%i0 + 4]			!4
	call	min_caml_print_int			!4
	add	%i0, 8, %i0	! delay slot			!4
	sub	%i0, 8, %i0			!4
	ld	[%i0 + 4], %o7			!4
	ret
	restore
