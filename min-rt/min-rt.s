.data
.balign    8
l.4543:    # 128.000000
    .long    0x0
    .long    0x40600000
l.4541:    # 40000.000000
    .long    0x0
    .long    0x40e38800
l.4534:    # -2.000000
    .long    0x0
    .long    0xc0000000
l.4532:    # 0.100000
    .long    0x9999999a
    .long    0x3fb99999
l.4529:    # 0.200000
    .long    0x9999999a
    .long    0x3fc99999
l.4519:    # 20.000000
    .long    0x0
    .long    0x40340000
l.4517:    # 0.050000
    .long    0x9999999a
    .long    0x3fa99999
l.4513:    # 0.250000
    .long    0x0
    .long    0x3fd00000
l.4510:    # 255.000000
    .long    0x0
    .long    0x406fe000
l.4508:    # 3.141593
    .long    0x5a7ed197
    .long    0x400921fb
l.4506:    # 10.000000
    .long    0x0
    .long    0x40240000
l.4504:    # 850.000000
    .long    0x0
    .long    0x408a9000
l.4501:    # 0.500000
    .long    0x0
    .long    0x3fe00000
l.4499:    # 0.150000
    .long    0x33333333
    .long    0x3fc33333
l.4495:    # 9.549296
    .long    0x62316387
    .long    0x4023193d
l.4493:    # 15.000000
    .long    0x0
    .long    0x402e0000
l.4491:    # 0.000100
    .long    0xeb1c432d
    .long    0x3f1a36e2
l.4486:    # 100000000.000000
    .long    0x0
    .long    0x4197d784
l.4483:    # 1000000000.000000
    .long    0x0
    .long    0x41cdcd65
l.4479:    # -0.100000
    .long    0x9999999a
    .long    0xbfb99999
l.4477:    # 0.010000
    .long    0x47ae147b
    .long    0x3f847ae1
l.4475:    # -0.200000
    .long    0x9999999a
    .long    0xbfc99999
l.4470:    # 4.000000
    .long    0x0
    .long    0x40100000
l.4450:    # -200.000000
    .long    0x0
    .long    0xc0690000
l.4448:    # 0.017453
    .long    0xaa91ed06
    .long    0x3f91df46
l.4446:    # -1.000000
    .long    0x0
    .long    0xbff00000
l.4444:    # 1.000000
    .long    0x0
    .long    0x3ff00000
l.4442:    # 0.000000
    .long    0x0
    .long    0x0
l.4440:    # 2.000000
    .long    0x0
    .long    0x40000000
.text
xor.1977:                                # !14
    movl    $0, %ecx                     # !14
    cmpl    $0, %eax                     # !14
    jne    je_else.5562                  # !14
    movl    %ebx, %eax                   # !14
    ret                                  # !14
je_else.5562:                            # !14
    cmpl    $0, %ebx                     # !14
    jne    je_else.5563                  # !14
    movl    $1, %eax                     # !14
    ret                                  # !14
je_else.5563:                            # !14
    movl    %ecx, %eax                   # !14
    ret                                  # !14
fsqr.1980:                               # !17
    mulsd    %xmm0, %xmm0                # !17
    ret                                  # !17
fhalf.1982:                              # !20
    movl    $l.4440, %eax                # !20
    movsd    0(%eax), %xmm1              # !20
    divsd    %xmm1, %xmm0                # !20
    ret                                  # !20
o_texturetype.1984:                      # !26
    movl    0(%eax), %eax                # !28
    ret                                  # !33
o_form.1986:                             # !36
    movl    4(%eax), %eax                # !38
    ret                                  # !43
o_reflectiontype.1988:                   # !46
    movl    8(%eax), %eax                # !48
    ret                                  # !53
o_isinvert.1990:                         # !56
    movl    24(%eax), %eax               # !58
    ret                                  # !62
o_isrot.1992:                            # !65
    movl    12(%eax), %eax               # !67
    ret                                  # !71
o_param_a.1994:                          # !74
    movl    16(%eax), %eax               # !76
    movsd    0(%eax), %xmm0              # !81
    ret                                  # !81
o_param_b.1996:                          # !84
    movl    16(%eax), %eax               # !86
    movsd    8(%eax), %xmm0              # !91
    ret                                  # !91
o_param_c.1998:                          # !94
    movl    16(%eax), %eax               # !96
    movsd    16(%eax), %xmm0             # !101
    ret                                  # !101
o_param_x.2000:                          # !104
    movl    20(%eax), %eax               # !106
    movsd    0(%eax), %xmm0              # !111
    ret                                  # !111
o_param_y.2002:                          # !114
    movl    20(%eax), %eax               # !116
    movsd    8(%eax), %xmm0              # !121
    ret                                  # !121
o_param_z.2004:                          # !124
    movl    20(%eax), %eax               # !126
    movsd    16(%eax), %xmm0             # !131
    ret                                  # !131
o_diffuse.2006:                          # !134
    movl    28(%eax), %eax               # !136
    movsd    0(%eax), %xmm0              # !141
    ret                                  # !141
o_hilight.2008:                          # !144
    movl    28(%eax), %eax               # !146
    movsd    8(%eax), %xmm0              # !151
    ret                                  # !151
o_color_red.2010:                        # !154
    movl    32(%eax), %eax               # !156
    movsd    0(%eax), %xmm0              # !161
    ret                                  # !161
o_color_green.2012:                      # !164
    movl    32(%eax), %eax               # !166
    movsd    8(%eax), %xmm0              # !171
    ret                                  # !171
o_color_blue.2014:                       # !174
    movl    32(%eax), %eax               # !176
    movsd    16(%eax), %xmm0             # !181
    ret                                  # !181
o_param_r1.2016:                         # !184
    movl    36(%eax), %eax               # !186
    movsd    0(%eax), %xmm0              # !191
    ret                                  # !191
o_param_r2.2018:                         # !194
    movl    36(%eax), %eax               # !196
    movsd    8(%eax), %xmm0              # !201
    ret                                  # !201
o_param_r3.2020:                         # !204
    movl    36(%eax), %eax               # !206
    movsd    16(%eax), %xmm0             # !211
    ret                                  # !211
normalize_vector.2022:                   # !214
    movsd    0(%eax), %xmm0              # !216
    movl    %ebx, 0(%ebp)                # !216
    movl    %eax, 4(%ebp)                # !216
    addl    $8, %ebp                     # !216
    call    fsqr.1980                    # !216
    subl    $8, %ebp                     # !216
    movl    4(%ebp), %eax                # !216
    movsd    8(%eax), %xmm1              # !216
    movsd    %xmm0, 8(%ebp)              # !216
    movsd    %xmm1, %xmm0                # !216
    addl    $16, %ebp                    # !216
    call    fsqr.1980                    # !216
    subl    $16, %ebp                    # !216
    movsd    8(%ebp), %xmm1              # !216
    addsd    %xmm0, %xmm1                # !216
    movl    4(%ebp), %eax                # !216
    movsd    16(%eax), %xmm0             # !216
    movsd    %xmm1, 16(%ebp)             # !216
    addl    $24, %ebp                    # !216
    call    fsqr.1980                    # !216
    subl    $24, %ebp                    # !216
    movsd    16(%ebp), %xmm1             # !216
    addsd    %xmm1, %xmm0                # !216
    addl    $24, %ebp                    # !216
    call    min_caml_sqrt                # !216
    subl    $24, %ebp                    # !216
    movl    0(%ebp), %eax                # !217
    cmpl    $0, %eax                     # !217
    jne    je_else.5564                  # !217
    jmp    je_cont.5565                  # !217
je_else.5564:                            # !217
    xorpd    min_caml_fnegd, %xmm0       # !217
je_cont.5565:                            # !217
    movl    4(%ebp), %eax                # !218
    movsd    0(%eax), %xmm1              # !218
    divsd    %xmm0, %xmm1                # !218
    movsd    %xmm1, 0(%eax)              # !218
    movsd    8(%eax), %xmm1              # !219
    divsd    %xmm0, %xmm1                # !219
    movsd    %xmm1, 8(%eax)              # !219
    movsd    16(%eax), %xmm1             # !220
    divsd    %xmm0, %xmm1                # !220
    movsd    %xmm1, 16(%eax)             # !220
    ret                                  # !220
sgn.2025:                                # !223
    movl    $l.4442, %eax                # !225
    movsd    0(%eax), %xmm1              # !225
    comisd    %xmm1, %xmm0               # !225
    ja    jbe_else.5567                  # !225
    movl    $l.4446, %eax                # !226
    movsd    0(%eax), %xmm0              # !226
    ret                                  # !226
jbe_else.5567:                           # !225
    movl    $l.4444, %eax                # !225
    movsd    0(%eax), %xmm0              # !225
    ret                                  # !225
rad.2027:                                # !232
    movl    $l.4448, %eax                # !232
    movsd    0(%eax), %xmm1              # !232
    mulsd    %xmm1, %xmm0                # !232
    ret                                  # !232
read_environ.2029:                       # !236
    movl    $min_caml_screen, %eax       # !240
    movl    %eax, 0(%ebp)                # !240
    addl    $8, %ebp                     # !240
    call    min_caml_read_float          # !240
    subl    $8, %ebp                     # !240
    movl    0(%ebp), %eax                # !240
    movsd    %xmm0, 0(%eax)              # !240
    addl    $8, %ebp                     # !241
    call    min_caml_read_float          # !241
    subl    $8, %ebp                     # !241
    movl    0(%ebp), %eax                # !241
    movsd    %xmm0, 8(%eax)              # !241
    addl    $8, %ebp                     # !242
    call    min_caml_read_float          # !242
    subl    $8, %ebp                     # !242
    movl    0(%ebp), %eax                # !242
    movsd    %xmm0, 16(%eax)             # !242
    addl    $8, %ebp                     # !244
    call    min_caml_read_float          # !244
    subl    $8, %ebp                     # !244
    addl    $8, %ebp                     # !244
    call    rad.2027                     # !244
    subl    $8, %ebp                     # !244
    movl    $min_caml_cos_v, %eax        # !245
    movsd    %xmm0, 8(%ebp)              # !245
    movl    %eax, 16(%ebp)               # !245
    addl    $24, %ebp                    # !245
    call    min_caml_cos                 # !245
    subl    $24, %ebp                    # !245
    movl    16(%ebp), %eax               # !245
    movsd    %xmm0, 0(%eax)              # !245
    movl    $min_caml_sin_v, %ebx        # !246
    movsd    8(%ebp), %xmm0              # !246
    movl    %ebx, 20(%ebp)               # !246
    addl    $24, %ebp                    # !246
    call    min_caml_sin                 # !246
    subl    $24, %ebp                    # !246
    movl    20(%ebp), %eax               # !246
    movsd    %xmm0, 0(%eax)              # !246
    addl    $24, %ebp                    # !247
    call    min_caml_read_float          # !247
    subl    $24, %ebp                    # !247
    addl    $24, %ebp                    # !247
    call    rad.2027                     # !247
    subl    $24, %ebp                    # !247
    movsd    %xmm0, 24(%ebp)             # !248
    addl    $32, %ebp                    # !248
    call    min_caml_cos                 # !248
    subl    $32, %ebp                    # !248
    movl    16(%ebp), %eax               # !248
    movsd    %xmm0, 8(%eax)              # !248
    movsd    24(%ebp), %xmm0             # !249
    addl    $32, %ebp                    # !249
    call    min_caml_sin                 # !249
    subl    $32, %ebp                    # !249
    movl    20(%ebp), %eax               # !249
    movsd    %xmm0, 8(%eax)              # !249
    addl    $32, %ebp                    # !251
    call    min_caml_read_float          # !251
    subl    $32, %ebp                    # !251
    addl    $32, %ebp                    # !254
    call    min_caml_read_float          # !254
    subl    $32, %ebp                    # !254
    addl    $32, %ebp                    # !254
    call    rad.2027                     # !254
    subl    $32, %ebp                    # !254
    movsd    %xmm0, 32(%ebp)             # !255
    addl    $40, %ebp                    # !255
    call    min_caml_sin                 # !255
    subl    $40, %ebp                    # !255
    movl    $min_caml_light, %eax        # !256
    xorpd    min_caml_fnegd, %xmm0       # !256
    movsd    %xmm0, 8(%eax)              # !256
    movl    %eax, 40(%ebp)               # !257
    addl    $48, %ebp                    # !257
    call    min_caml_read_float          # !257
    subl    $48, %ebp                    # !257
    addl    $48, %ebp                    # !257
    call    rad.2027                     # !257
    subl    $48, %ebp                    # !257
    movsd    32(%ebp), %xmm1             # !258
    movsd    %xmm0, 48(%ebp)             # !258
    movsd    %xmm1, %xmm0                # !258
    addl    $56, %ebp                    # !258
    call    min_caml_cos                 # !258
    subl    $56, %ebp                    # !258
    movsd    48(%ebp), %xmm1             # !259
    movsd    %xmm0, 56(%ebp)             # !259
    movsd    %xmm1, %xmm0                # !259
    addl    $64, %ebp                    # !259
    call    min_caml_sin                 # !259
    subl    $64, %ebp                    # !259
    movsd    56(%ebp), %xmm1             # !260
    mulsd    %xmm1, %xmm0                # !260
    movl    40(%ebp), %eax               # !260
    movsd    %xmm0, 0(%eax)              # !260
    movsd    48(%ebp), %xmm0             # !261
    addl    $64, %ebp                    # !261
    call    min_caml_cos                 # !261
    subl    $64, %ebp                    # !261
    movsd    56(%ebp), %xmm1             # !262
    mulsd    %xmm0, %xmm1                # !262
    movl    40(%ebp), %eax               # !262
    movsd    %xmm1, 16(%eax)             # !262
    movl    $min_caml_beam, %eax         # !263
    movl    %eax, 64(%ebp)               # !263
    addl    $72, %ebp                    # !263
    call    min_caml_read_float          # !263
    subl    $72, %ebp                    # !263
    movl    64(%ebp), %eax               # !263
    movsd    %xmm0, 0(%eax)              # !263
    movl    $min_caml_vp, %eax           # !266
    movl    16(%ebp), %ebx               # !266
    movsd    0(%ebx), %xmm0              # !266
    movl    20(%ebp), %ecx               # !266
    movsd    8(%ecx), %xmm1              # !266
    mulsd    %xmm1, %xmm0                # !266
    movl    $l.4450, %edx                # !266
    movsd    0(%edx), %xmm1              # !266
    mulsd    %xmm1, %xmm0                # !266
    movsd    %xmm0, 0(%eax)              # !266
    movsd    0(%ecx), %xmm0              # !267
    xorpd    min_caml_fnegd, %xmm0       # !267
    mulsd    %xmm1, %xmm0                # !267
    movsd    %xmm0, 8(%eax)              # !267
    movsd    0(%ebx), %xmm0              # !268
    movsd    8(%ebx), %xmm2              # !268
    mulsd    %xmm2, %xmm0                # !268
    mulsd    %xmm0, %xmm1                # !268
    movsd    %xmm1, 16(%eax)             # !268
    movl    $min_caml_view, %ebx         # !271
    movsd    0(%eax), %xmm0              # !271
    movl    0(%ebp), %ecx                # !271
    movsd    0(%ecx), %xmm1              # !271
    addsd    %xmm1, %xmm0                # !271
    movsd    %xmm0, 0(%ebx)              # !271
    movsd    8(%eax), %xmm0              # !272
    movsd    8(%ecx), %xmm1              # !272
    addsd    %xmm1, %xmm0                # !272
    movsd    %xmm0, 8(%ebx)              # !272
    movsd    16(%eax), %xmm0             # !273
    movsd    16(%ecx), %xmm1             # !273
    addsd    %xmm1, %xmm0                # !273
    movsd    %xmm0, 16(%ebx)             # !273
    ret                                  # !273
read_nth_object.2031:                    # !277
    movl    %eax, 0(%ebp)                # !281
    addl    $8, %ebp                     # !281
    call    min_caml_read_int            # !281
    subl    $8, %ebp                     # !281
    cmpl    $-1, %eax                    # !282
    jne    je_else.5571                  # !282
    movl    $0, %eax                     # !397
    ret                                  # !397
je_else.5571:                            # !282
    movl    %eax, 4(%ebp)                # !284
    addl    $8, %ebp                     # !284
    call    min_caml_read_int            # !284
    subl    $8, %ebp                     # !284
    movl    %eax, 8(%ebp)                # !285
    addl    $16, %ebp                    # !285
    call    min_caml_read_int            # !285
    subl    $16, %ebp                    # !285
    movl    %eax, 12(%ebp)               # !286
    addl    $16, %ebp                    # !286
    call    min_caml_read_int            # !286
    subl    $16, %ebp                    # !286
    movl    $3, %ebx                     # !288
    movl    $l.4442, %ecx                # !288
    movsd    0(%ecx), %xmm0              # !288
    movl    %eax, 16(%ebp)               # !288
    movsd    %xmm0, 24(%ebp)             # !288
    movl    %ebx, 32(%ebp)               # !288
    movl    %ebx, %eax                   # !288
    addl    $40, %ebp                    # !288
    call    min_caml_create_float_array  # !288
    subl    $40, %ebp                    # !288
    movl    $0, %ebx                     # !290
    movl    %ebx, 36(%ebp)               # !290
    movl    %eax, 40(%ebp)               # !290
    addl    $48, %ebp                    # !290
    call    min_caml_read_float          # !290
    subl    $48, %ebp                    # !290
    movl    40(%ebp), %eax               # !290
    movsd    %xmm0, 0(%eax)              # !290
    movl    $1, %ebx                     # !291
    movl    %ebx, 44(%ebp)               # !291
    addl    $48, %ebp                    # !291
    call    min_caml_read_float          # !291
    subl    $48, %ebp                    # !291
    movl    40(%ebp), %eax               # !291
    movsd    %xmm0, 8(%eax)              # !291
    movl    $2, %ebx                     # !292
    movl    %ebx, 48(%ebp)               # !292
    addl    $56, %ebp                    # !292
    call    min_caml_read_float          # !292
    subl    $56, %ebp                    # !292
    movl    40(%ebp), %eax               # !292
    movsd    %xmm0, 16(%eax)             # !292
    movsd    24(%ebp), %xmm0             # !294
    movl    32(%ebp), %ebx               # !294
    movl    %ebx, %eax                   # !294
    addl    $56, %ebp                    # !294
    call    min_caml_create_float_array  # !294
    subl    $56, %ebp                    # !294
    movl    %eax, 52(%ebp)               # !296
    addl    $56, %ebp                    # !296
    call    min_caml_read_float          # !296
    subl    $56, %ebp                    # !296
    movl    52(%ebp), %eax               # !296
    movsd    %xmm0, 0(%eax)              # !296
    addl    $56, %ebp                    # !297
    call    min_caml_read_float          # !297
    subl    $56, %ebp                    # !297
    movl    52(%ebp), %eax               # !297
    movsd    %xmm0, 8(%eax)              # !297
    addl    $56, %ebp                    # !298
    call    min_caml_read_float          # !298
    subl    $56, %ebp                    # !298
    movl    52(%ebp), %eax               # !298
    movsd    %xmm0, 16(%eax)             # !298
    addl    $56, %ebp                    # !300
    call    min_caml_read_float          # !300
    subl    $56, %ebp                    # !300
    movsd    24(%ebp), %xmm1             # !300
    comisd    %xmm0, %xmm1               # !300
    ja    jbe_else.5573                  # !300
    movl    36(%ebp), %eax               # !300
    jmp    jbe_cont.5574                 # !300
jbe_else.5573:                           # !300
    movl    44(%ebp), %eax               # !300
jbe_cont.5574:                           # !300
    movl    48(%ebp), %ebx               # !302
    movl    %eax, 56(%ebp)               # !302
    movl    %ebx, %eax                   # !302
    movsd    %xmm1, %xmm0                # !302
    addl    $64, %ebp                    # !302
    call    min_caml_create_float_array  # !302
    subl    $64, %ebp                    # !302
    movl    %eax, 60(%ebp)               # !304
    addl    $64, %ebp                    # !304
    call    min_caml_read_float          # !304
    subl    $64, %ebp                    # !304
    movl    60(%ebp), %eax               # !304
    movsd    %xmm0, 0(%eax)              # !304
    addl    $64, %ebp                    # !305
    call    min_caml_read_float          # !305
    subl    $64, %ebp                    # !305
    movl    60(%ebp), %eax               # !305
    movsd    %xmm0, 8(%eax)              # !305
    movsd    24(%ebp), %xmm0             # !307
    movl    32(%ebp), %ebx               # !307
    movl    %ebx, %eax                   # !307
    addl    $64, %ebp                    # !307
    call    min_caml_create_float_array  # !307
    subl    $64, %ebp                    # !307
    movl    %eax, 64(%ebp)               # !309
    addl    $72, %ebp                    # !309
    call    min_caml_read_float          # !309
    subl    $72, %ebp                    # !309
    movl    64(%ebp), %eax               # !309
    movsd    %xmm0, 0(%eax)              # !309
    addl    $72, %ebp                    # !310
    call    min_caml_read_float          # !310
    subl    $72, %ebp                    # !310
    movl    64(%ebp), %eax               # !310
    movsd    %xmm0, 8(%eax)              # !310
    addl    $72, %ebp                    # !311
    call    min_caml_read_float          # !311
    subl    $72, %ebp                    # !311
    movl    64(%ebp), %eax               # !311
    movsd    %xmm0, 16(%eax)             # !311
    movsd    24(%ebp), %xmm0             # !313
    movl    32(%ebp), %ebx               # !313
    movl    %ebx, %eax                   # !313
    addl    $72, %ebp                    # !313
    call    min_caml_create_float_array  # !313
    subl    $72, %ebp                    # !313
    movl    16(%ebp), %ebx               # !314
    cmpl    $0, %ebx                     # !314
    jne    je_else.5575                  # !314
    jmp    je_cont.5576                  # !314
je_else.5575:                            # !314
    movl    %eax, 68(%ebp)               # !316
    addl    $72, %ebp                    # !316
    call    min_caml_read_float          # !316
    subl    $72, %ebp                    # !316
    addl    $72, %ebp                    # !316
    call    rad.2027                     # !316
    subl    $72, %ebp                    # !316
    movl    68(%ebp), %eax               # !316
    movsd    %xmm0, 0(%eax)              # !316
    addl    $72, %ebp                    # !317
    call    min_caml_read_float          # !317
    subl    $72, %ebp                    # !317
    addl    $72, %ebp                    # !317
    call    rad.2027                     # !317
    subl    $72, %ebp                    # !317
    movl    68(%ebp), %eax               # !317
    movsd    %xmm0, 8(%eax)              # !317
    addl    $72, %ebp                    # !318
    call    min_caml_read_float          # !318
    subl    $72, %ebp                    # !318
    addl    $72, %ebp                    # !318
    call    rad.2027                     # !318
    subl    $72, %ebp                    # !318
    movl    68(%ebp), %eax               # !318
    movsd    %xmm0, 16(%eax)             # !318
je_cont.5576:                            # !314
    movl    8(%ebp), %ebx                # !325
    cmpl    $2, %ebx                     # !325
    jne    je_else.5577                  # !325
    movl    44(%ebp), %ecx               # !325
    jmp    je_cont.5578                  # !325
je_else.5577:                            # !325
    movl    56(%ebp), %ecx               # !325
je_cont.5578:                            # !325
    movl    min_caml_hp, %edx            # !329
    addl    $40, min_caml_hp             # !329
    movl    %eax, 36(%edx)               # !329
    movl    64(%ebp), %esi               # !329
    movl    %esi, 32(%edx)               # !329
    movl    60(%ebp), %esi               # !329
    movl    %esi, 28(%edx)               # !329
    movl    %ecx, 24(%edx)               # !329
    movl    52(%ebp), %ecx               # !329
    movl    %ecx, 20(%edx)               # !329
    movl    40(%ebp), %ecx               # !329
    movl    %ecx, 16(%edx)               # !329
    movl    16(%ebp), %esi               # !329
    movl    %esi, 12(%edx)               # !329
    movl    12(%ebp), %edi               # !329
    movl    %edi, 8(%edx)                # !329
    movl    %ebx, 4(%edx)                # !329
    movl    4(%ebp), %edi                # !329
    movl    %edi, 0(%edx)                # !329
    movl    $min_caml_objects, %edi      # !336
    movl    %eax, 68(%ebp)               # !336
    movl    0(%ebp), %eax                # !336
    movl    %edx, (%edi,%eax,4)          # !336
    cmpl    $3, %ebx                     # !338
    jne    je_else.5579                  # !338
    movsd    0(%ecx), %xmm0              # !341
    movsd    24(%ebp), %xmm1             # !342
    comisd    %xmm0, %xmm1               # !342
    jne    je_else.5581                  # !342
    jmp    je_cont.5582                  # !342
je_else.5581:                            # !342
    movsd    %xmm0, 72(%ebp)             # !342
    addl    $80, %ebp                    # !342
    call    sgn.2025                     # !342
    subl    $80, %ebp                    # !342
    movsd    72(%ebp), %xmm1             # !342
    movsd    %xmm0, 80(%ebp)             # !342
    movsd    %xmm1, %xmm0                # !342
    addl    $88, %ebp                    # !342
    call    fsqr.1980                    # !342
    subl    $88, %ebp                    # !342
    movsd    80(%ebp), %xmm1             # !342
    divsd    %xmm0, %xmm1                # !342
je_cont.5582:                            # !342
    movl    40(%ebp), %eax               # !342
    movsd    %xmm1, 0(%eax)              # !342
    movsd    8(%eax), %xmm0              # !343
    movsd    24(%ebp), %xmm1             # !344
    comisd    %xmm0, %xmm1               # !344
    jne    je_else.5583                  # !344
    jmp    je_cont.5584                  # !344
je_else.5583:                            # !344
    movsd    %xmm0, 88(%ebp)             # !344
    addl    $96, %ebp                    # !344
    call    sgn.2025                     # !344
    subl    $96, %ebp                    # !344
    movsd    88(%ebp), %xmm1             # !344
    movsd    %xmm0, 96(%ebp)             # !344
    movsd    %xmm1, %xmm0                # !344
    addl    $104, %ebp                   # !344
    call    fsqr.1980                    # !344
    subl    $104, %ebp                   # !344
    movsd    96(%ebp), %xmm1             # !344
    divsd    %xmm0, %xmm1                # !344
je_cont.5584:                            # !344
    movl    40(%ebp), %eax               # !344
    movsd    %xmm1, 8(%eax)              # !344
    movsd    16(%eax), %xmm0             # !345
    movsd    24(%ebp), %xmm1             # !346
    comisd    %xmm0, %xmm1               # !346
    jne    je_else.5585                  # !346
    jmp    je_cont.5586                  # !346
je_else.5585:                            # !346
    movsd    %xmm0, 104(%ebp)            # !346
    addl    $112, %ebp                   # !346
    call    sgn.2025                     # !346
    subl    $112, %ebp                   # !346
    movsd    104(%ebp), %xmm1            # !346
    movsd    %xmm0, 112(%ebp)            # !346
    movsd    %xmm1, %xmm0                # !346
    addl    $120, %ebp                   # !346
    call    fsqr.1980                    # !346
    subl    $120, %ebp                   # !346
    movsd    112(%ebp), %xmm1            # !346
    divsd    %xmm0, %xmm1                # !346
je_cont.5586:                            # !346
    movl    40(%ebp), %eax               # !346
    movsd    %xmm1, 16(%eax)             # !346
    jmp    je_cont.5580                  # !338
je_else.5579:                            # !338
    cmpl    $2, %ebx                     # !348
    jne    je_else.5587                  # !348
    movl    56(%ebp), %eax               # !350
    cmpl    $0, %eax                     # !350
    jne    je_else.5589                  # !350
    movl    44(%ebp), %eax               # !350
    movl    %eax, %ebx                   # !350
    jmp    je_cont.5590                  # !350
je_else.5589:                            # !350
    movl    36(%ebp), %eax               # !350
    movl    %eax, %ebx                   # !350
je_cont.5590:                            # !350
    movl    %ecx, %eax                   # !350
    addl    $120, %ebp                   # !350
    call    normalize_vector.2022        # !350
    subl    $120, %ebp                   # !350
    jmp    je_cont.5588                  # !348
je_else.5587:                            # !348
je_cont.5588:                            # !348
je_cont.5580:                            # !338
    movl    16(%ebp), %eax               # !354
    cmpl    $0, %eax                     # !354
    jne    je_else.5591                  # !354
    jmp    je_cont.5592                  # !354
je_else.5591:                            # !354
    movl    $min_caml_cs_temp, %eax      # !356
    movl    68(%ebp), %ebx               # !356
    movsd    0(%ebx), %xmm0              # !356
    movl    %eax, 120(%ebp)              # !356
    addl    $128, %ebp                   # !356
    call    min_caml_cos                 # !356
    subl    $128, %ebp                   # !356
    movl    120(%ebp), %eax              # !356
    movsd    %xmm0, 80(%eax)             # !356
    movl    68(%ebp), %ebx               # !357
    movsd    0(%ebx), %xmm0              # !357
    addl    $128, %ebp                   # !357
    call    min_caml_sin                 # !357
    subl    $128, %ebp                   # !357
    movl    120(%ebp), %eax              # !357
    movsd    %xmm0, 88(%eax)             # !357
    movl    68(%ebp), %ebx               # !358
    movsd    8(%ebx), %xmm0              # !358
    addl    $128, %ebp                   # !358
    call    min_caml_cos                 # !358
    subl    $128, %ebp                   # !358
    movl    120(%ebp), %eax              # !358
    movsd    %xmm0, 96(%eax)             # !358
    movl    68(%ebp), %ebx               # !359
    movsd    8(%ebx), %xmm0              # !359
    addl    $128, %ebp                   # !359
    call    min_caml_sin                 # !359
    subl    $128, %ebp                   # !359
    movl    120(%ebp), %eax              # !359
    movsd    %xmm0, 104(%eax)            # !359
    movl    68(%ebp), %ebx               # !360
    movsd    16(%ebx), %xmm0             # !360
    addl    $128, %ebp                   # !360
    call    min_caml_cos                 # !360
    subl    $128, %ebp                   # !360
    movl    120(%ebp), %eax              # !360
    movsd    %xmm0, 112(%eax)            # !360
    movl    68(%ebp), %ebx               # !361
    movsd    16(%ebx), %xmm0             # !361
    addl    $128, %ebp                   # !361
    call    min_caml_sin                 # !361
    subl    $128, %ebp                   # !361
    movl    120(%ebp), %eax              # !361
    movsd    %xmm0, 120(%eax)            # !361
    movsd    96(%eax), %xmm0             # !362
    movsd    112(%eax), %xmm1            # !362
    mulsd    %xmm1, %xmm0                # !362
    movsd    %xmm0, 0(%eax)              # !362
    movsd    88(%eax), %xmm0             # !364
    movsd    104(%eax), %xmm1            # !364
    mulsd    %xmm1, %xmm0                # !364
    movsd    112(%eax), %xmm1            # !364
    mulsd    %xmm1, %xmm0                # !364
    movsd    80(%eax), %xmm1             # !364
    movsd    120(%eax), %xmm2            # !364
    mulsd    %xmm2, %xmm1                # !364
    subsd    %xmm1, %xmm0                # !364
    movsd    %xmm0, 8(%eax)              # !363
    movsd    80(%eax), %xmm0             # !366
    movsd    104(%eax), %xmm1            # !366
    mulsd    %xmm1, %xmm0                # !366
    movsd    112(%eax), %xmm1            # !366
    mulsd    %xmm1, %xmm0                # !366
    movsd    88(%eax), %xmm1             # !366
    movsd    120(%eax), %xmm2            # !366
    mulsd    %xmm2, %xmm1                # !366
    addsd    %xmm1, %xmm0                # !366
    movsd    %xmm0, 16(%eax)             # !365
    movsd    96(%eax), %xmm0             # !367
    movsd    120(%eax), %xmm1            # !367
    mulsd    %xmm1, %xmm0                # !367
    movsd    %xmm0, 24(%eax)             # !367
    movsd    88(%eax), %xmm0             # !369
    movsd    104(%eax), %xmm1            # !369
    mulsd    %xmm1, %xmm0                # !369
    movsd    120(%eax), %xmm1            # !369
    mulsd    %xmm1, %xmm0                # !369
    movsd    80(%eax), %xmm1             # !369
    movsd    112(%eax), %xmm2            # !369
    mulsd    %xmm2, %xmm1                # !369
    addsd    %xmm1, %xmm0                # !369
    movsd    %xmm0, 32(%eax)             # !368
    movsd    80(%eax), %xmm0             # !371
    movsd    104(%eax), %xmm1            # !371
    mulsd    %xmm1, %xmm0                # !371
    movsd    120(%eax), %xmm1            # !371
    mulsd    %xmm1, %xmm0                # !371
    movsd    88(%eax), %xmm1             # !371
    movsd    112(%eax), %xmm2            # !371
    mulsd    %xmm2, %xmm1                # !371
    subsd    %xmm1, %xmm0                # !371
    movsd    %xmm0, 40(%eax)             # !370
    movsd    104(%eax), %xmm0            # !372
    xorpd    min_caml_fnegd, %xmm0       # !372
    movsd    %xmm0, 48(%eax)             # !372
    movsd    88(%eax), %xmm0             # !373
    movsd    96(%eax), %xmm1             # !373
    mulsd    %xmm1, %xmm0                # !373
    movsd    %xmm0, 56(%eax)             # !373
    movsd    80(%eax), %xmm0             # !374
    movsd    96(%eax), %xmm1             # !374
    mulsd    %xmm1, %xmm0                # !374
    movsd    %xmm0, 64(%eax)             # !374
    movl    40(%ebp), %ebx               # !375
    movsd    0(%ebx), %xmm0              # !375
    movsd    8(%ebx), %xmm1              # !376
    movsd    16(%ebx), %xmm2             # !377
    movsd    0(%eax), %xmm3              # !378
    movsd    %xmm2, 128(%ebp)            # !378
    movsd    %xmm1, 136(%ebp)            # !378
    movsd    %xmm0, 144(%ebp)            # !378
    movsd    %xmm3, %xmm0                # !378
    addl    $152, %ebp                   # !378
    call    fsqr.1980                    # !378
    subl    $152, %ebp                   # !378
    movsd    144(%ebp), %xmm1            # !378
    mulsd    %xmm1, %xmm0                # !378
    movl    120(%ebp), %eax              # !378
    movsd    24(%eax), %xmm2             # !378
    movsd    %xmm0, 152(%ebp)            # !378
    movsd    %xmm2, %xmm0                # !378
    addl    $160, %ebp                   # !378
    call    fsqr.1980                    # !378
    subl    $160, %ebp                   # !378
    movsd    136(%ebp), %xmm1            # !378
    mulsd    %xmm1, %xmm0                # !378
    movsd    152(%ebp), %xmm2            # !378
    addsd    %xmm0, %xmm2                # !378
    movl    120(%ebp), %eax              # !378
    movsd    48(%eax), %xmm0             # !378
    movsd    %xmm2, 160(%ebp)            # !378
    addl    $168, %ebp                   # !378
    call    fsqr.1980                    # !378
    subl    $168, %ebp                   # !378
    movsd    128(%ebp), %xmm1            # !378
    mulsd    %xmm1, %xmm0                # !378
    movsd    160(%ebp), %xmm2            # !378
    addsd    %xmm0, %xmm2                # !378
    movl    40(%ebp), %eax               # !378
    movsd    %xmm2, 0(%eax)              # !378
    movl    120(%ebp), %ebx              # !379
    movsd    8(%ebx), %xmm0              # !379
    addl    $168, %ebp                   # !379
    call    fsqr.1980                    # !379
    subl    $168, %ebp                   # !379
    movsd    144(%ebp), %xmm1            # !379
    mulsd    %xmm1, %xmm0                # !379
    movl    120(%ebp), %eax              # !379
    movsd    32(%eax), %xmm2             # !379
    movsd    %xmm0, 168(%ebp)            # !379
    movsd    %xmm2, %xmm0                # !379
    addl    $176, %ebp                   # !379
    call    fsqr.1980                    # !379
    subl    $176, %ebp                   # !379
    movsd    136(%ebp), %xmm1            # !379
    mulsd    %xmm1, %xmm0                # !379
    movsd    168(%ebp), %xmm2            # !379
    addsd    %xmm0, %xmm2                # !379
    movl    120(%ebp), %eax              # !379
    movsd    56(%eax), %xmm0             # !379
    movsd    %xmm2, 176(%ebp)            # !379
    addl    $184, %ebp                   # !379
    call    fsqr.1980                    # !379
    subl    $184, %ebp                   # !379
    movsd    128(%ebp), %xmm1            # !379
    mulsd    %xmm1, %xmm0                # !379
    movsd    176(%ebp), %xmm2            # !379
    addsd    %xmm0, %xmm2                # !379
    movl    40(%ebp), %eax               # !379
    movsd    %xmm2, 8(%eax)              # !379
    movl    120(%ebp), %ebx              # !380
    movsd    16(%ebx), %xmm0             # !380
    addl    $184, %ebp                   # !380
    call    fsqr.1980                    # !380
    subl    $184, %ebp                   # !380
    movsd    144(%ebp), %xmm1            # !380
    mulsd    %xmm1, %xmm0                # !380
    movl    120(%ebp), %eax              # !380
    movsd    40(%eax), %xmm2             # !380
    movsd    %xmm0, 184(%ebp)            # !380
    movsd    %xmm2, %xmm0                # !380
    addl    $192, %ebp                   # !380
    call    fsqr.1980                    # !380
    subl    $192, %ebp                   # !380
    movsd    136(%ebp), %xmm1            # !380
    mulsd    %xmm1, %xmm0                # !380
    movsd    184(%ebp), %xmm2            # !380
    addsd    %xmm0, %xmm2                # !380
    movl    120(%ebp), %eax              # !380
    movsd    64(%eax), %xmm0             # !380
    movsd    %xmm2, 192(%ebp)            # !380
    addl    $200, %ebp                   # !380
    call    fsqr.1980                    # !380
    subl    $200, %ebp                   # !380
    movsd    128(%ebp), %xmm1            # !380
    mulsd    %xmm1, %xmm0                # !380
    movsd    192(%ebp), %xmm2            # !380
    addsd    %xmm0, %xmm2                # !380
    movl    40(%ebp), %eax               # !380
    movsd    %xmm2, 16(%eax)             # !380
    movl    $l.4440, %eax                # !381
    movsd    0(%eax), %xmm0              # !381
    movl    120(%ebp), %eax              # !381
    movsd    8(%eax), %xmm2              # !381
    movsd    144(%ebp), %xmm3            # !381
    mulsd    %xmm3, %xmm2                # !381
    movsd    16(%eax), %xmm4             # !381
    mulsd    %xmm4, %xmm2                # !381
    movsd    32(%eax), %xmm4             # !382
    movsd    136(%ebp), %xmm5            # !382
    mulsd    %xmm5, %xmm4                # !382
    movsd    40(%eax), %xmm6             # !382
    mulsd    %xmm6, %xmm4                # !382
    addsd    %xmm4, %xmm2                # !381
    movsd    56(%eax), %xmm4             # !383
    mulsd    %xmm1, %xmm4                # !383
    movsd    64(%eax), %xmm6             # !383
    mulsd    %xmm6, %xmm4                # !383
    addsd    %xmm4, %xmm2                # !381
    mulsd    %xmm0, %xmm2                # !381
    movl    68(%ebp), %ebx               # !381
    movsd    %xmm2, 0(%ebx)              # !381
    movsd    0(%eax), %xmm2              # !384
    mulsd    %xmm3, %xmm2                # !384
    movsd    16(%eax), %xmm4             # !384
    mulsd    %xmm4, %xmm2                # !384
    movsd    24(%eax), %xmm4             # !385
    mulsd    %xmm5, %xmm4                # !385
    movsd    40(%eax), %xmm6             # !385
    mulsd    %xmm6, %xmm4                # !385
    addsd    %xmm4, %xmm2                # !384
    movsd    48(%eax), %xmm4             # !386
    mulsd    %xmm1, %xmm4                # !386
    movsd    64(%eax), %xmm6             # !386
    mulsd    %xmm6, %xmm4                # !386
    addsd    %xmm4, %xmm2                # !384
    mulsd    %xmm0, %xmm2                # !384
    movsd    %xmm2, 8(%ebx)              # !384
    movsd    0(%eax), %xmm2              # !387
    mulsd    %xmm3, %xmm2                # !387
    movsd    8(%eax), %xmm3              # !387
    mulsd    %xmm3, %xmm2                # !387
    movsd    24(%eax), %xmm3             # !388
    mulsd    %xmm5, %xmm3                # !388
    movsd    32(%eax), %xmm4             # !388
    mulsd    %xmm4, %xmm3                # !388
    addsd    %xmm3, %xmm2                # !387
    movsd    48(%eax), %xmm3             # !389
    mulsd    %xmm1, %xmm3                # !389
    movsd    56(%eax), %xmm1             # !389
    mulsd    %xmm1, %xmm3                # !389
    addsd    %xmm3, %xmm2                # !387
    mulsd    %xmm2, %xmm0                # !387
    movsd    %xmm0, 16(%ebx)             # !387
je_cont.5592:                            # !354
    movl    44(%ebp), %eax               # !394
    ret                                  # !394
read_object.2033:                        # !401
    cmpl    $61, %eax                    # !403
    jl    jge_else.5594                  # !403
    ret                                  # !407
jge_else.5594:                           # !403
    movl    %eax, 0(%ebp)                # !404
    addl    $8, %ebp                     # !404
    call    read_nth_object.2031         # !404
    subl    $8, %ebp                     # !404
    cmpl    $0, %eax                     # !404
    jne    je_else.5596                  # !404
    ret                                  # !406
je_else.5596:                            # !404
    movl    0(%ebp), %eax                # !405
    addl    $1, %eax                     # !405
    jmp    read_object.2033              # !405
read_all_object.2035:                    # !410
    movl    $0, %eax                     # !412
    jmp    read_object.2033              # !412
read_net_item.2037:                      # !418
    movl    %eax, 0(%ebp)                # !420
    addl    $8, %ebp                     # !420
    call    min_caml_read_int            # !420
    subl    $8, %ebp                     # !420
    movl    $-1, %ebx                    # !421
    cmpl    $-1, %eax                    # !421
    jne    je_else.5598                  # !421
    movl    0(%ebp), %eax                # !421
    addl    $1, %eax                     # !421
    jmp    min_caml_create_array         # !421
je_else.5598:                            # !421
    movl    0(%ebp), %ebx                # !423
    movl    %ebx, %ecx                   # !423
    addl    $1, %ecx                     # !423
    movl    %eax, 4(%ebp)                # !423
    movl    %ecx, %eax                   # !423
    addl    $8, %ebp                     # !423
    call    read_net_item.2037           # !423
    subl    $8, %ebp                     # !423
    movl    0(%ebp), %ebx                # !424
    movl    4(%ebp), %ecx                # !424
    movl    %ecx, (%eax,%ebx,4)          # !424
    ret                                  # !424
read_or_network.2039:                    # !427
    movl    $0, %ebx                     # !429
    movl    %eax, 0(%ebp)                # !429
    movl    %ebx, %eax                   # !429
    addl    $8, %ebp                     # !429
    call    read_net_item.2037           # !429
    subl    $8, %ebp                     # !429
    movl    %eax, %ebx                   # !429
    movl    0(%ebx), %eax                # !430
    cmpl    $-1, %eax                    # !430
    jne    je_else.5599                  # !430
    movl    0(%ebp), %eax                # !431
    addl    $1, %eax                     # !431
    jmp    min_caml_create_array         # !431
je_else.5599:                            # !430
    movl    0(%ebp), %eax                # !433
    movl    %eax, %ecx                   # !433
    addl    $1, %ecx                     # !433
    movl    %ebx, 4(%ebp)                # !433
    movl    %ecx, %eax                   # !433
    addl    $8, %ebp                     # !433
    call    read_or_network.2039         # !433
    subl    $8, %ebp                     # !433
    movl    0(%ebp), %ebx                # !434
    movl    4(%ebp), %ecx                # !434
    movl    %ecx, (%eax,%ebx,4)          # !434
    ret                                  # !434
read_and_network.2041:                   # !437
    movl    $0, %ebx                     # !439
    movl    %eax, 0(%ebp)                # !439
    movl    %ebx, %eax                   # !439
    addl    $8, %ebp                     # !439
    call    read_net_item.2037           # !439
    subl    $8, %ebp                     # !439
    movl    0(%eax), %ebx                # !440
    cmpl    $-1, %ebx                    # !440
    jne    je_else.5600                  # !440
    ret                                  # !440
je_else.5600:                            # !440
    movl    $min_caml_and_net, %ebx      # !442
    movl    0(%ebp), %ecx                # !442
    movl    %eax, (%ebx,%ecx,4)          # !442
    movl    %ecx, %eax                   # !443
    addl    $1, %eax                     # !443
    jmp    read_and_network.2041         # !443
read_parameter.2043:                     # !447
    call    read_environ.2029            # !450
    call    read_all_object.2035         # !451
    movl    $0, %eax                     # !452
    movl    %eax, 0(%ebp)                # !452
    addl    $8, %ebp                     # !452
    call    read_and_network.2041        # !452
    subl    $8, %ebp                     # !452
    movl    $min_caml_or_net, %eax       # !453
    movl    0(%ebp), %ebx                # !453
    movl    %eax, 4(%ebp)                # !453
    movl    %ebx, %eax                   # !453
    addl    $8, %ebp                     # !453
    call    read_or_network.2039         # !453
    subl    $8, %ebp                     # !453
    movl    4(%ebp), %ebx                # !453
    movl    %eax, 0(%ebx)                # !453
    ret                                  # !453
solver_rect.2045:                        # !462
    movl    $l.4442, %ecx                # !466
    movsd    0(%ecx), %xmm0              # !466
    movl    $0, %ecx                     # !466
    movsd    0(%ebx), %xmm1              # !466
    movl    %eax, 0(%ebp)                # !466
    movl    %ecx, 4(%ebp)                # !466
    movsd    %xmm0, 8(%ebp)              # !466
    movl    %ebx, 16(%ebp)               # !466
    comisd    %xmm1, %xmm0               # !466
    jne    je_else.5603                  # !466
    jmp    je_cont.5604                  # !466
je_else.5603:                            # !466
    addl    $24, %ebp                    # !468
    call    o_isinvert.1990              # !468
    subl    $24, %ebp                    # !468
    movl    16(%ebp), %ebx               # !468
    movsd    0(%ebx), %xmm0              # !468
    movsd    8(%ebp), %xmm1              # !468
    comisd    %xmm0, %xmm1               # !468
    ja    jbe_else.5605                  # !468
    movl    4(%ebp), %ecx                # !468
    jmp    jbe_cont.5606                 # !468
jbe_else.5605:                           # !468
    movl    $1, %ecx                     # !468
jbe_cont.5606:                           # !468
    movl    %ecx, %ebx                   # !468
    addl    $24, %ebp                    # !468
    call    xor.1977                     # !468
    subl    $24, %ebp                    # !468
    cmpl    $0, %eax                     # !468
    jne    je_else.5607                  # !468
    movl    0(%ebp), %eax                # !468
    addl    $24, %ebp                    # !468
    call    o_param_a.1994               # !468
    subl    $24, %ebp                    # !468
    xorpd    min_caml_fnegd, %xmm0       # !468
    jmp    je_cont.5608                  # !468
je_else.5607:                            # !468
    movl    0(%ebp), %eax                # !468
    addl    $24, %ebp                    # !468
    call    o_param_a.1994               # !468
    subl    $24, %ebp                    # !468
je_cont.5608:                            # !468
    movl    $min_caml_solver_w_vec, %eax # !470
    movsd    0(%eax), %xmm1              # !470
    subsd    %xmm1, %xmm0                # !470
    movl    16(%ebp), %ebx               # !470
    movsd    0(%ebx), %xmm1              # !470
    divsd    %xmm1, %xmm0                # !470
    movl    0(%ebp), %ecx                # !472
    movl    %eax, 20(%ebp)               # !472
    movsd    %xmm0, 24(%ebp)             # !472
    movl    %ecx, %eax                   # !472
    addl    $32, %ebp                    # !472
    call    o_param_b.1996               # !472
    subl    $32, %ebp                    # !472
    movl    $1, %eax                     # !472
    movl    16(%ebp), %ebx               # !472
    movsd    8(%ebx), %xmm1              # !472
    movsd    24(%ebp), %xmm2             # !472
    mulsd    %xmm2, %xmm1                # !472
    movl    20(%ebp), %ecx               # !472
    movsd    8(%ecx), %xmm3              # !472
    addsd    %xmm3, %xmm1                # !472
    movl    %eax, 32(%ebp)               # !472
    movsd    %xmm0, 40(%ebp)             # !472
    movsd    %xmm1, %xmm0                # !472
    addl    $48, %ebp                    # !472
    call    min_caml_abs_float           # !472
    subl    $48, %ebp                    # !472
    movsd    40(%ebp), %xmm1             # !472
    comisd    %xmm0, %xmm1               # !472
    ja    jbe_else.5610                  # !472
    movl    4(%ebp), %eax                # !476
    movl    %eax, %ecx                   # !476
    jmp    jbe_cont.5611                 # !472
jbe_else.5610:                           # !472
    movl    0(%ebp), %eax                # !473
    addl    $48, %ebp                    # !473
    call    o_param_c.1998               # !473
    subl    $48, %ebp                    # !473
    movl    16(%ebp), %eax               # !473
    movsd    16(%eax), %xmm1             # !473
    movsd    24(%ebp), %xmm2             # !473
    mulsd    %xmm2, %xmm1                # !473
    movl    20(%ebp), %ebx               # !473
    movsd    16(%ebx), %xmm3             # !473
    addsd    %xmm3, %xmm1                # !473
    movsd    %xmm0, 48(%ebp)             # !473
    movsd    %xmm1, %xmm0                # !473
    addl    $56, %ebp                    # !473
    call    min_caml_abs_float           # !473
    subl    $56, %ebp                    # !473
    movsd    48(%ebp), %xmm1             # !473
    comisd    %xmm0, %xmm1               # !473
    ja    jbe_else.5612                  # !473
    movl    4(%ebp), %eax                # !475
    movl    %eax, %ecx                   # !475
    jmp    jbe_cont.5613                 # !473
jbe_else.5612:                           # !473
    movl    $min_caml_solver_dist, %eax  # !474
    movsd    24(%ebp), %xmm0             # !474
    movsd    %xmm0, 0(%eax)              # !474
    movl    32(%ebp), %eax               # !474
    movl    %eax, %ecx                   # !474
jbe_cont.5613:                           # !473
jbe_cont.5611:                           # !472
je_cont.5604:                            # !466
    cmpl    $0, %ecx                     # !479
    jne    je_else.5614                  # !479
    movl    $1, %eax                     # !483
    movl    16(%ebp), %ebx               # !483
    movsd    8(%ebx), %xmm0              # !483
    movsd    8(%ebp), %xmm1              # !483
    movl    %eax, 56(%ebp)               # !483
    comisd    %xmm0, %xmm1               # !483
    jne    je_else.5615                  # !483
    movl    4(%ebp), %ecx                # !483
    jmp    je_cont.5616                  # !483
je_else.5615:                            # !483
    movl    0(%ebp), %ecx                # !485
    movl    %ecx, %eax                   # !485
    addl    $64, %ebp                    # !485
    call    o_isinvert.1990              # !485
    subl    $64, %ebp                    # !485
    movl    16(%ebp), %ebx               # !485
    movsd    8(%ebx), %xmm0              # !485
    movsd    8(%ebp), %xmm1              # !485
    comisd    %xmm0, %xmm1               # !485
    ja    jbe_else.5617                  # !485
    movl    4(%ebp), %ecx                # !485
    jmp    jbe_cont.5618                 # !485
jbe_else.5617:                           # !485
    movl    56(%ebp), %ecx               # !485
jbe_cont.5618:                           # !485
    movl    %ecx, %ebx                   # !485
    addl    $64, %ebp                    # !485
    call    xor.1977                     # !485
    subl    $64, %ebp                    # !485
    cmpl    $0, %eax                     # !485
    jne    je_else.5619                  # !485
    movl    0(%ebp), %eax                # !485
    addl    $64, %ebp                    # !485
    call    o_param_b.1996               # !485
    subl    $64, %ebp                    # !485
    xorpd    min_caml_fnegd, %xmm0       # !485
    jmp    je_cont.5620                  # !485
je_else.5619:                            # !485
    movl    0(%ebp), %eax                # !485
    addl    $64, %ebp                    # !485
    call    o_param_b.1996               # !485
    subl    $64, %ebp                    # !485
je_cont.5620:                            # !485
    movl    $min_caml_solver_w_vec, %eax # !487
    movsd    8(%eax), %xmm1              # !487
    subsd    %xmm1, %xmm0                # !487
    movl    16(%ebp), %ebx               # !487
    movsd    8(%ebx), %xmm1              # !487
    divsd    %xmm1, %xmm0                # !487
    movl    0(%ebp), %ecx                # !489
    movl    %eax, 60(%ebp)               # !489
    movsd    %xmm0, 64(%ebp)             # !489
    movl    %ecx, %eax                   # !489
    addl    $72, %ebp                    # !489
    call    o_param_c.1998               # !489
    subl    $72, %ebp                    # !489
    movl    16(%ebp), %eax               # !489
    movsd    16(%eax), %xmm1             # !489
    movsd    64(%ebp), %xmm2             # !489
    mulsd    %xmm2, %xmm1                # !489
    movl    60(%ebp), %ebx               # !489
    movsd    16(%ebx), %xmm3             # !489
    addsd    %xmm3, %xmm1                # !489
    movsd    %xmm0, 72(%ebp)             # !489
    movsd    %xmm1, %xmm0                # !489
    addl    $80, %ebp                    # !489
    call    min_caml_abs_float           # !489
    subl    $80, %ebp                    # !489
    movsd    72(%ebp), %xmm1             # !489
    comisd    %xmm0, %xmm1               # !489
    ja    jbe_else.5621                  # !489
    movl    4(%ebp), %eax                # !493
    movl    %eax, %ecx                   # !493
    jmp    jbe_cont.5622                 # !489
jbe_else.5621:                           # !489
    movl    0(%ebp), %eax                # !490
    addl    $80, %ebp                    # !490
    call    o_param_a.1994               # !490
    subl    $80, %ebp                    # !490
    movl    16(%ebp), %eax               # !490
    movsd    0(%eax), %xmm1              # !490
    movsd    64(%ebp), %xmm2             # !490
    mulsd    %xmm2, %xmm1                # !490
    movl    60(%ebp), %ebx               # !490
    movsd    0(%ebx), %xmm3              # !490
    addsd    %xmm3, %xmm1                # !490
    movsd    %xmm0, 80(%ebp)             # !490
    movsd    %xmm1, %xmm0                # !490
    addl    $88, %ebp                    # !490
    call    min_caml_abs_float           # !490
    subl    $88, %ebp                    # !490
    movsd    80(%ebp), %xmm1             # !490
    comisd    %xmm0, %xmm1               # !490
    ja    jbe_else.5623                  # !490
    movl    4(%ebp), %eax                # !492
    movl    %eax, %ecx                   # !492
    jmp    jbe_cont.5624                 # !490
jbe_else.5623:                           # !490
    movl    $min_caml_solver_dist, %eax  # !491
    movsd    64(%ebp), %xmm0             # !491
    movsd    %xmm0, 0(%eax)              # !491
    movl    56(%ebp), %eax               # !491
    movl    %eax, %ecx                   # !491
jbe_cont.5624:                           # !490
jbe_cont.5622:                           # !489
je_cont.5616:                            # !483
    cmpl    $0, %ecx                     # !496
    jne    je_else.5625                  # !496
    movl    16(%ebp), %eax               # !500
    movsd    16(%eax), %xmm0             # !500
    movsd    8(%ebp), %xmm1              # !500
    comisd    %xmm0, %xmm1               # !500
    jne    je_else.5626                  # !500
    movl    4(%ebp), %eax                # !500
    jmp    je_cont.5627                  # !500
je_else.5626:                            # !500
    movl    0(%ebp), %ebx                # !502
    movl    %ebx, %eax                   # !502
    addl    $88, %ebp                    # !502
    call    o_isinvert.1990              # !502
    subl    $88, %ebp                    # !502
    movl    16(%ebp), %ebx               # !502
    movsd    16(%ebx), %xmm0             # !502
    movsd    8(%ebp), %xmm1              # !502
    comisd    %xmm0, %xmm1               # !502
    ja    jbe_else.5628                  # !502
    movl    4(%ebp), %ecx                # !502
    jmp    jbe_cont.5629                 # !502
jbe_else.5628:                           # !502
    movl    56(%ebp), %ecx               # !502
jbe_cont.5629:                           # !502
    movl    %ecx, %ebx                   # !502
    addl    $88, %ebp                    # !502
    call    xor.1977                     # !502
    subl    $88, %ebp                    # !502
    cmpl    $0, %eax                     # !502
    jne    je_else.5630                  # !502
    movl    0(%ebp), %eax                # !502
    addl    $88, %ebp                    # !502
    call    o_param_c.1998               # !502
    subl    $88, %ebp                    # !502
    xorpd    min_caml_fnegd, %xmm0       # !502
    jmp    je_cont.5631                  # !502
je_else.5630:                            # !502
    movl    0(%ebp), %eax                # !502
    addl    $88, %ebp                    # !502
    call    o_param_c.1998               # !502
    subl    $88, %ebp                    # !502
je_cont.5631:                            # !502
    movl    $min_caml_solver_w_vec, %eax # !504
    movsd    16(%eax), %xmm1             # !504
    subsd    %xmm1, %xmm0                # !504
    movl    16(%ebp), %ebx               # !504
    movsd    16(%ebx), %xmm1             # !504
    divsd    %xmm1, %xmm0                # !504
    movl    0(%ebp), %ecx                # !506
    movl    %eax, 88(%ebp)               # !506
    movsd    %xmm0, 96(%ebp)             # !506
    movl    %ecx, %eax                   # !506
    addl    $104, %ebp                   # !506
    call    o_param_a.1994               # !506
    subl    $104, %ebp                   # !506
    movl    16(%ebp), %eax               # !506
    movsd    0(%eax), %xmm1              # !506
    movsd    96(%ebp), %xmm2             # !506
    mulsd    %xmm2, %xmm1                # !506
    movl    88(%ebp), %ebx               # !506
    movsd    0(%ebx), %xmm3              # !506
    addsd    %xmm3, %xmm1                # !506
    movsd    %xmm0, 104(%ebp)            # !506
    movsd    %xmm1, %xmm0                # !506
    addl    $112, %ebp                   # !506
    call    min_caml_abs_float           # !506
    subl    $112, %ebp                   # !506
    movsd    104(%ebp), %xmm1            # !506
    comisd    %xmm0, %xmm1               # !506
    ja    jbe_else.5633                  # !506
    movl    4(%ebp), %eax                # !510
    jmp    jbe_cont.5634                 # !506
jbe_else.5633:                           # !506
    movl    0(%ebp), %eax                # !507
    addl    $112, %ebp                   # !507
    call    o_param_b.1996               # !507
    subl    $112, %ebp                   # !507
    movl    16(%ebp), %eax               # !507
    movsd    8(%eax), %xmm1              # !507
    movsd    96(%ebp), %xmm2             # !507
    mulsd    %xmm2, %xmm1                # !507
    movl    88(%ebp), %eax               # !507
    movsd    8(%eax), %xmm3              # !507
    addsd    %xmm3, %xmm1                # !507
    movsd    %xmm0, 112(%ebp)            # !507
    movsd    %xmm1, %xmm0                # !507
    addl    $120, %ebp                   # !507
    call    min_caml_abs_float           # !507
    subl    $120, %ebp                   # !507
    movsd    112(%ebp), %xmm1            # !507
    comisd    %xmm0, %xmm1               # !507
    ja    jbe_else.5635                  # !507
    movl    4(%ebp), %eax                # !509
    jmp    jbe_cont.5636                 # !507
jbe_else.5635:                           # !507
    movl    $min_caml_solver_dist, %eax  # !508
    movsd    96(%ebp), %xmm0             # !508
    movsd    %xmm0, 0(%eax)              # !508
    movl    56(%ebp), %eax               # !508
jbe_cont.5636:                           # !507
jbe_cont.5634:                           # !506
je_cont.5627:                            # !500
    cmpl    $0, %eax                     # !513
    jne    je_else.5637                  # !513
    movl    4(%ebp), %eax                # !513
    ret                                  # !513
je_else.5637:                            # !513
    movl    $3, %eax                     # !513
    ret                                  # !513
je_else.5625:                            # !496
    movl    $2, %eax                     # !496
    ret                                  # !496
je_else.5614:                            # !479
    movl    $1, %eax                     # !479
    ret                                  # !479
solver_surface.2048:                     # !517
    movl    $0, %ecx                     # !521
    movsd    0(%ebx), %xmm0              # !521
    movl    %ecx, 0(%ebp)                # !521
    movl    %eax, 4(%ebp)                # !521
    movl    %ebx, 8(%ebp)                # !521
    movsd    %xmm0, 16(%ebp)             # !521
    addl    $24, %ebp                    # !521
    call    o_param_a.1994               # !521
    subl    $24, %ebp                    # !521
    movsd    16(%ebp), %xmm1             # !521
    mulsd    %xmm0, %xmm1                # !521
    movl    $1, %eax                     # !521
    movl    8(%ebp), %ebx                # !521
    movsd    8(%ebx), %xmm0              # !521
    movl    4(%ebp), %ecx                # !521
    movl    %eax, 24(%ebp)               # !521
    movsd    %xmm1, 32(%ebp)             # !521
    movsd    %xmm0, 40(%ebp)             # !521
    movl    %ecx, %eax                   # !521
    addl    $48, %ebp                    # !521
    call    o_param_b.1996               # !521
    subl    $48, %ebp                    # !521
    movsd    40(%ebp), %xmm1             # !521
    mulsd    %xmm0, %xmm1                # !521
    movsd    32(%ebp), %xmm0             # !521
    addsd    %xmm1, %xmm0                # !521
    movl    8(%ebp), %eax                # !521
    movsd    16(%eax), %xmm1             # !521
    movl    4(%ebp), %eax                # !521
    movsd    %xmm0, 48(%ebp)             # !521
    movsd    %xmm1, 56(%ebp)             # !521
    addl    $64, %ebp                    # !521
    call    o_param_c.1998               # !521
    subl    $64, %ebp                    # !521
    movsd    56(%ebp), %xmm1             # !521
    mulsd    %xmm0, %xmm1                # !521
    movsd    48(%ebp), %xmm0             # !521
    addsd    %xmm1, %xmm0                # !521
    movl    $l.4442, %eax                # !522
    movsd    0(%eax), %xmm1              # !522
    comisd    %xmm1, %xmm0               # !522
    ja    jbe_else.5640                  # !522
    movl    0(%ebp), %eax                # !525
    ret                                  # !525
jbe_else.5640:                           # !522
    movl    $min_caml_solver_w_vec, %eax # !523
    movsd    0(%eax), %xmm1              # !523
    movl    4(%ebp), %ebx                # !523
    movsd    %xmm0, 64(%ebp)             # !523
    movl    %eax, 72(%ebp)               # !523
    movsd    %xmm1, 80(%ebp)             # !523
    movl    %ebx, %eax                   # !523
    addl    $88, %ebp                    # !523
    call    o_param_a.1994               # !523
    subl    $88, %ebp                    # !523
    movsd    80(%ebp), %xmm1             # !523
    mulsd    %xmm0, %xmm1                # !523
    movl    72(%ebp), %eax               # !523
    movsd    8(%eax), %xmm0              # !523
    movl    4(%ebp), %ebx                # !523
    movsd    %xmm1, 88(%ebp)             # !523
    movsd    %xmm0, 96(%ebp)             # !523
    movl    %ebx, %eax                   # !523
    addl    $104, %ebp                   # !523
    call    o_param_b.1996               # !523
    subl    $104, %ebp                   # !523
    movsd    96(%ebp), %xmm1             # !523
    mulsd    %xmm0, %xmm1                # !523
    movsd    88(%ebp), %xmm0             # !523
    addsd    %xmm1, %xmm0                # !523
    movl    72(%ebp), %eax               # !523
    movsd    16(%eax), %xmm1             # !523
    movl    4(%ebp), %eax                # !523
    movsd    %xmm0, 104(%ebp)            # !523
    movsd    %xmm1, 112(%ebp)            # !523
    addl    $120, %ebp                   # !523
    call    o_param_c.1998               # !523
    subl    $120, %ebp                   # !523
    movsd    112(%ebp), %xmm1            # !523
    mulsd    %xmm0, %xmm1                # !523
    movsd    104(%ebp), %xmm0            # !523
    addsd    %xmm1, %xmm0                # !523
    movsd    64(%ebp), %xmm1             # !523
    divsd    %xmm1, %xmm0                # !523
    movl    $min_caml_solver_dist, %eax  # !524
    xorpd    min_caml_fnegd, %xmm0       # !524
    movsd    %xmm0, 0(%eax)              # !524
    movl    24(%ebp), %eax               # !524
    ret                                  # !524
in_prod_sqr_obj.2051:                    # !530
    movsd    0(%ebx), %xmm0              # !532
    movl    %ebx, 0(%ebp)                # !532
    movl    %eax, 4(%ebp)                # !532
    addl    $8, %ebp                     # !532
    call    fsqr.1980                    # !532
    subl    $8, %ebp                     # !532
    movl    4(%ebp), %eax                # !532
    movsd    %xmm0, 8(%ebp)              # !532
    addl    $16, %ebp                    # !532
    call    o_param_a.1994               # !532
    subl    $16, %ebp                    # !532
    movsd    8(%ebp), %xmm1              # !532
    mulsd    %xmm0, %xmm1                # !532
    movl    0(%ebp), %eax                # !533
    movsd    8(%eax), %xmm0              # !533
    movsd    %xmm1, 16(%ebp)             # !533
    addl    $24, %ebp                    # !533
    call    fsqr.1980                    # !533
    subl    $24, %ebp                    # !533
    movl    4(%ebp), %eax                # !533
    movsd    %xmm0, 24(%ebp)             # !533
    addl    $32, %ebp                    # !533
    call    o_param_b.1996               # !533
    subl    $32, %ebp                    # !533
    movsd    24(%ebp), %xmm1             # !533
    mulsd    %xmm0, %xmm1                # !533
    movsd    16(%ebp), %xmm0             # !532
    addsd    %xmm1, %xmm0                # !532
    movl    0(%ebp), %eax                # !534
    movsd    16(%eax), %xmm1             # !534
    movsd    %xmm0, 32(%ebp)             # !534
    movsd    %xmm1, %xmm0                # !534
    addl    $40, %ebp                    # !534
    call    fsqr.1980                    # !534
    subl    $40, %ebp                    # !534
    movl    4(%ebp), %eax                # !534
    movsd    %xmm0, 40(%ebp)             # !534
    addl    $48, %ebp                    # !534
    call    o_param_c.1998               # !534
    subl    $48, %ebp                    # !534
    movsd    40(%ebp), %xmm1             # !534
    mulsd    %xmm0, %xmm1                # !534
    movsd    32(%ebp), %xmm0             # !532
    addsd    %xmm1, %xmm0                # !532
    ret                                  # !532
in_prod_co_objrot.2054:                  # !537
    movsd    8(%ebx), %xmm0              # !539
    movsd    16(%ebx), %xmm1             # !539
    mulsd    %xmm1, %xmm0                # !539
    movl    %eax, 0(%ebp)                # !539
    movl    %ebx, 4(%ebp)                # !539
    movsd    %xmm0, 8(%ebp)              # !539
    addl    $16, %ebp                    # !539
    call    o_param_r1.2016              # !539
    subl    $16, %ebp                    # !539
    movsd    8(%ebp), %xmm1              # !539
    mulsd    %xmm0, %xmm1                # !539
    movl    4(%ebp), %eax                # !540
    movsd    0(%eax), %xmm0              # !540
    movsd    16(%eax), %xmm2             # !540
    mulsd    %xmm2, %xmm0                # !540
    movl    0(%ebp), %ebx                # !540
    movsd    %xmm1, 16(%ebp)             # !540
    movsd    %xmm0, 24(%ebp)             # !540
    movl    %ebx, %eax                   # !540
    addl    $32, %ebp                    # !540
    call    o_param_r2.2018              # !540
    subl    $32, %ebp                    # !540
    movsd    24(%ebp), %xmm1             # !540
    mulsd    %xmm0, %xmm1                # !540
    movsd    16(%ebp), %xmm0             # !539
    addsd    %xmm1, %xmm0                # !539
    movl    4(%ebp), %eax                # !541
    movsd    0(%eax), %xmm1              # !541
    movsd    8(%eax), %xmm2              # !541
    mulsd    %xmm2, %xmm1                # !541
    movl    0(%ebp), %eax                # !541
    movsd    %xmm0, 32(%ebp)             # !541
    movsd    %xmm1, 40(%ebp)             # !541
    addl    $48, %ebp                    # !541
    call    o_param_r3.2020              # !541
    subl    $48, %ebp                    # !541
    movsd    40(%ebp), %xmm1             # !541
    mulsd    %xmm0, %xmm1                # !541
    movsd    32(%ebp), %xmm0             # !539
    addsd    %xmm1, %xmm0                # !539
    ret                                  # !539
solver2nd_mul_b.2057:                    # !544
    movl    $min_caml_solver_w_vec, %ecx # !546
    movsd    0(%ecx), %xmm0              # !546
    movsd    0(%ebx), %xmm1              # !546
    mulsd    %xmm1, %xmm0                # !546
    movl    %eax, 0(%ebp)                # !546
    movl    %ebx, 4(%ebp)                # !546
    movl    %ecx, 8(%ebp)                # !546
    movsd    %xmm0, 16(%ebp)             # !546
    addl    $24, %ebp                    # !546
    call    o_param_a.1994               # !546
    subl    $24, %ebp                    # !546
    movsd    16(%ebp), %xmm1             # !546
    mulsd    %xmm0, %xmm1                # !546
    movl    8(%ebp), %eax                # !547
    movsd    8(%eax), %xmm0              # !547
    movl    4(%ebp), %ebx                # !547
    movsd    8(%ebx), %xmm2              # !547
    mulsd    %xmm2, %xmm0                # !547
    movl    0(%ebp), %ecx                # !547
    movsd    %xmm1, 24(%ebp)             # !547
    movsd    %xmm0, 32(%ebp)             # !547
    movl    %ecx, %eax                   # !547
    addl    $40, %ebp                    # !547
    call    o_param_b.1996               # !547
    subl    $40, %ebp                    # !547
    movsd    32(%ebp), %xmm1             # !547
    mulsd    %xmm0, %xmm1                # !547
    movsd    24(%ebp), %xmm0             # !546
    addsd    %xmm1, %xmm0                # !546
    movl    8(%ebp), %eax                # !548
    movsd    16(%eax), %xmm1             # !548
    movl    4(%ebp), %eax                # !548
    movsd    16(%eax), %xmm2             # !548
    mulsd    %xmm2, %xmm1                # !548
    movl    0(%ebp), %eax                # !548
    movsd    %xmm0, 40(%ebp)             # !548
    movsd    %xmm1, 48(%ebp)             # !548
    addl    $56, %ebp                    # !548
    call    o_param_c.1998               # !548
    subl    $56, %ebp                    # !548
    movsd    48(%ebp), %xmm1             # !548
    mulsd    %xmm0, %xmm1                # !548
    movsd    40(%ebp), %xmm0             # !546
    addsd    %xmm1, %xmm0                # !546
    ret                                  # !546
solver2nd_rot_b.2060:                    # !551
    movl    $min_caml_solver_w_vec, %ecx # !553
    movsd    16(%ecx), %xmm0             # !553
    movsd    8(%ebx), %xmm1              # !553
    mulsd    %xmm1, %xmm0                # !553
    movsd    8(%ecx), %xmm1              # !553
    movsd    16(%ebx), %xmm2             # !553
    mulsd    %xmm2, %xmm1                # !553
    addsd    %xmm1, %xmm0                # !553
    movl    %eax, 0(%ebp)                # !553
    movl    %ebx, 4(%ebp)                # !553
    movl    %ecx, 8(%ebp)                # !553
    movsd    %xmm0, 16(%ebp)             # !553
    addl    $24, %ebp                    # !553
    call    o_param_r1.2016              # !553
    subl    $24, %ebp                    # !553
    movsd    16(%ebp), %xmm1             # !553
    mulsd    %xmm0, %xmm1                # !553
    movl    8(%ebp), %eax                # !554
    movsd    0(%eax), %xmm0              # !554
    movl    4(%ebp), %ebx                # !554
    movsd    16(%ebx), %xmm2             # !554
    mulsd    %xmm2, %xmm0                # !554
    movsd    16(%eax), %xmm2             # !554
    movsd    0(%ebx), %xmm3              # !554
    mulsd    %xmm3, %xmm2                # !554
    addsd    %xmm2, %xmm0                # !554
    movl    0(%ebp), %ecx                # !554
    movsd    %xmm1, 24(%ebp)             # !554
    movsd    %xmm0, 32(%ebp)             # !554
    movl    %ecx, %eax                   # !554
    addl    $40, %ebp                    # !554
    call    o_param_r2.2018              # !554
    subl    $40, %ebp                    # !554
    movsd    32(%ebp), %xmm1             # !554
    mulsd    %xmm0, %xmm1                # !554
    movsd    24(%ebp), %xmm0             # !553
    addsd    %xmm1, %xmm0                # !553
    movl    8(%ebp), %eax                # !555
    movsd    0(%eax), %xmm1              # !555
    movl    4(%ebp), %ebx                # !555
    movsd    8(%ebx), %xmm2              # !555
    mulsd    %xmm2, %xmm1                # !555
    movsd    8(%eax), %xmm2              # !555
    movsd    0(%ebx), %xmm3              # !555
    mulsd    %xmm3, %xmm2                # !555
    addsd    %xmm2, %xmm1                # !555
    movl    0(%ebp), %eax                # !555
    movsd    %xmm0, 40(%ebp)             # !555
    movsd    %xmm1, 48(%ebp)             # !555
    addl    $56, %ebp                    # !555
    call    o_param_r3.2020              # !555
    subl    $56, %ebp                    # !555
    movsd    48(%ebp), %xmm1             # !555
    mulsd    %xmm0, %xmm1                # !555
    movsd    40(%ebp), %xmm0             # !553
    addsd    %xmm1, %xmm0                # !553
    ret                                  # !553
solver_second.2063:                      # !558
    movl    %ebx, 0(%ebp)                # !560
    movl    %eax, 4(%ebp)                # !560
    addl    $8, %ebp                     # !560
    call    in_prod_sqr_obj.2051         # !560
    subl    $8, %ebp                     # !560
    movl    4(%ebp), %eax                # !562
    movsd    %xmm0, 8(%ebp)              # !562
    addl    $16, %ebp                    # !562
    call    o_isrot.1992                 # !562
    subl    $16, %ebp                    # !562
    movl    $0, %ebx                     # !562
    movl    %ebx, 16(%ebp)               # !562
    cmpl    $0, %eax                     # !562
    jne    je_else.5644                  # !562
    movsd    8(%ebp), %xmm0              # !563
    jmp    je_cont.5645                  # !562
je_else.5644:                            # !562
    movl    4(%ebp), %eax                # !562
    movl    0(%ebp), %ecx                # !562
    movl    %ecx, %ebx                   # !562
    addl    $24, %ebp                    # !562
    call    in_prod_co_objrot.2054       # !562
    subl    $24, %ebp                    # !562
    movsd    8(%ebp), %xmm1              # !562
    addsd    %xmm1, %xmm0                # !562
je_cont.5645:                            # !562
    movl    $l.4442, %eax                # !565
    movsd    0(%eax), %xmm1              # !565
    comisd    %xmm0, %xmm1               # !565
    jne    je_else.5646                  # !565
    movl    16(%ebp), %eax               # !566
    ret                                  # !566
je_else.5646:                            # !565
    movl    $l.4440, %eax                # !569
    movsd    0(%eax), %xmm2              # !569
    movl    4(%ebp), %eax                # !569
    movl    0(%ebp), %ebx                # !569
    movsd    %xmm1, 24(%ebp)             # !569
    movsd    %xmm0, 32(%ebp)             # !569
    movsd    %xmm2, 40(%ebp)             # !569
    addl    $48, %ebp                    # !569
    call    solver2nd_mul_b.2057         # !569
    subl    $48, %ebp                    # !569
    movsd    40(%ebp), %xmm1             # !569
    mulsd    %xmm1, %xmm0                # !569
    movl    4(%ebp), %eax                # !572
    movsd    %xmm0, 48(%ebp)             # !572
    addl    $56, %ebp                    # !572
    call    o_isrot.1992                 # !572
    subl    $56, %ebp                    # !572
    cmpl    $0, %eax                     # !572
    jne    je_else.5648                  # !572
    movsd    48(%ebp), %xmm0             # !573
    jmp    je_cont.5649                  # !572
je_else.5648:                            # !572
    movl    4(%ebp), %eax                # !572
    movl    0(%ebp), %ebx                # !572
    addl    $56, %ebp                    # !572
    call    solver2nd_rot_b.2060         # !572
    subl    $56, %ebp                    # !572
    movsd    48(%ebp), %xmm1             # !572
    addsd    %xmm1, %xmm0                # !572
je_cont.5649:                            # !572
    movl    $min_caml_solver_w_vec, %ebx # !575
    movl    4(%ebp), %eax                # !575
    movsd    %xmm0, 56(%ebp)             # !575
    movl    %ebx, 64(%ebp)               # !575
    addl    $72, %ebp                    # !575
    call    in_prod_sqr_obj.2051         # !575
    subl    $72, %ebp                    # !575
    movl    4(%ebp), %eax                # !577
    movsd    %xmm0, 72(%ebp)             # !577
    addl    $80, %ebp                    # !577
    call    o_isrot.1992                 # !577
    subl    $80, %ebp                    # !577
    cmpl    $0, %eax                     # !577
    jne    je_else.5651                  # !577
    movsd    72(%ebp), %xmm0             # !579
    jmp    je_cont.5652                  # !577
je_else.5651:                            # !577
    movl    4(%ebp), %eax                # !578
    movl    64(%ebp), %ebx               # !578
    addl    $80, %ebp                    # !578
    call    in_prod_co_objrot.2054       # !578
    subl    $80, %ebp                    # !578
    movsd    72(%ebp), %xmm1             # !578
    addsd    %xmm1, %xmm0                # !578
je_cont.5652:                            # !577
    movl    4(%ebp), %eax                # !581
    movsd    %xmm0, 80(%ebp)             # !581
    addl    $88, %ebp                    # !581
    call    o_form.1986                  # !581
    subl    $88, %ebp                    # !581
    cmpl    $3, %eax                     # !581
    jne    je_else.5653                  # !581
    movl    $l.4444, %eax                # !582
    movsd    0(%eax), %xmm0              # !582
    movsd    80(%ebp), %xmm1             # !582
    subsd    %xmm0, %xmm1                # !582
    jmp    je_cont.5654                  # !581
je_else.5653:                            # !581
    movsd    80(%ebp), %xmm0             # !582
    movsd    %xmm0, %xmm1                # !582
je_cont.5654:                            # !581
    movl    $l.4470, %eax                # !585
    movsd    0(%eax), %xmm0              # !585
    movsd    32(%ebp), %xmm2             # !585
    mulsd    %xmm2, %xmm0                # !585
    mulsd    %xmm1, %xmm0                # !585
    movsd    56(%ebp), %xmm1             # !586
    movsd    %xmm0, 88(%ebp)             # !586
    movsd    %xmm1, %xmm0                # !586
    addl    $96, %ebp                    # !586
    call    fsqr.1980                    # !586
    subl    $96, %ebp                    # !586
    movsd    88(%ebp), %xmm1             # !586
    subsd    %xmm1, %xmm0                # !586
    movsd    24(%ebp), %xmm1             # !588
    comisd    %xmm1, %xmm0               # !588
    ja    jbe_else.5655                  # !588
    movl    16(%ebp), %eax               # !595
    ret                                  # !595
jbe_else.5655:                           # !588
    addl    $96, %ebp                    # !591
    call    min_caml_sqrt                # !591
    subl    $96, %ebp                    # !591
    movl    4(%ebp), %eax                # !592
    movsd    %xmm0, 96(%ebp)             # !592
    addl    $104, %ebp                   # !592
    call    o_isinvert.1990              # !592
    subl    $104, %ebp                   # !592
    cmpl    $0, %eax                     # !592
    jne    je_else.5656                  # !592
    movsd    96(%ebp), %xmm0             # !592
    xorpd    min_caml_fnegd, %xmm0       # !592
    jmp    je_cont.5657                  # !592
je_else.5656:                            # !592
    movsd    96(%ebp), %xmm0             # !592
je_cont.5657:                            # !592
    movl    $min_caml_solver_dist, %eax  # !593
    movsd    56(%ebp), %xmm1             # !593
    subsd    %xmm1, %xmm0                # !593
    movsd    40(%ebp), %xmm1             # !593
    divsd    %xmm1, %xmm0                # !593
    movsd    32(%ebp), %xmm1             # !593
    divsd    %xmm1, %xmm0                # !593
    movsd    %xmm0, 0(%eax)              # !593
    movl    $1, %eax                     # !593
    ret                                  # !593
solver.2066:                             # !600
    movl    $min_caml_objects, %edx      # !602
    movl    (%edx,%eax,4), %eax          # !602
    movl    $min_caml_solver_w_vec, %edx # !603
    movsd    0(%ecx), %xmm0              # !603
    movl    %ebx, 0(%ebp)                # !603
    movl    %eax, 4(%ebp)                # !603
    movl    %ecx, 8(%ebp)                # !603
    movl    %edx, 12(%ebp)               # !603
    movsd    %xmm0, 16(%ebp)             # !603
    addl    $24, %ebp                    # !603
    call    o_param_x.2000               # !603
    subl    $24, %ebp                    # !603
    movsd    16(%ebp), %xmm1             # !603
    subsd    %xmm0, %xmm1                # !603
    movl    12(%ebp), %eax               # !603
    movsd    %xmm1, 0(%eax)              # !603
    movl    8(%ebp), %ebx                # !604
    movsd    8(%ebx), %xmm0              # !604
    movl    4(%ebp), %ecx                # !604
    movsd    %xmm0, 24(%ebp)             # !604
    movl    %ecx, %eax                   # !604
    addl    $32, %ebp                    # !604
    call    o_param_y.2002               # !604
    subl    $32, %ebp                    # !604
    movsd    24(%ebp), %xmm1             # !604
    subsd    %xmm0, %xmm1                # !604
    movl    12(%ebp), %eax               # !604
    movsd    %xmm1, 8(%eax)              # !604
    movl    8(%ebp), %ebx                # !605
    movsd    16(%ebx), %xmm0             # !605
    movl    4(%ebp), %ebx                # !605
    movsd    %xmm0, 32(%ebp)             # !605
    movl    %ebx, %eax                   # !605
    addl    $40, %ebp                    # !605
    call    o_param_z.2004               # !605
    subl    $40, %ebp                    # !605
    movsd    32(%ebp), %xmm1             # !605
    subsd    %xmm0, %xmm1                # !605
    movl    12(%ebp), %eax               # !605
    movsd    %xmm1, 16(%eax)             # !605
    movl    4(%ebp), %eax                # !606
    addl    $40, %ebp                    # !606
    call    o_form.1986                  # !606
    subl    $40, %ebp                    # !606
    cmpl    $1, %eax                     # !607
    jne    je_else.5658                  # !607
    movl    4(%ebp), %eax                # !607
    movl    0(%ebp), %ebx                # !607
    jmp    solver_rect.2045              # !607
je_else.5658:                            # !607
    cmpl    $2, %eax                     # !608
    jne    je_else.5659                  # !608
    movl    4(%ebp), %eax                # !608
    movl    0(%ebp), %ebx                # !608
    jmp    solver_surface.2048           # !608
je_else.5659:                            # !608
    movl    4(%ebp), %eax                # !609
    movl    0(%ebp), %ebx                # !609
    jmp    solver_second.2063            # !609
is_rect_outside.2070:                    # !616
    movl    %eax, 0(%ebp)                # !619
    addl    $8, %ebp                     # !619
    call    o_param_a.1994               # !619
    subl    $8, %ebp                     # !619
    movl    $min_caml_isoutside_q, %eax  # !619
    movl    $0, %ebx                     # !619
    movsd    0(%eax), %xmm1              # !619
    movl    %eax, 4(%ebp)                # !619
    movl    %ebx, 8(%ebp)                # !619
    movsd    %xmm0, 16(%ebp)             # !619
    movsd    %xmm1, %xmm0                # !619
    addl    $24, %ebp                    # !619
    call    min_caml_abs_float           # !619
    subl    $24, %ebp                    # !619
    movsd    16(%ebp), %xmm1             # !619
    comisd    %xmm0, %xmm1               # !619
    ja    jbe_else.5661                  # !619
    movl    8(%ebp), %eax                # !623
    jmp    jbe_cont.5662                 # !619
jbe_else.5661:                           # !619
    movl    0(%ebp), %eax                # !620
    addl    $24, %ebp                    # !620
    call    o_param_b.1996               # !620
    subl    $24, %ebp                    # !620
    movl    $1, %eax                     # !620
    movl    4(%ebp), %ebx                # !620
    movsd    8(%ebx), %xmm1              # !620
    movl    %eax, 24(%ebp)               # !620
    movsd    %xmm0, 32(%ebp)             # !620
    movsd    %xmm1, %xmm0                # !620
    addl    $40, %ebp                    # !620
    call    min_caml_abs_float           # !620
    subl    $40, %ebp                    # !620
    movsd    32(%ebp), %xmm1             # !620
    comisd    %xmm0, %xmm1               # !620
    ja    jbe_else.5664                  # !620
    movl    8(%ebp), %eax                # !622
    jmp    jbe_cont.5665                 # !620
jbe_else.5664:                           # !620
    movl    0(%ebp), %eax                # !621
    addl    $40, %ebp                    # !621
    call    o_param_c.1998               # !621
    subl    $40, %ebp                    # !621
    movl    4(%ebp), %eax                # !621
    movsd    16(%eax), %xmm1             # !621
    movsd    %xmm0, 40(%ebp)             # !621
    movsd    %xmm1, %xmm0                # !621
    addl    $48, %ebp                    # !621
    call    min_caml_abs_float           # !621
    subl    $48, %ebp                    # !621
    movsd    40(%ebp), %xmm1             # !621
    comisd    %xmm0, %xmm1               # !621
    ja    jbe_else.5666                  # !621
    movl    8(%ebp), %eax                # !621
    jmp    jbe_cont.5667                 # !621
jbe_else.5666:                           # !621
    movl    24(%ebp), %eax               # !621
jbe_cont.5667:                           # !621
jbe_cont.5665:                           # !620
jbe_cont.5662:                           # !619
    cmpl    $0, %eax                     # !618
    jne    je_else.5668                  # !618
    movl    0(%ebp), %eax                # !625
    addl    $48, %ebp                    # !625
    call    o_isinvert.1990              # !625
    subl    $48, %ebp                    # !625
    cmpl    $0, %eax                     # !625
    jne    je_else.5669                  # !625
    movl    $1, %eax                     # !625
    ret                                  # !625
je_else.5669:                            # !625
    movl    8(%ebp), %eax                # !625
    ret                                  # !625
je_else.5668:                            # !618
    movl    0(%ebp), %eax                # !625
    jmp    o_isinvert.1990               # !625
is_plane_outside.2072:                   # !628
    movl    %eax, 0(%ebp)                # !630
    addl    $8, %ebp                     # !630
    call    o_param_a.1994               # !630
    subl    $8, %ebp                     # !630
    movl    $min_caml_isoutside_q, %eax  # !630
    movl    $0, %ebx                     # !630
    movsd    0(%eax), %xmm1              # !630
    mulsd    %xmm1, %xmm0                # !630
    movl    0(%ebp), %ecx                # !631
    movl    %ebx, 4(%ebp)                # !631
    movsd    %xmm0, 8(%ebp)              # !631
    movl    %eax, 16(%ebp)               # !631
    movl    %ecx, %eax                   # !631
    addl    $24, %ebp                    # !631
    call    o_param_b.1996               # !631
    subl    $24, %ebp                    # !631
    movl    $1, %eax                     # !631
    movl    16(%ebp), %ebx               # !631
    movsd    8(%ebx), %xmm1              # !631
    mulsd    %xmm1, %xmm0                # !631
    movsd    8(%ebp), %xmm1              # !630
    addsd    %xmm0, %xmm1                # !630
    movl    0(%ebp), %ecx                # !632
    movl    %eax, 20(%ebp)               # !632
    movsd    %xmm1, 24(%ebp)             # !632
    movl    %ecx, %eax                   # !632
    addl    $32, %ebp                    # !632
    call    o_param_c.1998               # !632
    subl    $32, %ebp                    # !632
    movl    16(%ebp), %eax               # !632
    movsd    16(%eax), %xmm1             # !632
    mulsd    %xmm1, %xmm0                # !632
    movsd    24(%ebp), %xmm1             # !630
    addsd    %xmm0, %xmm1                # !630
    movl    $l.4442, %eax                # !633
    movsd    0(%eax), %xmm0              # !633
    comisd    %xmm1, %xmm0               # !633
    ja    jbe_else.5670                  # !633
    movl    4(%ebp), %eax                # !633
    jmp    jbe_cont.5671                 # !633
jbe_else.5670:                           # !633
    movl    20(%ebp), %eax               # !633
jbe_cont.5671:                           # !633
    movl    0(%ebp), %ebx                # !634
    movl    %eax, 32(%ebp)               # !634
    movl    %ebx, %eax                   # !634
    addl    $40, %ebp                    # !634
    call    o_isinvert.1990              # !634
    subl    $40, %ebp                    # !634
    movl    32(%ebp), %ebx               # !634
    addl    $40, %ebp                    # !634
    call    xor.1977                     # !634
    subl    $40, %ebp                    # !634
    cmpl    $0, %eax                     # !634
    jne    je_else.5672                  # !634
    movl    20(%ebp), %eax               # !634
    ret                                  # !634
je_else.5672:                            # !634
    movl    4(%ebp), %eax                # !634
    ret                                  # !634
is_second_outside.2074:                  # !637
    movl    $min_caml_isoutside_q, %ebx  # !639
    movl    %ebx, 0(%ebp)                # !639
    movl    %eax, 4(%ebp)                # !639
    addl    $8, %ebp                     # !639
    call    in_prod_sqr_obj.2051         # !639
    subl    $8, %ebp                     # !639
    movl    4(%ebp), %eax                # !640
    movsd    %xmm0, 8(%ebp)              # !640
    addl    $16, %ebp                    # !640
    call    o_form.1986                  # !640
    subl    $16, %ebp                    # !640
    cmpl    $3, %eax                     # !640
    jne    je_else.5673                  # !640
    movl    $l.4444, %eax                # !640
    movsd    0(%eax), %xmm0              # !640
    movsd    8(%ebp), %xmm1              # !640
    subsd    %xmm0, %xmm1                # !640
    jmp    je_cont.5674                  # !640
je_else.5673:                            # !640
    movsd    8(%ebp), %xmm0              # !640
    movsd    %xmm0, %xmm1                # !640
je_cont.5674:                            # !640
    movl    4(%ebp), %eax                # !642
    movsd    %xmm1, 16(%ebp)             # !642
    addl    $24, %ebp                    # !642
    call    o_isrot.1992                 # !642
    subl    $24, %ebp                    # !642
    movl    $0, %ebx                     # !642
    movl    %ebx, 24(%ebp)               # !642
    cmpl    $0, %eax                     # !642
    jne    je_else.5675                  # !642
    movsd    16(%ebp), %xmm0             # !645
    jmp    je_cont.5676                  # !642
je_else.5675:                            # !642
    movl    4(%ebp), %eax                # !643
    movl    0(%ebp), %ecx                # !643
    movl    %ecx, %ebx                   # !643
    addl    $32, %ebp                    # !643
    call    in_prod_co_objrot.2054       # !643
    subl    $32, %ebp                    # !643
    movsd    16(%ebp), %xmm1             # !643
    addsd    %xmm1, %xmm0                # !643
je_cont.5676:                            # !642
    movl    $l.4442, %eax                # !647
    movsd    0(%eax), %xmm1              # !647
    comisd    %xmm0, %xmm1               # !647
    ja    jbe_else.5677                  # !647
    movl    24(%ebp), %eax               # !647
    jmp    jbe_cont.5678                 # !647
jbe_else.5677:                           # !647
    movl    $1, %eax                     # !647
jbe_cont.5678:                           # !647
    movl    4(%ebp), %ebx                # !648
    movl    %eax, 28(%ebp)               # !648
    movl    %ebx, %eax                   # !648
    addl    $32, %ebp                    # !648
    call    o_isinvert.1990              # !648
    subl    $32, %ebp                    # !648
    movl    28(%ebp), %ebx               # !648
    addl    $32, %ebp                    # !648
    call    xor.1977                     # !648
    subl    $32, %ebp                    # !648
    cmpl    $0, %eax                     # !648
    jne    je_else.5679                  # !648
    movl    $1, %eax                     # !648
    ret                                  # !648
je_else.5679:                            # !648
    movl    24(%ebp), %eax               # !648
    ret                                  # !648
is_outside.2076:                         # !651
    movl    $min_caml_isoutside_q, %ebx  # !653
    movl    $min_caml_chkinside_p, %ecx  # !653
    movsd    0(%ecx), %xmm0              # !653
    movl    %eax, 0(%ebp)                # !653
    movl    %ecx, 4(%ebp)                # !653
    movl    %ebx, 8(%ebp)                # !653
    movsd    %xmm0, 16(%ebp)             # !653
    addl    $24, %ebp                    # !653
    call    o_param_x.2000               # !653
    subl    $24, %ebp                    # !653
    movsd    16(%ebp), %xmm1             # !653
    subsd    %xmm0, %xmm1                # !653
    movl    8(%ebp), %eax                # !653
    movsd    %xmm1, 0(%eax)              # !653
    movl    4(%ebp), %ebx                # !654
    movsd    8(%ebx), %xmm0              # !654
    movl    0(%ebp), %ecx                # !654
    movsd    %xmm0, 24(%ebp)             # !654
    movl    %ecx, %eax                   # !654
    addl    $32, %ebp                    # !654
    call    o_param_y.2002               # !654
    subl    $32, %ebp                    # !654
    movsd    24(%ebp), %xmm1             # !654
    subsd    %xmm0, %xmm1                # !654
    movl    8(%ebp), %eax                # !654
    movsd    %xmm1, 8(%eax)              # !654
    movl    4(%ebp), %ebx                # !655
    movsd    16(%ebx), %xmm0             # !655
    movl    0(%ebp), %ebx                # !655
    movsd    %xmm0, 32(%ebp)             # !655
    movl    %ebx, %eax                   # !655
    addl    $40, %ebp                    # !655
    call    o_param_z.2004               # !655
    subl    $40, %ebp                    # !655
    movsd    32(%ebp), %xmm1             # !655
    subsd    %xmm0, %xmm1                # !655
    movl    8(%ebp), %eax                # !655
    movsd    %xmm1, 16(%eax)             # !655
    movl    0(%ebp), %eax                # !656
    addl    $40, %ebp                    # !656
    call    o_form.1986                  # !656
    subl    $40, %ebp                    # !656
    cmpl    $1, %eax                     # !657
    jne    je_else.5681                  # !657
    movl    0(%ebp), %eax                # !658
    jmp    is_rect_outside.2070          # !658
je_else.5681:                            # !657
    cmpl    $2, %eax                     # !659
    jne    je_else.5682                  # !659
    movl    0(%ebp), %eax                # !660
    jmp    is_plane_outside.2072         # !660
je_else.5682:                            # !659
    movl    0(%ebp), %eax                # !662
    jmp    is_second_outside.2074        # !662
check_all_inside.2078:                   # !666
    movl    (%ebx,%eax,4), %ecx          # !668
    cmpl    $-1, %ecx                    # !669
    jne    je_else.5683                  # !669
    movl    $1, %eax                     # !669
    ret                                  # !669
je_else.5683:                            # !669
    movl    $min_caml_objects, %edx      # !670
    movl    (%edx,%ecx,4), %ecx          # !670
    movl    %ebx, 0(%ebp)                # !670
    movl    %eax, 4(%ebp)                # !670
    movl    %ecx, %eax                   # !670
    addl    $8, %ebp                     # !670
    call    is_outside.2076              # !670
    subl    $8, %ebp                     # !670
    movl    $0, %ebx                     # !669
    cmpl    $0, %eax                     # !669
    jne    je_else.5684                  # !669
    movl    4(%ebp), %eax                # !671
    addl    $1, %eax                     # !671
    movl    0(%ebp), %ebx                # !671
    jmp    check_all_inside.2078         # !671
je_else.5684:                            # !669
    movl    %ebx, %eax                   # !670
    ret                                  # !670
shadow_check_and_group.2081:             # !681
    movl    (%ebx,%eax,4), %edx          # !683
    cmpl    $-1, %edx                    # !683
    jne    je_else.5685                  # !683
    movl    $0, %eax                     # !684
    ret                                  # !684
je_else.5685:                            # !683
    movl    (%ebx,%eax,4), %edx          # !686
    movl    $min_caml_light, %esi        # !688
    movl    %esi, 0(%ebp)                # !688
    movl    %ecx, 4(%ebp)                # !688
    movl    %ebx, 8(%ebp)                # !688
    movl    %eax, 12(%ebp)               # !688
    movl    %edx, 16(%ebp)               # !688
    movl    %esi, %ebx                   # !688
    movl    %edx, %eax                   # !688
    addl    $24, %ebp                    # !688
    call    solver.2066                  # !688
    subl    $24, %ebp                    # !688
    movl    $min_caml_solver_dist, %ebx  # !689
    movl    $0, %ecx                     # !689
    movsd    0(%ebx), %xmm0              # !689
    cmpl    $0, %eax                     # !690
    jne    je_else.5686                  # !690
    movl    %ecx, %eax                   # !690
    jmp    je_cont.5687                  # !690
je_else.5686:                            # !690
    movl    $l.4475, %eax                # !690
    movsd    0(%eax), %xmm1              # !690
    comisd    %xmm0, %xmm1               # !690
    ja    jbe_else.5688                  # !690
    movl    %ecx, %eax                   # !690
    jmp    jbe_cont.5689                 # !690
jbe_else.5688:                           # !690
    movl    $1, %eax                     # !690
jbe_cont.5689:                           # !690
je_cont.5687:                            # !690
    cmpl    $0, %eax                     # !690
    jne    je_else.5690                  # !690
    movl    $min_caml_objects, %eax      # !706
    movl    16(%ebp), %ebx               # !706
    movl    (%eax,%ebx,4), %eax          # !706
    movl    %ecx, 20(%ebp)               # !706
    addl    $24, %ebp                    # !706
    call    o_isinvert.1990              # !706
    subl    $24, %ebp                    # !706
    cmpl    $0, %eax                     # !706
    jne    je_else.5691                  # !706
    movl    20(%ebp), %eax               # !708
    ret                                  # !708
je_else.5691:                            # !706
    movl    12(%ebp), %eax               # !707
    addl    $1, %eax                     # !707
    movl    8(%ebp), %ebx                # !707
    movl    4(%ebp), %ecx                # !707
    jmp    shadow_check_and_group.2081   # !707
je_else.5690:                            # !690
    movl    $l.4477, %eax                # !694
    movsd    0(%eax), %xmm1              # !694
    addsd    %xmm0, %xmm1                # !694
    movl    $min_caml_chkinside_p, %eax  # !695
    movl    0(%ebp), %ebx                # !695
    movsd    0(%ebx), %xmm0              # !695
    mulsd    %xmm1, %xmm0                # !695
    movl    4(%ebp), %edx                # !695
    movsd    0(%edx), %xmm2              # !695
    addsd    %xmm2, %xmm0                # !695
    movsd    %xmm0, 0(%eax)              # !695
    movl    $1, %esi                     # !696
    movsd    8(%ebx), %xmm0              # !696
    mulsd    %xmm1, %xmm0                # !696
    movsd    8(%edx), %xmm2              # !696
    addsd    %xmm2, %xmm0                # !696
    movsd    %xmm0, 8(%eax)              # !696
    movsd    16(%ebx), %xmm0             # !697
    mulsd    %xmm1, %xmm0                # !697
    movsd    16(%edx), %xmm1             # !697
    addsd    %xmm1, %xmm0                # !697
    movsd    %xmm0, 16(%eax)             # !697
    movl    8(%ebp), %ebx                # !698
    movl    %esi, 24(%ebp)               # !698
    movl    %ecx, %eax                   # !698
    addl    $32, %ebp                    # !698
    call    check_all_inside.2078        # !698
    subl    $32, %ebp                    # !698
    cmpl    $0, %eax                     # !698
    jne    je_else.5692                  # !698
    movl    12(%ebp), %eax               # !700
    addl    $1, %eax                     # !700
    movl    8(%ebp), %ebx                # !700
    movl    4(%ebp), %ecx                # !700
    jmp    shadow_check_and_group.2081   # !700
je_else.5692:                            # !698
    movl    24(%ebp), %eax               # !699
    ret                                  # !699
shadow_check_one_or_group.2085:          # !712
    movl    (%ebx,%eax,4), %edx          # !714
    cmpl    $-1, %edx                    # !715
    jne    je_else.5693                  # !715
    movl    $0, %eax                     # !716
    ret                                  # !716
je_else.5693:                            # !715
    movl    $min_caml_and_net, %esi      # !718
    movl    (%esi,%edx,4), %edx          # !718
    movl    $0, %esi                     # !719
    movl    %ecx, 0(%ebp)                # !719
    movl    %ebx, 4(%ebp)                # !719
    movl    %eax, 8(%ebp)                # !719
    movl    %edx, %ebx                   # !719
    movl    %esi, %eax                   # !719
    addl    $16, %ebp                    # !719
    call    shadow_check_and_group.2081  # !719
    subl    $16, %ebp                    # !719
    cmpl    $0, %eax                     # !720
    jne    je_else.5694                  # !720
    movl    8(%ebp), %eax                # !721
    addl    $1, %eax                     # !721
    movl    4(%ebp), %ebx                # !721
    movl    0(%ebp), %ecx                # !721
    jmp    shadow_check_one_or_group.2085 # !721
je_else.5694:                            # !720
    movl    $1, %eax                     # !720
    ret                                  # !720
shadow_check_one_or_matrix.2089:         # !726
    movl    (%ebx,%eax,4), %edx          # !728
    movl    $0, %esi                     # !729
    movl    0(%edx), %edi                # !729
    cmpl    $-1, %edi                    # !730
    jne    je_else.5695                  # !730
    movl    %esi, %eax                   # !730
    ret                                  # !730
je_else.5695:                            # !730
    cmpl    $99, %edi                    # !731
    jne    je_else.5696                  # !731
    movl    $1, %esi                     # !735
    movl    %esi, 0(%ebp)                # !735
    movl    %ecx, 4(%ebp)                # !735
    movl    %ebx, 8(%ebp)                # !735
    movl    %eax, 12(%ebp)               # !735
    movl    %edx, %ebx                   # !735
    movl    %esi, %eax                   # !735
    addl    $16, %ebp                    # !735
    call    shadow_check_one_or_group.2085 # !735
    subl    $16, %ebp                    # !735
    cmpl    $0, %eax                     # !735
    jne    je_else.5697                  # !735
    movl    12(%ebp), %eax               # !737
    addl    $1, %eax                     # !737
    movl    8(%ebp), %ebx                # !737
    movl    4(%ebp), %ecx                # !737
    jmp    shadow_check_one_or_matrix.2089 # !737
je_else.5697:                            # !735
    movl    0(%ebp), %eax                # !736
    ret                                  # !736
je_else.5696:                            # !731
    movl    $min_caml_light, %esi        # !740
    movl    %edx, 16(%ebp)               # !740
    movl    %ecx, 4(%ebp)                # !740
    movl    %ebx, 8(%ebp)                # !740
    movl    %eax, 12(%ebp)               # !740
    movl    %esi, %ebx                   # !740
    movl    %edi, %eax                   # !740
    addl    $24, %ebp                    # !740
    call    solver.2066                  # !740
    subl    $24, %ebp                    # !740
    cmpl    $0, %eax                     # !743
    jne    je_else.5698                  # !743
    movl    12(%ebp), %eax               # !750
    addl    $1, %eax                     # !750
    movl    8(%ebp), %ebx                # !750
    movl    4(%ebp), %ecx                # !750
    jmp    shadow_check_one_or_matrix.2089 # !750
je_else.5698:                            # !743
    movl    $l.4479, %eax                # !744
    movsd    0(%eax), %xmm0              # !744
    movl    $min_caml_solver_dist, %eax  # !744
    movsd    0(%eax), %xmm1              # !744
    comisd    %xmm1, %xmm0               # !744
    ja    jbe_else.5699                  # !744
    movl    12(%ebp), %eax               # !749
    addl    $1, %eax                     # !749
    movl    8(%ebp), %ebx                # !749
    movl    4(%ebp), %ecx                # !749
    jmp    shadow_check_one_or_matrix.2089 # !749
jbe_else.5699:                           # !744
    movl    $1, %eax                     # !746
    movl    16(%ebp), %ebx               # !746
    movl    4(%ebp), %ecx                # !746
    movl    %eax, 20(%ebp)               # !746
    addl    $24, %ebp                    # !746
    call    shadow_check_one_or_group.2085 # !746
    subl    $24, %ebp                    # !746
    cmpl    $0, %eax                     # !746
    jne    je_else.5700                  # !746
    movl    12(%ebp), %eax               # !748
    addl    $1, %eax                     # !748
    movl    8(%ebp), %ebx                # !748
    movl    4(%ebp), %ecx                # !748
    jmp    shadow_check_one_or_matrix.2089 # !748
je_else.5700:                            # !746
    movl    20(%ebp), %eax               # !747
    ret                                  # !747
solve_each_element.2093:                 # !758
    movl    (%ebx,%eax,4), %ecx          # !760
    cmpl    $-1, %ecx                    # !761
    jne    je_else.5701                  # !761
    ret                                  # !761
je_else.5701:                            # !761
    movl    $min_caml_vscan, %edx        # !763
    movl    $min_caml_viewpoint, %esi    # !763
    movl    %eax, 0(%ebp)                # !763
    movl    %ebx, 4(%ebp)                # !763
    movl    %esi, 8(%ebp)                # !763
    movl    %edx, 12(%ebp)               # !763
    movl    %ecx, 16(%ebp)               # !763
    movl    %edx, %ebx                   # !763
    movl    %ecx, %eax                   # !763
    movl    %esi, %ecx                   # !763
    addl    $24, %ebp                    # !763
    call    solver.2066                  # !763
    subl    $24, %ebp                    # !763
    movl    $0, %ebx                     # !764
    cmpl    $0, %eax                     # !764
    jne    je_else.5703                  # !764
    movl    $min_caml_objects, %eax      # !793
    movl    16(%ebp), %ebx               # !793
    movl    (%eax,%ebx,4), %eax          # !793
    addl    $24, %ebp                    # !793
    call    o_isinvert.1990              # !793
    subl    $24, %ebp                    # !793
    cmpl    $0, %eax                     # !791
    jne    je_else.5705                  # !791
    movl    $min_caml_end_flag, %eax     # !793
    movl    $1, %ebx                     # !793
    movl    %ebx, 0(%eax)                # !793
    jmp    je_cont.5706                  # !791
je_else.5705:                            # !791
je_cont.5706:                            # !791
    jmp    je_cont.5704                  # !764
je_else.5703:                            # !764
    movl    $min_caml_solver_dist, %ecx  # !768
    movsd    0(%ecx), %xmm0              # !768
    movl    $l.4479, %ecx                # !769
    movsd    0(%ecx), %xmm1              # !769
    comisd    %xmm1, %xmm0               # !769
    ja    jbe_else.5707                  # !769
    jmp    jbe_cont.5708                 # !769
jbe_else.5707:                           # !769
    movl    $min_caml_tmin, %ecx         # !770
    movsd    0(%ecx), %xmm1              # !770
    comisd    %xmm0, %xmm1               # !770
    ja    jbe_else.5709                  # !770
    jmp    jbe_cont.5710                 # !770
jbe_else.5709:                           # !770
    movl    $l.4477, %edx                # !772
    movsd    0(%edx), %xmm1              # !772
    addsd    %xmm0, %xmm1                # !772
    movl    $min_caml_chkinside_p, %edx  # !773
    movl    12(%ebp), %esi               # !773
    movsd    0(%esi), %xmm0              # !773
    mulsd    %xmm1, %xmm0                # !773
    movl    8(%ebp), %edi                # !773
    movsd    0(%edi), %xmm2              # !773
    addsd    %xmm2, %xmm0                # !773
    movsd    %xmm0, 0(%edx)              # !773
    movsd    8(%esi), %xmm0              # !774
    mulsd    %xmm1, %xmm0                # !774
    movsd    8(%edi), %xmm2              # !774
    addsd    %xmm2, %xmm0                # !774
    movsd    %xmm0, 8(%edx)              # !774
    movsd    16(%esi), %xmm0             # !775
    mulsd    %xmm1, %xmm0                # !775
    movsd    16(%edi), %xmm2             # !775
    addsd    %xmm2, %xmm0                # !775
    movsd    %xmm0, 16(%edx)             # !775
    movl    4(%ebp), %esi                # !776
    movl    %eax, 20(%ebp)               # !776
    movl    %edx, 24(%ebp)               # !776
    movl    %ecx, 28(%ebp)               # !776
    movsd    %xmm1, 32(%ebp)             # !776
    movl    %ebx, %eax                   # !776
    movl    %esi, %ebx                   # !776
    addl    $40, %ebp                    # !776
    call    check_all_inside.2078        # !776
    subl    $40, %ebp                    # !776
    cmpl    $0, %eax                     # !776
    jne    je_else.5711                  # !776
    jmp    je_cont.5712                  # !776
je_else.5711:                            # !776
    movl    28(%ebp), %eax               # !778
    movsd    32(%ebp), %xmm0             # !778
    movsd    %xmm0, 0(%eax)              # !778
    movl    $min_caml_crashed_point, %eax # !779
    movl    24(%ebp), %ebx               # !779
    movsd    0(%ebx), %xmm0              # !779
    movsd    %xmm0, 0(%eax)              # !779
    movsd    8(%ebx), %xmm0              # !780
    movsd    %xmm0, 8(%eax)              # !780
    movsd    16(%ebx), %xmm0             # !781
    movsd    %xmm0, 16(%eax)             # !781
    movl    $min_caml_intsec_rectside, %eax # !782
    movl    20(%ebp), %ebx               # !782
    movl    %ebx, 0(%eax)                # !782
    movl    $min_caml_crashed_object, %eax # !783
    movl    16(%ebp), %ebx               # !783
    movl    %ebx, 0(%eax)                # !783
je_cont.5712:                            # !776
jbe_cont.5710:                           # !770
jbe_cont.5708:                           # !769
je_cont.5704:                            # !764
    movl    $min_caml_end_flag, %eax     # !795
    movl    0(%eax), %eax                # !795
    cmpl    $0, %eax                     # !795
    jne    je_else.5713                  # !795
    movl    0(%ebp), %eax                # !796
    addl    $1, %eax                     # !796
    movl    4(%ebp), %ebx                # !796
    jmp    solve_each_element.2093       # !796
je_else.5713:                            # !795
    ret                                  # !797
solve_one_or_network.2096:               # !802
    movl    (%ebx,%eax,4), %ecx          # !804
    cmpl    $-1, %ecx                    # !805
    jne    je_else.5715                  # !805
    ret                                  # !805
je_else.5715:                            # !805
    movl    $min_caml_and_net, %edx      # !806
    movl    (%edx,%ecx,4), %ecx          # !806
    movl    $min_caml_end_flag, %edx     # !807
    movl    $0, %esi                     # !807
    movl    %esi, 0(%edx)                # !807
    movl    %ebx, 0(%ebp)                # !808
    movl    %eax, 4(%ebp)                # !808
    movl    %ecx, %ebx                   # !808
    movl    %esi, %eax                   # !808
    addl    $8, %ebp                     # !808
    call    solve_each_element.2093      # !808
    subl    $8, %ebp                     # !808
    movl    4(%ebp), %eax                # !809
    addl    $1, %eax                     # !809
    movl    0(%ebp), %ebx                # !809
    jmp    solve_one_or_network.2096     # !809
trace_or_matrix.2099:                    # !814
    movl    (%ebx,%eax,4), %ecx          # !816
    movl    0(%ecx), %edx                # !817
    cmpl    $-1, %edx                    # !818
    jne    je_else.5717                  # !818
    ret                                  # !819
je_else.5717:                            # !818
    movl    %ebx, 0(%ebp)                # !821
    movl    %eax, 4(%ebp)                # !821
    cmpl    $99, %edx                    # !821
    jne    je_else.5719                  # !821
    movl    $1, %edx                     # !822
    movl    %ecx, %ebx                   # !822
    movl    %edx, %eax                   # !822
    addl    $8, %ebp                     # !822
    call    solve_one_or_network.2096    # !822
    subl    $8, %ebp                     # !822
    jmp    je_cont.5720                  # !821
je_else.5719:                            # !821
    movl    $min_caml_vscan, %esi        # !826
    movl    $min_caml_viewpoint, %edi    # !826
    movl    %ecx, 8(%ebp)                # !826
    movl    %edi, %ecx                   # !826
    movl    %esi, %ebx                   # !826
    movl    %edx, %eax                   # !826
    addl    $16, %ebp                    # !826
    call    solver.2066                  # !826
    subl    $16, %ebp                    # !826
    cmpl    $0, %eax                     # !827
    jne    je_else.5721                  # !827
    jmp    je_cont.5722                  # !827
je_else.5721:                            # !827
    movl    $min_caml_solver_dist, %eax  # !828
    movsd    0(%eax), %xmm0              # !828
    movl    $min_caml_tmin, %eax         # !829
    movsd    0(%eax), %xmm1              # !829
    comisd    %xmm0, %xmm1               # !829
    ja    jbe_else.5723                  # !829
    jmp    jbe_cont.5724                 # !829
jbe_else.5723:                           # !829
    movl    $1, %eax                     # !830
    movl    8(%ebp), %ebx                # !830
    addl    $16, %ebp                    # !830
    call    solve_one_or_network.2096    # !830
    subl    $16, %ebp                    # !830
jbe_cont.5724:                           # !829
je_cont.5722:                            # !827
je_cont.5720:                            # !821
    movl    4(%ebp), %eax                # !834
    addl    $1, %eax                     # !834
    movl    0(%ebp), %ebx                # !834
    jmp    trace_or_matrix.2099          # !834
tracer.2102:                             # !842
    movl    $min_caml_tmin, %eax         # !845
    movl    $0, %ebx                     # !845
    movl    $l.4483, %ecx                # !845
    movsd    0(%ecx), %xmm0              # !845
    movsd    %xmm0, 0(%eax)              # !845
    movl    $min_caml_or_net, %ecx       # !846
    movl    0(%ecx), %ecx                # !846
    movl    %ebx, 0(%ebp)                # !846
    movl    %eax, 4(%ebp)                # !846
    movl    %ebx, %eax                   # !846
    movl    %ecx, %ebx                   # !846
    addl    $8, %ebp                     # !846
    call    trace_or_matrix.2099         # !846
    subl    $8, %ebp                     # !846
    movl    4(%ebp), %eax                # !847
    movsd    0(%eax), %xmm0              # !847
    movl    $l.4479, %eax                # !848
    movsd    0(%eax), %xmm1              # !848
    comisd    %xmm1, %xmm0               # !848
    ja    jbe_else.5725                  # !848
    movl    0(%ebp), %eax                # !852
    ret                                  # !852
jbe_else.5725:                           # !848
    movl    $l.4486, %eax                # !849
    movsd    0(%eax), %xmm1              # !849
    comisd    %xmm0, %xmm1               # !849
    ja    jbe_else.5726                  # !849
    movl    0(%ebp), %eax                # !851
    ret                                  # !851
jbe_else.5726:                           # !849
    movl    $1, %eax                     # !850
    ret                                  # !850
get_nvector_rect.2105:                   # !864
    movl    $min_caml_intsec_rectside, %eax # !866
    movl    0(%eax), %eax                # !866
    cmpl    $1, %eax                     # !868
    jne    je_else.5727                  # !868
    movl    $min_caml_nvector, %eax      # !870
    movl    $min_caml_vscan, %ebx        # !870
    movsd    0(%ebx), %xmm0              # !870
    movl    %eax, 0(%ebp)                # !870
    addl    $8, %ebp                     # !870
    call    sgn.2025                     # !870
    subl    $8, %ebp                     # !870
    xorpd    min_caml_fnegd, %xmm0       # !870
    movl    0(%ebp), %eax                # !870
    movsd    %xmm0, 0(%eax)              # !870
    movl    $l.4442, %ebx                # !871
    movsd    0(%ebx), %xmm0              # !871
    movsd    %xmm0, 8(%eax)              # !871
    movsd    %xmm0, 16(%eax)             # !872
    ret                                  # !872
je_else.5727:                            # !868
    cmpl    $2, %eax                     # !874
    jne    je_else.5729                  # !874
    movl    $min_caml_nvector, %eax      # !876
    movl    $l.4442, %ebx                # !876
    movsd    0(%ebx), %xmm0              # !876
    movsd    %xmm0, 0(%eax)              # !876
    movl    $min_caml_vscan, %ebx        # !877
    movsd    8(%ebx), %xmm1              # !877
    movsd    %xmm0, 8(%ebp)              # !877
    movl    %eax, 16(%ebp)               # !877
    movsd    %xmm1, %xmm0                # !877
    addl    $24, %ebp                    # !877
    call    sgn.2025                     # !877
    subl    $24, %ebp                    # !877
    xorpd    min_caml_fnegd, %xmm0       # !877
    movl    16(%ebp), %eax               # !877
    movsd    %xmm0, 8(%eax)              # !877
    movsd    8(%ebp), %xmm0              # !878
    movsd    %xmm0, 16(%eax)             # !878
    ret                                  # !878
je_else.5729:                            # !874
    cmpl    $3, %eax                     # !880
    jne    je_else.5732                  # !880
    movl    $min_caml_nvector, %eax      # !882
    movl    $l.4442, %ebx                # !882
    movsd    0(%ebx), %xmm0              # !882
    movsd    %xmm0, 0(%eax)              # !882
    movsd    %xmm0, 8(%eax)              # !883
    movl    $min_caml_vscan, %ebx        # !884
    movsd    16(%ebx), %xmm0             # !884
    movl    %eax, 20(%ebp)               # !884
    addl    $24, %ebp                    # !884
    call    sgn.2025                     # !884
    subl    $24, %ebp                    # !884
    xorpd    min_caml_fnegd, %xmm0       # !884
    movl    20(%ebp), %eax               # !884
    movsd    %xmm0, 16(%eax)             # !884
    ret                                  # !884
je_else.5732:                            # !880
    ret                                  # !886
get_nvector_plane.2107:                  # !889
    movl    $min_caml_nvector, %ebx      # !892
    movl    %eax, 0(%ebp)                # !892
    movl    %ebx, 4(%ebp)                # !892
    addl    $8, %ebp                     # !892
    call    o_param_a.1994               # !892
    subl    $8, %ebp                     # !892
    xorpd    min_caml_fnegd, %xmm0       # !892
    movl    4(%ebp), %eax                # !892
    movsd    %xmm0, 0(%eax)              # !892
    movl    0(%ebp), %ebx                # !893
    movl    %ebx, %eax                   # !893
    addl    $8, %ebp                     # !893
    call    o_param_b.1996               # !893
    subl    $8, %ebp                     # !893
    xorpd    min_caml_fnegd, %xmm0       # !893
    movl    4(%ebp), %eax                # !893
    movsd    %xmm0, 8(%eax)              # !893
    movl    0(%ebp), %ebx                # !894
    movl    %ebx, %eax                   # !894
    addl    $8, %ebp                     # !894
    call    o_param_c.1998               # !894
    subl    $8, %ebp                     # !894
    xorpd    min_caml_fnegd, %xmm0       # !894
    movl    4(%ebp), %eax                # !894
    movsd    %xmm0, 16(%eax)             # !894
    ret                                  # !894
get_nvector_second_norot.2109:           # !897
    movl    $min_caml_nvector, %ecx      # !900
    movsd    0(%ebx), %xmm0              # !900
    movl    %ebx, 0(%ebp)                # !900
    movl    %ecx, 4(%ebp)                # !900
    movl    %eax, 8(%ebp)                # !900
    movsd    %xmm0, 16(%ebp)             # !900
    addl    $24, %ebp                    # !900
    call    o_param_x.2000               # !900
    subl    $24, %ebp                    # !900
    movsd    16(%ebp), %xmm1             # !900
    subsd    %xmm0, %xmm1                # !900
    movl    8(%ebp), %eax                # !900
    movsd    %xmm1, 24(%ebp)             # !900
    addl    $32, %ebp                    # !900
    call    o_param_a.1994               # !900
    subl    $32, %ebp                    # !900
    movsd    24(%ebp), %xmm1             # !900
    mulsd    %xmm0, %xmm1                # !900
    movl    4(%ebp), %eax                # !900
    movsd    %xmm1, 0(%eax)              # !900
    movl    0(%ebp), %ebx                # !901
    movsd    8(%ebx), %xmm0              # !901
    movl    8(%ebp), %ecx                # !901
    movsd    %xmm0, 32(%ebp)             # !901
    movl    %ecx, %eax                   # !901
    addl    $40, %ebp                    # !901
    call    o_param_y.2002               # !901
    subl    $40, %ebp                    # !901
    movsd    32(%ebp), %xmm1             # !901
    subsd    %xmm0, %xmm1                # !901
    movl    8(%ebp), %eax                # !901
    movsd    %xmm1, 40(%ebp)             # !901
    addl    $48, %ebp                    # !901
    call    o_param_b.1996               # !901
    subl    $48, %ebp                    # !901
    movsd    40(%ebp), %xmm1             # !901
    mulsd    %xmm0, %xmm1                # !901
    movl    4(%ebp), %eax                # !901
    movsd    %xmm1, 8(%eax)              # !901
    movl    0(%ebp), %ebx                # !902
    movsd    16(%ebx), %xmm0             # !902
    movl    8(%ebp), %ebx                # !902
    movsd    %xmm0, 48(%ebp)             # !902
    movl    %ebx, %eax                   # !902
    addl    $56, %ebp                    # !902
    call    o_param_z.2004               # !902
    subl    $56, %ebp                    # !902
    movsd    48(%ebp), %xmm1             # !902
    subsd    %xmm0, %xmm1                # !902
    movl    8(%ebp), %eax                # !902
    movsd    %xmm1, 56(%ebp)             # !902
    addl    $64, %ebp                    # !902
    call    o_param_c.1998               # !902
    subl    $64, %ebp                    # !902
    movsd    56(%ebp), %xmm1             # !902
    mulsd    %xmm0, %xmm1                # !902
    movl    4(%ebp), %eax                # !902
    movsd    %xmm1, 16(%eax)             # !902
    movl    8(%ebp), %ebx                # !903
    movl    %ebx, %eax                   # !903
    addl    $64, %ebp                    # !903
    call    o_isinvert.1990              # !903
    subl    $64, %ebp                    # !903
    movl    %eax, %ebx                   # !903
    movl    4(%ebp), %eax                # !903
    jmp    normalize_vector.2022         # !903
get_nvector_second_rot.2112:             # !906
    movl    $min_caml_nvector_w, %ecx    # !908
    movsd    0(%ebx), %xmm0              # !908
    movl    %eax, 0(%ebp)                # !908
    movl    %ebx, 4(%ebp)                # !908
    movl    %ecx, 8(%ebp)                # !908
    movsd    %xmm0, 16(%ebp)             # !908
    addl    $24, %ebp                    # !908
    call    o_param_x.2000               # !908
    subl    $24, %ebp                    # !908
    movsd    16(%ebp), %xmm1             # !908
    subsd    %xmm0, %xmm1                # !908
    movl    8(%ebp), %eax                # !908
    movsd    %xmm1, 0(%eax)              # !908
    movl    4(%ebp), %ebx                # !909
    movsd    8(%ebx), %xmm0              # !909
    movl    0(%ebp), %ecx                # !909
    movsd    %xmm0, 24(%ebp)             # !909
    movl    %ecx, %eax                   # !909
    addl    $32, %ebp                    # !909
    call    o_param_y.2002               # !909
    subl    $32, %ebp                    # !909
    movsd    24(%ebp), %xmm1             # !909
    subsd    %xmm0, %xmm1                # !909
    movl    8(%ebp), %eax                # !909
    movsd    %xmm1, 8(%eax)              # !909
    movl    4(%ebp), %ebx                # !910
    movsd    16(%ebx), %xmm0             # !910
    movl    0(%ebp), %ebx                # !910
    movsd    %xmm0, 32(%ebp)             # !910
    movl    %ebx, %eax                   # !910
    addl    $40, %ebp                    # !910
    call    o_param_z.2004               # !910
    subl    $40, %ebp                    # !910
    movsd    32(%ebp), %xmm1             # !910
    subsd    %xmm0, %xmm1                # !910
    movl    8(%ebp), %eax                # !910
    movsd    %xmm1, 16(%eax)             # !910
    movl    $min_caml_nvector, %ebx      # !911
    movsd    0(%eax), %xmm0              # !911
    movl    0(%ebp), %ecx                # !911
    movl    %ebx, 40(%ebp)               # !911
    movsd    %xmm0, 48(%ebp)             # !911
    movl    %ecx, %eax                   # !911
    addl    $56, %ebp                    # !911
    call    o_param_a.1994               # !911
    subl    $56, %ebp                    # !911
    movsd    48(%ebp), %xmm1             # !911
    mulsd    %xmm0, %xmm1                # !911
    movl    8(%ebp), %eax                # !912
    movsd    8(%eax), %xmm0              # !912
    movl    0(%ebp), %ebx                # !912
    movsd    %xmm1, 56(%ebp)             # !912
    movsd    %xmm0, 64(%ebp)             # !912
    movl    %ebx, %eax                   # !912
    addl    $72, %ebp                    # !912
    call    o_param_r3.2020              # !912
    subl    $72, %ebp                    # !912
    movsd    64(%ebp), %xmm1             # !912
    mulsd    %xmm0, %xmm1                # !912
    movl    8(%ebp), %eax                # !913
    movsd    16(%eax), %xmm0             # !913
    movl    0(%ebp), %ebx                # !913
    movsd    %xmm1, 72(%ebp)             # !913
    movsd    %xmm0, 80(%ebp)             # !913
    movl    %ebx, %eax                   # !913
    addl    $88, %ebp                    # !913
    call    o_param_r2.2018              # !913
    subl    $88, %ebp                    # !913
    movsd    80(%ebp), %xmm1             # !913
    mulsd    %xmm0, %xmm1                # !913
    movsd    72(%ebp), %xmm0             # !912
    addsd    %xmm1, %xmm0                # !912
    addl    $88, %ebp                    # !912
    call    fhalf.1982                   # !912
    subl    $88, %ebp                    # !912
    movsd    56(%ebp), %xmm1             # !911
    addsd    %xmm0, %xmm1                # !911
    movl    40(%ebp), %eax               # !911
    movsd    %xmm1, 0(%eax)              # !911
    movl    8(%ebp), %ebx                # !914
    movsd    8(%ebx), %xmm0              # !914
    movl    0(%ebp), %ecx                # !914
    movsd    %xmm0, 88(%ebp)             # !914
    movl    %ecx, %eax                   # !914
    addl    $96, %ebp                    # !914
    call    o_param_b.1996               # !914
    subl    $96, %ebp                    # !914
    movsd    88(%ebp), %xmm1             # !914
    mulsd    %xmm0, %xmm1                # !914
    movl    8(%ebp), %eax                # !915
    movsd    0(%eax), %xmm0              # !915
    movl    0(%ebp), %ebx                # !915
    movsd    %xmm1, 96(%ebp)             # !915
    movsd    %xmm0, 104(%ebp)            # !915
    movl    %ebx, %eax                   # !915
    addl    $112, %ebp                   # !915
    call    o_param_r3.2020              # !915
    subl    $112, %ebp                   # !915
    movsd    104(%ebp), %xmm1            # !915
    mulsd    %xmm0, %xmm1                # !915
    movl    8(%ebp), %eax                # !916
    movsd    16(%eax), %xmm0             # !916
    movl    0(%ebp), %ebx                # !916
    movsd    %xmm1, 112(%ebp)            # !916
    movsd    %xmm0, 120(%ebp)            # !916
    movl    %ebx, %eax                   # !916
    addl    $128, %ebp                   # !916
    call    o_param_r1.2016              # !916
    subl    $128, %ebp                   # !916
    movsd    120(%ebp), %xmm1            # !916
    mulsd    %xmm0, %xmm1                # !916
    movsd    112(%ebp), %xmm0            # !915
    addsd    %xmm1, %xmm0                # !915
    addl    $128, %ebp                   # !915
    call    fhalf.1982                   # !915
    subl    $128, %ebp                   # !915
    movsd    96(%ebp), %xmm1             # !914
    addsd    %xmm0, %xmm1                # !914
    movl    40(%ebp), %eax               # !914
    movsd    %xmm1, 8(%eax)              # !914
    movl    8(%ebp), %ebx                # !917
    movsd    16(%ebx), %xmm0             # !917
    movl    0(%ebp), %ecx                # !917
    movsd    %xmm0, 128(%ebp)            # !917
    movl    %ecx, %eax                   # !917
    addl    $136, %ebp                   # !917
    call    o_param_c.1998               # !917
    subl    $136, %ebp                   # !917
    movsd    128(%ebp), %xmm1            # !917
    mulsd    %xmm0, %xmm1                # !917
    movl    8(%ebp), %eax                # !918
    movsd    0(%eax), %xmm0              # !918
    movl    0(%ebp), %ebx                # !918
    movsd    %xmm1, 136(%ebp)            # !918
    movsd    %xmm0, 144(%ebp)            # !918
    movl    %ebx, %eax                   # !918
    addl    $152, %ebp                   # !918
    call    o_param_r2.2018              # !918
    subl    $152, %ebp                   # !918
    movsd    144(%ebp), %xmm1            # !918
    mulsd    %xmm0, %xmm1                # !918
    movl    8(%ebp), %eax                # !919
    movsd    8(%eax), %xmm0              # !919
    movl    0(%ebp), %eax                # !919
    movsd    %xmm1, 152(%ebp)            # !919
    movsd    %xmm0, 160(%ebp)            # !919
    addl    $168, %ebp                   # !919
    call    o_param_r1.2016              # !919
    subl    $168, %ebp                   # !919
    movsd    160(%ebp), %xmm1            # !919
    mulsd    %xmm0, %xmm1                # !919
    movsd    152(%ebp), %xmm0            # !918
    addsd    %xmm1, %xmm0                # !918
    addl    $168, %ebp                   # !918
    call    fhalf.1982                   # !918
    subl    $168, %ebp                   # !918
    movsd    136(%ebp), %xmm1            # !917
    addsd    %xmm0, %xmm1                # !917
    movl    40(%ebp), %eax               # !917
    movsd    %xmm1, 16(%eax)             # !917
    movl    0(%ebp), %ebx                # !920
    movl    %ebx, %eax                   # !920
    addl    $168, %ebp                   # !920
    call    o_isinvert.1990              # !920
    subl    $168, %ebp                   # !920
    movl    %eax, %ebx                   # !920
    movl    40(%ebp), %eax               # !920
    jmp    normalize_vector.2022         # !920
get_nvector.2115:                        # !923
    movl    %ebx, 0(%ebp)                # !925
    movl    %eax, 4(%ebp)                # !925
    addl    $8, %ebp                     # !925
    call    o_form.1986                  # !925
    subl    $8, %ebp                     # !925
    cmpl    $1, %eax                     # !926
    jne    je_else.5739                  # !926
    jmp    get_nvector_rect.2105         # !927
je_else.5739:                            # !926
    cmpl    $2, %eax                     # !928
    jne    je_else.5740                  # !928
    movl    4(%ebp), %eax                # !929
    jmp    get_nvector_plane.2107        # !929
je_else.5740:                            # !928
    movl    4(%ebp), %eax                # !931
    addl    $8, %ebp                     # !931
    call    o_isrot.1992                 # !931
    subl    $8, %ebp                     # !931
    cmpl    $0, %eax                     # !931
    jne    je_else.5741                  # !931
    movl    4(%ebp), %eax                # !934
    movl    0(%ebp), %ebx                # !934
    jmp    get_nvector_second_norot.2109 # !934
je_else.5741:                            # !931
    movl    4(%ebp), %eax                # !932
    movl    0(%ebp), %ebx                # !932
    jmp    get_nvector_second_rot.2112   # !932
utexture.2118:                           # !939
    movl    %ebx, 0(%ebp)                # !941
    movl    %eax, 4(%ebp)                # !941
    addl    $8, %ebp                     # !941
    call    o_texturetype.1984           # !941
    subl    $8, %ebp                     # !941
    movl    $min_caml_texture_color, %ebx # !943
    movl    $0, %ecx                     # !943
    movl    4(%ebp), %edx                # !943
    movl    %ecx, 8(%ebp)                # !943
    movl    %eax, 12(%ebp)               # !943
    movl    %ebx, 16(%ebp)               # !943
    movl    %edx, %eax                   # !943
    addl    $24, %ebp                    # !943
    call    o_color_red.2010             # !943
    subl    $24, %ebp                    # !943
    movl    16(%ebp), %eax               # !943
    movsd    %xmm0, 0(%eax)              # !943
    movl    $1, %ebx                     # !944
    movl    4(%ebp), %ecx                # !944
    movl    %ebx, 20(%ebp)               # !944
    movl    %ecx, %eax                   # !944
    addl    $24, %ebp                    # !944
    call    o_color_green.2012           # !944
    subl    $24, %ebp                    # !944
    movl    16(%ebp), %eax               # !944
    movsd    %xmm0, 8(%eax)              # !944
    movl    4(%ebp), %ebx                # !945
    movl    %ebx, %eax                   # !945
    addl    $24, %ebp                    # !945
    call    o_color_blue.2014            # !945
    subl    $24, %ebp                    # !945
    movl    16(%ebp), %eax               # !945
    movsd    %xmm0, 16(%eax)             # !945
    movl    12(%ebp), %ebx               # !946
    cmpl    $1, %ebx                     # !946
    jne    je_else.5742                  # !946
    movl    0(%ebp), %ebx                # !949
    movsd    0(%ebx), %xmm0              # !949
    movl    4(%ebp), %ecx                # !949
    movsd    %xmm0, 24(%ebp)             # !949
    movl    %ecx, %eax                   # !949
    addl    $32, %ebp                    # !949
    call    o_param_x.2000               # !949
    subl    $32, %ebp                    # !949
    movsd    24(%ebp), %xmm1             # !949
    subsd    %xmm0, %xmm1                # !949
    movl    $l.4517, %eax                # !951
    movsd    0(%eax), %xmm0              # !951
    movsd    %xmm0, %xmm2                # !951
    mulsd    %xmm1, %xmm2                # !951
    movsd    %xmm0, 32(%ebp)             # !951
    movsd    %xmm1, 40(%ebp)             # !951
    movsd    %xmm2, %xmm0                # !951
    addl    $48, %ebp                    # !951
    call    min_caml_floor               # !951
    subl    $48, %ebp                    # !951
    movl    $l.4519, %eax                # !951
    movsd    0(%eax), %xmm1              # !951
    mulsd    %xmm1, %xmm0                # !951
    movl    $l.4506, %eax                # !952
    movsd    0(%eax), %xmm2              # !952
    movsd    40(%ebp), %xmm3             # !952
    subsd    %xmm0, %xmm3                # !952
    comisd    %xmm3, %xmm2               # !952
    ja    jbe_else.5743                  # !952
    movl    8(%ebp), %eax                # !952
    jmp    jbe_cont.5744                 # !952
jbe_else.5743:                           # !952
    movl    20(%ebp), %eax               # !952
jbe_cont.5744:                           # !952
    movl    0(%ebp), %ebx                # !954
    movsd    16(%ebx), %xmm0             # !954
    movl    4(%ebp), %ebx                # !954
    movl    %eax, 48(%ebp)               # !954
    movsd    %xmm2, 56(%ebp)             # !954
    movsd    %xmm1, 64(%ebp)             # !954
    movsd    %xmm0, 72(%ebp)             # !954
    movl    %ebx, %eax                   # !954
    addl    $80, %ebp                    # !954
    call    o_param_z.2004               # !954
    subl    $80, %ebp                    # !954
    movsd    72(%ebp), %xmm1             # !954
    subsd    %xmm0, %xmm1                # !954
    movsd    32(%ebp), %xmm0             # !956
    mulsd    %xmm1, %xmm0                # !956
    movsd    %xmm1, 80(%ebp)             # !956
    addl    $88, %ebp                    # !956
    call    min_caml_floor               # !956
    subl    $88, %ebp                    # !956
    movsd    64(%ebp), %xmm1             # !956
    mulsd    %xmm0, %xmm1                # !956
    movsd    80(%ebp), %xmm0             # !957
    subsd    %xmm1, %xmm0                # !957
    movsd    56(%ebp), %xmm1             # !957
    comisd    %xmm0, %xmm1               # !957
    ja    jbe_else.5746                  # !957
    movl    8(%ebp), %eax                # !957
    jmp    jbe_cont.5747                 # !957
jbe_else.5746:                           # !957
    movl    20(%ebp), %eax               # !957
jbe_cont.5747:                           # !957
    movl    48(%ebp), %ebx               # !960
    cmpl    $0, %ebx                     # !960
    jne    je_else.5748                  # !960
    cmpl    $0, %eax                     # !962
    jne    je_else.5750                  # !962
    movl    $l.4510, %eax                # !962
    movsd    0(%eax), %xmm0              # !962
    jmp    je_cont.5751                  # !962
je_else.5750:                            # !962
    movl    $l.4442, %eax                # !962
    movsd    0(%eax), %xmm0              # !962
je_cont.5751:                            # !962
    jmp    je_cont.5749                  # !960
je_else.5748:                            # !960
    cmpl    $0, %eax                     # !961
    jne    je_else.5752                  # !961
    movl    $l.4442, %eax                # !961
    movsd    0(%eax), %xmm0              # !961
    jmp    je_cont.5753                  # !961
je_else.5752:                            # !961
    movl    $l.4510, %eax                # !961
    movsd    0(%eax), %xmm0              # !961
je_cont.5753:                            # !961
je_cont.5749:                            # !960
    movl    16(%ebp), %eax               # !959
    movsd    %xmm0, 8(%eax)              # !959
    ret                                  # !959
je_else.5742:                            # !946
    cmpl    $2, %ebx                     # !964
    jne    je_else.5755                  # !964
    movl    0(%ebp), %ebx                # !967
    movsd    8(%ebx), %xmm0              # !967
    movl    $l.4513, %ebx                # !967
    movsd    0(%ebx), %xmm1              # !967
    mulsd    %xmm1, %xmm0                # !967
    addl    $88, %ebp                    # !967
    call    min_caml_sin                 # !967
    subl    $88, %ebp                    # !967
    addl    $88, %ebp                    # !967
    call    fsqr.1980                    # !967
    subl    $88, %ebp                    # !967
    movl    $l.4510, %eax                # !968
    movsd    0(%eax), %xmm1              # !968
    movsd    %xmm1, %xmm2                # !968
    mulsd    %xmm0, %xmm2                # !968
    movl    16(%ebp), %eax               # !968
    movsd    %xmm2, 0(%eax)              # !968
    movl    $l.4444, %ebx                # !969
    movsd    0(%ebx), %xmm2              # !969
    subsd    %xmm0, %xmm2                # !969
    mulsd    %xmm2, %xmm1                # !969
    movsd    %xmm1, 8(%eax)              # !969
    ret                                  # !969
je_else.5755:                            # !964
    cmpl    $3, %ebx                     # !971
    jne    je_else.5757                  # !971
    movl    0(%ebp), %ebx                # !974
    movsd    0(%ebx), %xmm0              # !974
    movl    4(%ebp), %ecx                # !974
    movsd    %xmm0, 88(%ebp)             # !974
    movl    %ecx, %eax                   # !974
    addl    $96, %ebp                    # !974
    call    o_param_x.2000               # !974
    subl    $96, %ebp                    # !974
    movsd    88(%ebp), %xmm1             # !974
    subsd    %xmm0, %xmm1                # !974
    movl    0(%ebp), %eax                # !975
    movsd    16(%eax), %xmm0             # !975
    movl    4(%ebp), %eax                # !975
    movsd    %xmm1, 96(%ebp)             # !975
    movsd    %xmm0, 104(%ebp)            # !975
    addl    $112, %ebp                   # !975
    call    o_param_z.2004               # !975
    subl    $112, %ebp                   # !975
    movsd    104(%ebp), %xmm1            # !975
    subsd    %xmm0, %xmm1                # !975
    movsd    96(%ebp), %xmm0             # !976
    movsd    %xmm1, 112(%ebp)            # !976
    addl    $120, %ebp                   # !976
    call    fsqr.1980                    # !976
    subl    $120, %ebp                   # !976
    movsd    112(%ebp), %xmm1            # !976
    movsd    %xmm0, 120(%ebp)            # !976
    movsd    %xmm1, %xmm0                # !976
    addl    $128, %ebp                   # !976
    call    fsqr.1980                    # !976
    subl    $128, %ebp                   # !976
    movsd    120(%ebp), %xmm1            # !976
    addsd    %xmm1, %xmm0                # !976
    addl    $128, %ebp                   # !976
    call    min_caml_sqrt                # !976
    subl    $128, %ebp                   # !976
    movl    $l.4506, %eax                # !976
    movsd    0(%eax), %xmm1              # !976
    divsd    %xmm1, %xmm0                # !976
    movsd    %xmm0, 128(%ebp)            # !977
    addl    $136, %ebp                   # !977
    call    min_caml_floor               # !977
    subl    $136, %ebp                   # !977
    movsd    128(%ebp), %xmm1            # !977
    subsd    %xmm0, %xmm1                # !977
    movl    $l.4508, %eax                # !977
    movsd    0(%eax), %xmm0              # !977
    mulsd    %xmm1, %xmm0                # !977
    addl    $136, %ebp                   # !978
    call    min_caml_cos                 # !978
    subl    $136, %ebp                   # !978
    addl    $136, %ebp                   # !978
    call    fsqr.1980                    # !978
    subl    $136, %ebp                   # !978
    movl    $l.4510, %eax                # !979
    movsd    0(%eax), %xmm1              # !979
    movsd    %xmm1, %xmm2                # !979
    mulsd    %xmm0, %xmm2                # !979
    movl    16(%ebp), %eax               # !979
    movsd    %xmm2, 8(%eax)              # !979
    movl    $l.4444, %ebx                # !980
    movsd    0(%ebx), %xmm2              # !980
    subsd    %xmm0, %xmm2                # !980
    mulsd    %xmm2, %xmm1                # !980
    movsd    %xmm1, 16(%eax)             # !980
    ret                                  # !980
je_else.5757:                            # !971
    cmpl    $4, %ebx                     # !982
    jne    je_else.5759                  # !982
    movl    0(%ebp), %ebx                # !984
    movsd    0(%ebx), %xmm0              # !984
    movl    4(%ebp), %ecx                # !984
    movsd    %xmm0, 136(%ebp)            # !984
    movl    %ecx, %eax                   # !984
    addl    $144, %ebp                   # !984
    call    o_param_x.2000               # !984
    subl    $144, %ebp                   # !984
    movsd    136(%ebp), %xmm1            # !984
    subsd    %xmm0, %xmm1                # !984
    movl    4(%ebp), %eax                # !984
    movsd    %xmm1, 144(%ebp)            # !984
    addl    $152, %ebp                   # !984
    call    o_param_a.1994               # !984
    subl    $152, %ebp                   # !984
    addl    $152, %ebp                   # !984
    call    min_caml_sqrt                # !984
    subl    $152, %ebp                   # !984
    movsd    144(%ebp), %xmm1            # !984
    mulsd    %xmm0, %xmm1                # !984
    movl    0(%ebp), %eax                # !985
    movsd    16(%eax), %xmm0             # !985
    movl    4(%ebp), %ebx                # !985
    movsd    %xmm1, 152(%ebp)            # !985
    movsd    %xmm0, 160(%ebp)            # !985
    movl    %ebx, %eax                   # !985
    addl    $168, %ebp                   # !985
    call    o_param_z.2004               # !985
    subl    $168, %ebp                   # !985
    movsd    160(%ebp), %xmm1            # !985
    subsd    %xmm0, %xmm1                # !985
    movl    4(%ebp), %eax                # !985
    movsd    %xmm1, 168(%ebp)            # !985
    addl    $176, %ebp                   # !985
    call    o_param_c.1998               # !985
    subl    $176, %ebp                   # !985
    addl    $176, %ebp                   # !985
    call    min_caml_sqrt                # !985
    subl    $176, %ebp                   # !985
    movsd    168(%ebp), %xmm1            # !985
    mulsd    %xmm0, %xmm1                # !985
    movsd    152(%ebp), %xmm0            # !986
    movsd    %xmm1, 176(%ebp)            # !986
    addl    $184, %ebp                   # !986
    call    fsqr.1980                    # !986
    subl    $184, %ebp                   # !986
    movsd    176(%ebp), %xmm1            # !986
    movsd    %xmm0, 184(%ebp)            # !986
    movsd    %xmm1, %xmm0                # !986
    addl    $192, %ebp                   # !986
    call    fsqr.1980                    # !986
    subl    $192, %ebp                   # !986
    movsd    184(%ebp), %xmm1            # !986
    addsd    %xmm1, %xmm0                # !986
    addl    $192, %ebp                   # !986
    call    min_caml_sqrt                # !986
    subl    $192, %ebp                   # !986
    movl    $l.4491, %eax                # !988
    movsd    0(%eax), %xmm1              # !988
    movsd    152(%ebp), %xmm2            # !988
    movsd    %xmm0, 192(%ebp)            # !988
    movsd    %xmm1, 200(%ebp)            # !988
    movsd    %xmm2, %xmm0                # !988
    addl    $208, %ebp                   # !988
    call    min_caml_abs_float           # !988
    subl    $208, %ebp                   # !988
    movsd    200(%ebp), %xmm1            # !988
    comisd    %xmm0, %xmm1               # !988
    ja    jbe_else.5760                  # !988
    movsd    152(%ebp), %xmm0            # !991
    movsd    176(%ebp), %xmm2            # !991
    movsd    %xmm0, 208(%ebp)            # !991
    movsd    %xmm2, %xmm0                # !991
    divsd    208(%ebp), %xmm0            # !991
    addl    $208, %ebp                   # !991
    call    min_caml_abs_float           # !991
    subl    $208, %ebp                   # !991
    addl    $208, %ebp                   # !993
    call    min_caml_atan                # !993
    subl    $208, %ebp                   # !993
    movl    $l.4495, %eax                # !993
    movsd    0(%eax), %xmm1              # !993
    mulsd    %xmm1, %xmm0                # !993
    jmp    jbe_cont.5761                 # !988
jbe_else.5760:                           # !988
    movl    $l.4493, %eax                # !989
    movsd    0(%eax), %xmm0              # !989
jbe_cont.5761:                           # !988
    movsd    %xmm0, 208(%ebp)            # !995
    addl    $216, %ebp                   # !995
    call    min_caml_floor               # !995
    subl    $216, %ebp                   # !995
    movsd    208(%ebp), %xmm1            # !995
    movsd    %xmm0, 216(%ebp)            # !995
    movsd    %xmm1, %xmm0                # !995
    subsd    216(%ebp), %xmm0            # !995
    movl    0(%ebp), %eax                # !997
    movsd    8(%eax), %xmm2              # !997
    movl    4(%ebp), %eax                # !997
    movsd    %xmm0, 216(%ebp)            # !997
    movsd    %xmm2, 224(%ebp)            # !997
    addl    $232, %ebp                   # !997
    call    o_param_y.2002               # !997
    subl    $232, %ebp                   # !997
    movsd    224(%ebp), %xmm1            # !997
    subsd    %xmm0, %xmm1                # !997
    movl    4(%ebp), %eax                # !997
    movsd    %xmm1, 232(%ebp)            # !997
    addl    $240, %ebp                   # !997
    call    o_param_b.1996               # !997
    subl    $240, %ebp                   # !997
    addl    $240, %ebp                   # !997
    call    min_caml_sqrt                # !997
    subl    $240, %ebp                   # !997
    movsd    232(%ebp), %xmm1            # !997
    mulsd    %xmm0, %xmm1                # !997
    movsd    208(%ebp), %xmm0            # !999
    movsd    %xmm1, 240(%ebp)            # !999
    addl    $248, %ebp                   # !999
    call    min_caml_abs_float           # !999
    subl    $248, %ebp                   # !999
    movsd    200(%ebp), %xmm1            # !999
    comisd    %xmm0, %xmm1               # !999
    ja    jbe_else.5762                  # !999
    movsd    192(%ebp), %xmm0            # !1002
    movsd    240(%ebp), %xmm1            # !1002
    movsd    %xmm0, 248(%ebp)            # !1002
    movsd    %xmm1, %xmm0                # !1002
    divsd    248(%ebp), %xmm0            # !1002
    addl    $248, %ebp                   # !1002
    call    min_caml_abs_float           # !1002
    subl    $248, %ebp                   # !1002
    addl    $248, %ebp                   # !1003
    call    min_caml_atan                # !1003
    subl    $248, %ebp                   # !1003
    movl    $l.4495, %eax                # !1003
    movsd    0(%eax), %xmm1              # !1003
    mulsd    %xmm1, %xmm0                # !1003
    jmp    jbe_cont.5763                 # !999
jbe_else.5762:                           # !999
    movl    $l.4493, %eax                # !1000
    movsd    0(%eax), %xmm0              # !1000
jbe_cont.5763:                           # !999
    movsd    %xmm0, 248(%ebp)            # !1005
    addl    $256, %ebp                   # !1005
    call    min_caml_floor               # !1005
    subl    $256, %ebp                   # !1005
    movsd    248(%ebp), %xmm1            # !1005
    subsd    %xmm0, %xmm1                # !1005
    movl    $l.4499, %eax                # !1006
    movsd    0(%eax), %xmm0              # !1006
    movl    $l.4501, %eax                # !1006
    movsd    0(%eax), %xmm2              # !1006
    movsd    216(%ebp), %xmm3            # !1006
    movsd    %xmm3, 256(%ebp)            # !1006
    movsd    %xmm2, %xmm3                # !1006
    subsd    256(%ebp), %xmm3            # !1006
    movsd    %xmm1, 256(%ebp)            # !1006
    movsd    %xmm2, 264(%ebp)            # !1006
    movsd    %xmm0, 272(%ebp)            # !1006
    movsd    %xmm3, %xmm0                # !1006
    addl    $280, %ebp                   # !1006
    call    fsqr.1980                    # !1006
    subl    $280, %ebp                   # !1006
    movsd    272(%ebp), %xmm1            # !1006
    subsd    %xmm0, %xmm1                # !1006
    movsd    256(%ebp), %xmm0            # !1006
    movsd    264(%ebp), %xmm2            # !1006
    movsd    %xmm0, 280(%ebp)            # !1006
    movsd    %xmm2, %xmm0                # !1006
    subsd    280(%ebp), %xmm0            # !1006
    movsd    %xmm1, 280(%ebp)            # !1006
    addl    $288, %ebp                   # !1006
    call    fsqr.1980                    # !1006
    subl    $288, %ebp                   # !1006
    movsd    280(%ebp), %xmm1            # !1006
    subsd    %xmm0, %xmm1                # !1006
    movl    $l.4442, %eax                # !1007
    movsd    0(%eax), %xmm0              # !1007
    comisd    %xmm0, %xmm1               # !1007
    ja    jbe_else.5764                  # !1007
    jmp    jbe_cont.5765                 # !1007
jbe_else.5764:                           # !1007
    movl    $l.4504, %eax                # !1007
    movsd    0(%eax), %xmm0              # !1007
    mulsd    %xmm1, %xmm0                # !1007
jbe_cont.5765:                           # !1007
    movl    16(%ebp), %eax               # !1007
    movsd    %xmm0, 16(%eax)             # !1007
    ret                                  # !1007
je_else.5759:                            # !982
    ret                                  # !1009
in_prod.2121:                            # !1019
    movsd    0(%eax), %xmm0              # !1021
    movsd    0(%ebx), %xmm1              # !1021
    mulsd    %xmm1, %xmm0                # !1021
    movsd    8(%eax), %xmm1              # !1021
    movsd    8(%ebx), %xmm2              # !1021
    mulsd    %xmm2, %xmm1                # !1021
    addsd    %xmm1, %xmm0                # !1021
    movsd    16(%eax), %xmm1             # !1021
    movsd    16(%ebx), %xmm2             # !1021
    mulsd    %xmm2, %xmm1                # !1021
    addsd    %xmm1, %xmm0                # !1021
    ret                                  # !1021
accumulate_vec_mul.2124:                 # !1025
    movsd    0(%eax), %xmm1              # !1027
    movsd    0(%ebx), %xmm2              # !1027
    mulsd    %xmm0, %xmm2                # !1027
    addsd    %xmm2, %xmm1                # !1027
    movsd    %xmm1, 0(%eax)              # !1027
    movsd    8(%eax), %xmm1              # !1028
    movsd    8(%ebx), %xmm2              # !1028
    mulsd    %xmm0, %xmm2                # !1028
    addsd    %xmm2, %xmm1                # !1028
    movsd    %xmm1, 8(%eax)              # !1028
    movsd    16(%eax), %xmm1             # !1029
    movsd    16(%ebx), %xmm2             # !1029
    mulsd    %xmm0, %xmm2                # !1029
    addsd    %xmm2, %xmm1                # !1029
    movsd    %xmm1, 16(%eax)             # !1029
    ret                                  # !1029
raytracing.2128:                         # !1032
    movl    $min_caml_viewpoint, %ebx    # !1034
    movl    $min_caml_vscan, %ecx        # !1034
    movl    %ebx, 0(%ebp)                # !1034
    movsd    %xmm0, 8(%ebp)              # !1034
    movl    %ecx, 16(%ebp)               # !1034
    movl    %eax, 20(%ebp)               # !1034
    movl    %ebx, %eax                   # !1034
    movl    %ecx, %ebx                   # !1034
    addl    $24, %ebp                    # !1034
    call    tracer.2102                  # !1034
    subl    $24, %ebp                    # !1034
    movl    $0, %ebx                     # !1038
    movl    %ebx, 24(%ebp)               # !1038
    movl    %eax, 28(%ebp)               # !1038
    cmpl    $0, %eax                     # !1038
    jne    je_else.5770                  # !1038
    movl    20(%ebp), %ecx               # !1039
    cmpl    $0, %ecx                     # !1039
    jne    je_else.5772                  # !1039
    jmp    je_cont.5773                  # !1039
je_else.5772:                            # !1039
    movl    $min_caml_light, %edx        # !1041
    movl    16(%ebp), %esi               # !1041
    movl    %edx, %ebx                   # !1041
    movl    %esi, %eax                   # !1041
    addl    $32, %ebp                    # !1041
    call    in_prod.2121                 # !1041
    subl    $32, %ebp                    # !1041
    xorpd    min_caml_fnegd, %xmm0       # !1041
    movl    $l.4442, %eax                # !1043
    movsd    0(%eax), %xmm1              # !1043
    comisd    %xmm1, %xmm0               # !1043
    ja    jbe_else.5774                  # !1043
    jmp    jbe_cont.5775                 # !1043
jbe_else.5774:                           # !1043
    movsd    %xmm0, 32(%ebp)             # !1046
    addl    $40, %ebp                    # !1046
    call    fsqr.1980                    # !1046
    subl    $40, %ebp                    # !1046
    movsd    32(%ebp), %xmm1             # !1046
    mulsd    %xmm1, %xmm0                # !1046
    movsd    8(%ebp), %xmm1              # !1046
    mulsd    %xmm1, %xmm0                # !1046
    movl    $min_caml_beam, %eax         # !1046
    movsd    0(%eax), %xmm2              # !1046
    mulsd    %xmm2, %xmm0                # !1046
    movl    $min_caml_rgb, %eax          # !1047
    movsd    0(%eax), %xmm2              # !1047
    addsd    %xmm0, %xmm2                # !1047
    movsd    %xmm2, 0(%eax)              # !1047
    movsd    8(%eax), %xmm2              # !1048
    addsd    %xmm0, %xmm2                # !1048
    movsd    %xmm2, 8(%eax)              # !1048
    movsd    16(%eax), %xmm2             # !1049
    addsd    %xmm0, %xmm2                # !1049
    movsd    %xmm2, 16(%eax)             # !1049
jbe_cont.5775:                           # !1043
je_cont.5773:                            # !1039
    jmp    je_cont.5771                  # !1038
je_else.5770:                            # !1038
je_cont.5771:                            # !1038
    movl    28(%ebp), %eax               # !1056
    cmpl    $0, %eax                     # !1056
    jne    je_else.5776                  # !1056
    ret                                  # !1116
je_else.5776:                            # !1056
    movl    $min_caml_objects, %eax      # !1060
    movl    $min_caml_crashed_object, %ebx # !1060
    movl    0(%ebx), %ebx                # !1060
    movl    (%eax,%ebx,4), %eax          # !1060
    movl    $min_caml_crashed_point, %ebx # !1061
    movl    %eax, 40(%ebp)               # !1061
    movl    %ebx, 44(%ebp)               # !1061
    addl    $48, %ebp                    # !1061
    call    get_nvector.2115             # !1061
    subl    $48, %ebp                    # !1061
    movl    $min_caml_or_net, %eax       # !1063
    movl    0(%eax), %ebx                # !1063
    movl    24(%ebp), %eax               # !1063
    movl    44(%ebp), %ecx               # !1063
    addl    $48, %ebp                    # !1063
    call    shadow_check_one_or_matrix.2089 # !1063
    subl    $48, %ebp                    # !1063
    cmpl    $0, %eax                     # !1063
    jne    je_else.5778                  # !1063
    movl    $min_caml_nvector, %eax      # !1067
    movl    $min_caml_light, %ebx        # !1067
    addl    $48, %ebp                    # !1067
    call    in_prod.2121                 # !1067
    subl    $48, %ebp                    # !1067
    xorpd    min_caml_fnegd, %xmm0       # !1067
    movl    $l.4442, %eax                # !1068
    movsd    0(%eax), %xmm1              # !1068
    comisd    %xmm0, %xmm1               # !1068
    ja    jbe_else.5780                  # !1068
    movl    $l.4529, %eax                # !1068
    movsd    0(%eax), %xmm1              # !1068
    addsd    %xmm0, %xmm1                # !1068
    jmp    jbe_cont.5781                 # !1068
jbe_else.5780:                           # !1068
    movl    $l.4529, %eax                # !1068
    movsd    0(%eax), %xmm1              # !1068
jbe_cont.5781:                           # !1068
    movsd    8(%ebp), %xmm0              # !1069
    mulsd    %xmm0, %xmm1                # !1069
    movl    40(%ebp), %eax               # !1069
    movsd    %xmm1, 48(%ebp)             # !1069
    addl    $56, %ebp                    # !1069
    call    o_diffuse.2006               # !1069
    subl    $56, %ebp                    # !1069
    movsd    48(%ebp), %xmm1             # !1069
    mulsd    %xmm0, %xmm1                # !1069
    jmp    je_cont.5779                  # !1063
je_else.5778:                            # !1063
    movl    $l.4442, %eax                # !1065
    movsd    0(%eax), %xmm1              # !1065
je_cont.5779:                            # !1063
    movl    40(%ebp), %eax               # !1072
    movl    44(%ebp), %ebx               # !1072
    movsd    %xmm1, 56(%ebp)             # !1072
    addl    $64, %ebp                    # !1072
    call    utexture.2118                # !1072
    subl    $64, %ebp                    # !1072
    movl    $min_caml_rgb, %eax          # !1073
    movl    $min_caml_texture_color, %ebx # !1073
    movsd    56(%ebp), %xmm0             # !1073
    movl    %eax, 64(%ebp)               # !1073
    addl    $72, %ebp                    # !1073
    call    accumulate_vec_mul.2124      # !1073
    subl    $72, %ebp                    # !1073
    movl    20(%ebp), %eax               # !1075
    cmpl    $4, %eax                     # !1075
    jg    jle_else.5782                  # !1075
    movl    $l.4532, %ebx                # !1076
    movsd    0(%ebx), %xmm0              # !1076
    movsd    8(%ebp), %xmm1              # !1076
    comisd    %xmm0, %xmm1               # !1076
    ja    jbe_else.5783                  # !1076
    ret                                  # !1114
jbe_else.5783:                           # !1076
    movl    $l.4534, %ebx                # !1079
    movsd    0(%ebx), %xmm0              # !1079
    movl    $min_caml_nvector, %ebx      # !1079
    movl    16(%ebp), %ecx               # !1079
    movl    %ebx, 68(%ebp)               # !1079
    movsd    %xmm0, 72(%ebp)             # !1079
    movl    %ecx, %eax                   # !1079
    addl    $80, %ebp                    # !1079
    call    in_prod.2121                 # !1079
    subl    $80, %ebp                    # !1079
    movsd    72(%ebp), %xmm1             # !1079
    mulsd    %xmm1, %xmm0                # !1079
    movl    16(%ebp), %eax               # !1081
    movl    68(%ebp), %ebx               # !1081
    addl    $80, %ebp                    # !1081
    call    accumulate_vec_mul.2124      # !1081
    subl    $80, %ebp                    # !1081
    movl    40(%ebp), %eax               # !1083
    addl    $80, %ebp                    # !1083
    call    o_reflectiontype.1988        # !1083
    subl    $80, %ebp                    # !1083
    cmpl    $1, %eax                     # !1084
    jne    je_else.5785                  # !1084
    movl    $l.4442, %eax                # !1087
    movsd    0(%eax), %xmm0              # !1087
    movl    40(%ebp), %eax               # !1087
    movsd    %xmm0, 80(%ebp)             # !1087
    addl    $88, %ebp                    # !1087
    call    o_hilight.2008               # !1087
    subl    $88, %ebp                    # !1087
    movsd    80(%ebp), %xmm1             # !1086
    comisd    %xmm0, %xmm1               # !1086
    jne    je_else.5786                  # !1086
    ret                                  # !1088
je_else.5786:                            # !1086
    movl    $min_caml_light, %ebx        # !1090
    movl    16(%ebp), %eax               # !1090
    addl    $88, %ebp                    # !1090
    call    in_prod.2121                 # !1090
    subl    $88, %ebp                    # !1090
    xorpd    min_caml_fnegd, %xmm0       # !1090
    movsd    80(%ebp), %xmm1             # !1091
    comisd    %xmm1, %xmm0               # !1091
    ja    jbe_else.5788                  # !1091
    ret                                  # !1101
jbe_else.5788:                           # !1091
    addl    $88, %ebp                    # !1094
    call    fsqr.1980                    # !1094
    subl    $88, %ebp                    # !1094
    addl    $88, %ebp                    # !1094
    call    fsqr.1980                    # !1094
    subl    $88, %ebp                    # !1094
    movsd    8(%ebp), %xmm1              # !1094
    mulsd    %xmm1, %xmm0                # !1094
    movsd    56(%ebp), %xmm1             # !1094
    mulsd    %xmm1, %xmm0                # !1094
    movl    40(%ebp), %eax               # !1095
    movsd    %xmm0, 88(%ebp)             # !1095
    addl    $96, %ebp                    # !1095
    call    o_hilight.2008               # !1095
    subl    $96, %ebp                    # !1095
    movsd    88(%ebp), %xmm1             # !1094
    mulsd    %xmm0, %xmm1                # !1094
    movl    64(%ebp), %eax               # !1097
    movsd    0(%eax), %xmm0              # !1097
    addsd    %xmm1, %xmm0                # !1097
    movsd    %xmm0, 0(%eax)              # !1097
    movsd    8(%eax), %xmm0              # !1098
    addsd    %xmm1, %xmm0                # !1098
    movsd    %xmm0, 8(%eax)              # !1098
    movsd    16(%eax), %xmm0             # !1099
    addsd    %xmm1, %xmm0                # !1099
    movsd    %xmm0, 16(%eax)             # !1099
    ret                                  # !1099
je_else.5785:                            # !1084
    cmpl    $2, %eax                     # !1103
    jne    je_else.5791                  # !1103
    movl    44(%ebp), %eax               # !1106
    movsd    0(%eax), %xmm0              # !1106
    movl    0(%ebp), %ebx                # !1106
    movsd    %xmm0, 0(%ebx)              # !1106
    movsd    8(%eax), %xmm0              # !1107
    movsd    %xmm0, 8(%ebx)              # !1107
    movsd    16(%eax), %xmm0             # !1108
    movsd    %xmm0, 16(%ebx)             # !1108
    movl    $l.4444, %eax                # !1109
    movsd    0(%eax), %xmm0              # !1109
    movl    40(%ebp), %eax               # !1109
    movsd    %xmm0, 96(%ebp)             # !1109
    addl    $104, %ebp                   # !1109
    call    o_diffuse.2006               # !1109
    subl    $104, %ebp                   # !1109
    movsd    96(%ebp), %xmm1             # !1109
    subsd    %xmm0, %xmm1                # !1109
    movsd    8(%ebp), %xmm0              # !1109
    mulsd    %xmm1, %xmm0                # !1109
    movl    20(%ebp), %eax               # !1110
    addl    $1, %eax                     # !1110
    jmp    raytracing.2128               # !1110
je_else.5791:                            # !1103
    ret                                  # !1112
jle_else.5782:                           # !1075
    ret                                  # !1075
write_rgb.2131:                          # !1120
    movl    $min_caml_rgb, %eax          # !1123
    movsd    0(%eax), %xmm0              # !1123
    movl    %eax, 0(%ebp)                # !1123
    addl    $8, %ebp                     # !1123
    call    min_caml_int_of_float        # !1123
    subl    $8, %ebp                     # !1123
    movl    $255, %ebx                   # !1124
    cmpl    $255, %eax                   # !1124
    jg    jle_else.5794                  # !1124
    jmp    jle_cont.5795                 # !1124
jle_else.5794:                           # !1124
    movl    %ebx, %eax                   # !1124
jle_cont.5795:                           # !1124
    movl    %ebx, 4(%ebp)                # !1125
    addl    $8, %ebp                     # !1125
    call    min_caml_print_byte          # !1125
    subl    $8, %ebp                     # !1125
    movl    0(%ebp), %eax                # !1127
    movsd    8(%eax), %xmm0              # !1127
    addl    $8, %ebp                     # !1127
    call    min_caml_int_of_float        # !1127
    subl    $8, %ebp                     # !1127
    cmpl    $255, %eax                   # !1128
    jg    jle_else.5796                  # !1128
    jmp    jle_cont.5797                 # !1128
jle_else.5796:                           # !1128
    movl    4(%ebp), %eax                # !1128
jle_cont.5797:                           # !1128
    addl    $8, %ebp                     # !1129
    call    min_caml_print_byte          # !1129
    subl    $8, %ebp                     # !1129
    movl    0(%ebp), %eax                # !1131
    movsd    16(%eax), %xmm0             # !1131
    addl    $8, %ebp                     # !1131
    call    min_caml_int_of_float        # !1131
    subl    $8, %ebp                     # !1131
    cmpl    $255, %eax                   # !1132
    jg    jle_else.5798                  # !1132
    jmp    jle_cont.5799                 # !1132
jle_else.5798:                           # !1132
    movl    4(%ebp), %eax                # !1132
jle_cont.5799:                           # !1132
    jmp    min_caml_print_byte           # !1133
write_ppm_header.2133:                   # !1137
    movl    $80, %eax                    # !1140
    call    min_caml_print_byte          # !1140
    movl    $54, %eax                    # !1141
    call    min_caml_print_byte          # !1141
    movl    $10, %eax                    # !1142
    movl    %eax, 0(%ebp)                # !1142
    addl    $8, %ebp                     # !1142
    call    min_caml_print_byte          # !1142
    subl    $8, %ebp                     # !1142
    movl    $min_caml_size, %eax         # !1143
    movl    0(%eax), %ebx                # !1143
    movl    %eax, 4(%ebp)                # !1143
    movl    %ebx, %eax                   # !1143
    addl    $8, %ebp                     # !1143
    call    min_caml_print_int           # !1143
    subl    $8, %ebp                     # !1143
    movl    $32, %eax                    # !1144
    addl    $8, %ebp                     # !1144
    call    min_caml_print_byte          # !1144
    subl    $8, %ebp                     # !1144
    movl    4(%ebp), %eax                # !1145
    movl    4(%eax), %eax                # !1145
    addl    $8, %ebp                     # !1145
    call    min_caml_print_int           # !1145
    subl    $8, %ebp                     # !1145
    movl    0(%ebp), %eax                # !1146
    addl    $8, %ebp                     # !1146
    call    min_caml_print_byte          # !1146
    subl    $8, %ebp                     # !1146
    movl    $255, %eax                   # !1147
    addl    $8, %ebp                     # !1147
    call    min_caml_print_int           # !1147
    subl    $8, %ebp                     # !1147
    movl    0(%ebp), %eax                # !1148
    jmp    min_caml_print_byte           # !1148
scan_point.2135:                         # !1153
    movl    $min_caml_size, %ebx         # !1155
    movl    $0, %ecx                     # !1155
    movl    0(%ebx), %ebx                # !1155
    cmpl    %eax, %ebx                   # !1155
    jg    jle_else.5800                  # !1155
    ret                                  # !1155
jle_else.5800:                           # !1155
    movl    %eax, 0(%ebp)                # !1158
    movl    %ecx, 4(%ebp)                # !1158
    addl    $8, %ebp                     # !1158
    call    min_caml_float_of_int        # !1158
    subl    $8, %ebp                     # !1158
    movl    $min_caml_scan_offset, %eax  # !1158
    movsd    0(%eax), %xmm1              # !1158
    subsd    %xmm1, %xmm0                # !1158
    movl    $min_caml_scan_d, %eax       # !1158
    movsd    0(%eax), %xmm1              # !1158
    mulsd    %xmm1, %xmm0                # !1158
    movl    $min_caml_vscan, %eax        # !1160
    movl    $min_caml_cos_v, %ebx        # !1160
    movsd    8(%ebx), %xmm1              # !1160
    mulsd    %xmm0, %xmm1                # !1160
    movl    $min_caml_wscan, %ecx        # !1160
    movsd    0(%ecx), %xmm2              # !1160
    addsd    %xmm2, %xmm1                # !1160
    movsd    %xmm1, 0(%eax)              # !1160
    movl    $min_caml_scan_sscany, %edx  # !1161
    movsd    0(%edx), %xmm1              # !1161
    movsd    0(%ebx), %xmm2              # !1161
    mulsd    %xmm2, %xmm1                # !1161
    movl    $min_caml_vp, %ebx           # !1161
    movsd    8(%ebx), %xmm2              # !1161
    subsd    %xmm2, %xmm1                # !1161
    movsd    %xmm1, 8(%eax)              # !1161
    movsd    %xmm0, %xmm1                # !1162
    xorpd    min_caml_fnegd, %xmm1       # !1162
    movl    $min_caml_sin_v, %ebx        # !1162
    movsd    8(%ebx), %xmm2              # !1162
    mulsd    %xmm2, %xmm1                # !1162
    movsd    16(%ecx), %xmm2             # !1162
    addsd    %xmm2, %xmm1                # !1162
    movsd    %xmm1, 16(%eax)             # !1162
    movl    %eax, 8(%ebp)                # !1165
    addl    $16, %ebp                    # !1165
    call    fsqr.1980                    # !1165
    subl    $16, %ebp                    # !1165
    movl    $min_caml_scan_met1, %eax    # !1165
    movsd    0(%eax), %xmm1              # !1165
    addsd    %xmm1, %xmm0                # !1165
    addl    $16, %ebp                    # !1165
    call    min_caml_sqrt                # !1165
    subl    $16, %ebp                    # !1165
    movl    8(%ebp), %eax                # !1166
    movsd    0(%eax), %xmm1              # !1166
    divsd    %xmm0, %xmm1                # !1166
    movsd    %xmm1, 0(%eax)              # !1166
    movsd    8(%eax), %xmm1              # !1167
    divsd    %xmm0, %xmm1                # !1167
    movsd    %xmm1, 8(%eax)              # !1167
    movsd    16(%eax), %xmm1             # !1168
    divsd    %xmm0, %xmm1                # !1168
    movsd    %xmm1, 16(%eax)             # !1168
    movl    $min_caml_viewpoint, %eax    # !1170
    movl    $min_caml_view, %ebx         # !1170
    movsd    0(%ebx), %xmm0              # !1170
    movsd    %xmm0, 0(%eax)              # !1170
    movsd    8(%ebx), %xmm0              # !1171
    movsd    %xmm0, 8(%eax)              # !1171
    movsd    16(%ebx), %xmm0             # !1172
    movsd    %xmm0, 16(%eax)             # !1172
    movl    $min_caml_rgb, %eax          # !1175
    movl    $l.4442, %ebx                # !1175
    movsd    0(%ebx), %xmm0              # !1175
    movsd    %xmm0, 0(%eax)              # !1175
    movsd    %xmm0, 8(%eax)              # !1176
    movsd    %xmm0, 16(%eax)             # !1177
    movl    $l.4444, %eax                # !1180
    movsd    0(%eax), %xmm0              # !1180
    movl    4(%ebp), %eax                # !1180
    addl    $16, %ebp                    # !1180
    call    raytracing.2128              # !1180
    subl    $16, %ebp                    # !1180
    addl    $16, %ebp                    # !1183
    call    write_rgb.2131               # !1183
    subl    $16, %ebp                    # !1183
    movl    0(%ebp), %eax                # !1186
    addl    $1, %eax                     # !1186
    jmp    scan_point.2135               # !1186
scan_line.2137:                          # !1191
    movl    $min_caml_size, %ebx         # !1193
    movl    $0, %ecx                     # !1193
    movl    0(%ebx), %ebx                # !1193
    cmpl    %eax, %ebx                   # !1193
    jg    jle_else.5802                  # !1193
    ret                                  # !1209
jle_else.5802:                           # !1193
    movl    $min_caml_scan_sscany, %ebx  # !1196
    movl    $min_caml_scan_offset, %edx  # !1197
    movsd    0(%edx), %xmm0              # !1197
    movl    $l.4444, %edx                # !1197
    movsd    0(%edx), %xmm1              # !1197
    subsd    %xmm1, %xmm0                # !1197
    movl    %eax, 0(%ebp)                # !1197
    movl    %ecx, 4(%ebp)                # !1197
    movl    %ebx, 8(%ebp)                # !1197
    movsd    %xmm0, 16(%ebp)             # !1197
    addl    $24, %ebp                    # !1197
    call    min_caml_float_of_int        # !1197
    subl    $24, %ebp                    # !1197
    movsd    16(%ebp), %xmm1             # !1197
    subsd    %xmm0, %xmm1                # !1197
    movl    $min_caml_scan_d, %eax       # !1198
    movsd    0(%eax), %xmm0              # !1198
    mulsd    %xmm1, %xmm0                # !1198
    movl    8(%ebp), %eax                # !1196
    movsd    %xmm0, 0(%eax)              # !1196
    movl    $min_caml_scan_met1, %ebx    # !1200
    movsd    0(%eax), %xmm0              # !1200
    movl    %ebx, 24(%ebp)               # !1200
    addl    $32, %ebp                    # !1200
    call    fsqr.1980                    # !1200
    subl    $32, %ebp                    # !1200
    movl    $l.4541, %eax                # !1200
    movsd    0(%eax), %xmm1              # !1200
    addsd    %xmm1, %xmm0                # !1200
    movl    24(%ebp), %eax               # !1200
    movsd    %xmm0, 0(%eax)              # !1200
    movl    8(%ebp), %eax                # !1202
    movsd    0(%eax), %xmm0              # !1202
    movl    $min_caml_sin_v, %eax        # !1202
    movsd    0(%eax), %xmm1              # !1202
    mulsd    %xmm1, %xmm0                # !1202
    movl    $min_caml_wscan, %ebx        # !1203
    movsd    8(%eax), %xmm1              # !1203
    mulsd    %xmm0, %xmm1                # !1203
    movl    $min_caml_vp, %eax           # !1203
    movsd    0(%eax), %xmm2              # !1203
    subsd    %xmm2, %xmm1                # !1203
    movsd    %xmm1, 0(%ebx)              # !1203
    movl    $min_caml_cos_v, %ecx        # !1204
    movsd    8(%ecx), %xmm1              # !1204
    mulsd    %xmm0, %xmm1                # !1204
    movsd    16(%eax), %xmm0             # !1204
    subsd    %xmm0, %xmm1                # !1204
    movsd    %xmm1, 16(%ebx)             # !1204
    movl    4(%ebp), %eax                # !1205
    addl    $32, %ebp                    # !1205
    call    scan_point.2135              # !1205
    subl    $32, %ebp                    # !1205
    movl    0(%ebp), %eax                # !1206
    addl    $1, %eax                     # !1206
    jmp    scan_line.2137                # !1206
scan_start.2139:                         # !1213
    call    write_ppm_header.2133        # !1216
    movl    $min_caml_size, %eax         # !1217
    movl    $0, %ebx                     # !1217
    movl    0(%eax), %eax                # !1217
    movl    %ebx, 0(%ebp)                # !1217
    addl    $8, %ebp                     # !1217
    call    min_caml_float_of_int        # !1217
    subl    $8, %ebp                     # !1217
    movl    $min_caml_scan_d, %eax       # !1218
    movl    $l.4543, %ebx                # !1218
    movsd    0(%ebx), %xmm1              # !1218
    divsd    %xmm0, %xmm1                # !1218
    movsd    %xmm1, 0(%eax)              # !1218
    movl    $min_caml_scan_offset, %eax  # !1219
    movl    $l.4440, %ebx                # !1219
    movsd    0(%ebx), %xmm1              # !1219
    divsd    %xmm1, %xmm0                # !1219
    movsd    %xmm0, 0(%eax)              # !1219
    movl    0(%ebp), %eax                # !1220
    jmp    scan_line.2137                # !1220
rt.2141:                                 # !1226
    movl    $min_caml_size, %edx         # !1229
    movl    %eax, 0(%edx)                # !1229
    movl    %ebx, 4(%edx)                # !1230
    movl    $min_caml_dbg, %eax          # !1231
    movl    %ecx, 0(%eax)                # !1231
    call    read_parameter.2043          # !1232
    jmp    scan_start.2139               # !1233
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
    movl    $768, %eax                   # !1237
    movl    $0, %ecx                     # !1237
    movl    %eax, %ebx                   # !1237
    call    rt.2141                      # !1237
    popl    %ebp
    popl    %edi
    popl    %esi
    popl    %edx
    popl    %ecx
    popl    %ebx
    popl    %eax
    ret
