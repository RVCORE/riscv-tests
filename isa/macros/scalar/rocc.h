#ifndef ROCC_H
#define ROCC_H

#define STR(x) #x
#define CAT(A, B) A##B

#define EXTRACT(a, size, offset) (((~(~0 << size) << offset) & a) >> offset)

#define CUSTOMX_OPCODE(x) CUSTOM_ ## x

#define CUSTOM_0 0b0001011
#define CUSTOM_1 0b0101011
#define CUSTOM_2 0b1011011
#define CUSTOM_3 0b1111011


#define CUSTOMX(X, rd, vbits, rs1, rs2, funct) \
  (CUSTOMX_OPCODE(X) | ((rd) << 7) | ((vbits) << (7+5)) | ((rs1) << (7+5+3)) | ((rs2) << (7+5+3+5)) | ((EXTRACT(funct, 7, 0)) << (7+5+3+5+5)))

#define ROCC_INSTRUCTION_RAW_R_R_R(x, rd, rs1, rs2, func7) \
  CUSTOMX(x, rd, 7,rs1, rs2, func7) 

#define ROCC_INSTRUCTION_RAW_0_R_R(x, rs1, rs2, func7) \
  CUSTOMX(x, 0, 3, rs1, rs2, func7)

#define ROCC_INSTRUCTION_RAW_R_R_0(x, rd, rs1, func7) \
  CUSTOMX(x, rd, 6, rs1, 0, func7)

#endif