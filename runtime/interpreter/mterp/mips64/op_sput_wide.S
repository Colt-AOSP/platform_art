    /*
     * SPUT_WIDE handler wrapper.
     *
     */
    /* sput-wide vAA, field//BBBB */
    .extern MterpSet64Static
    EXPORT_PC
    lhu     a0, 2(rPC)                  # a0 <- field ref BBBB
    srl     a1, rINST, 8                # a2 <- AA
    dlsa    a1, a1, rFP, 2
    ld      a2, OFF_FP_METHOD(rFP)
    move    a3, rSELF
    PREFETCH_INST 2                     # Get next inst, but don't advance rPC
    jal     MterpSet64Static
    bnezc   v0, MterpException          # 0 on success, -1 on failure
    ADVANCE 2                           # Past exception point - now advance rPC
    GET_INST_OPCODE v0                  # extract opcode from rINST
    GOTO_OPCODE v0                      # jump to next instruction
