/*
 * Check to see if an object reference is an instance of a class.
 *
 * Most common situation is a non-null object, being compared against
 * an already-resolved class.
 */
    /* instance-of vA, vB, class@CCCC */
    EXPORT_PC
    movzwl  2(rPC), %eax                    # eax <- BBBB
    movl    %eax, OUT_ARG0(%esp)
    movl    rINST, %eax                     # eax <- BA
    sarl    $$4, %eax                       # eax <- B
    GET_VREG %ecx %eax                      # Get object
    movl    %ecx, OUT_ARG1(%esp)
    movl    OFF_FP_METHOD(rFP),%eax
    movl    %eax, OUT_ARG2(%esp)
    movl    rSELF, %ecx
    movl    %ecx, OUT_ARG3(%esp)
    call    MterpInstanceOf                 # (index, obj, method, self)
    movl    rSELF, %ecx
    REFRESH_IBASE_FROM_SELF %ecx
    cmpl    $$0, THREAD_EXCEPTION_OFFSET(%ecx)
    jnz     MterpException
    andb    $$0xf, rINSTbl                  # rINSTbl <- A
    SET_VREG %eax rINST
    ADVANCE_PC_FETCH_AND_GOTO_NEXT 2