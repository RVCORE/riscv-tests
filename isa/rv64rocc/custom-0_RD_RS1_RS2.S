#include "riscv_test.h"
#include "test_macros.h"

RVTEST_WITH_ROCC
RVTEST_CODE_BEGIN

  #-------------------------------------------------------------
  # ROCC TEST
  #-------------------------------------------------------------
  #                    test_id
  #                       | op_constumX
  #                       |  | op_funct
  #                       |  |  |  check_constumX
  #                       |  |  |  |  check_funct
  #                       |  |  |  |  |
  #                       |  |  |  |  | correct_result
  #                       |  |  |  |  |    |          op1         op2
  #                       |  |  |  |  |    |           |           |
  TEST_ROCC_RX_RS1_RS2_OP(2, 0, 0, 0, 3, 0x00000001, 0x00000001, 0x00000001);

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END