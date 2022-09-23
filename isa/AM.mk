XLEN ?= 64

src_dir := .

ifeq ($(XLEN),64)
include $(src_dir)/rv64ui/Makefrag
include $(src_dir)/rv64uc/Makefrag
include $(src_dir)/rv64um/Makefrag
include $(src_dir)/rv64ua/Makefrag
include $(src_dir)/rv64uf/Makefrag
include $(src_dir)/rv64ud/Makefrag
include $(src_dir)/rv64uzfh/Makefrag
include $(src_dir)/rv64si/Makefrag
include $(src_dir)/rv64ssvnapot/Makefrag
include $(src_dir)/rv64mi/Makefrag
include $(src_dir)/rv64rocc/Makefrag
endif
include $(src_dir)/rv32ui/Makefrag
include $(src_dir)/rv32uc/Makefrag
include $(src_dir)/rv32um/Makefrag
include $(src_dir)/rv32ua/Makefrag
include $(src_dir)/rv32uf/Makefrag
include $(src_dir)/rv32ud/Makefrag
include $(src_dir)/rv32uzfh/Makefrag
include $(src_dir)/rv32si/Makefrag
include $(src_dir)/rv32mi/Makefrag

SV ?= Sv39

define compile_am

ALL += $$($(1)_sc_tests)
ifdef $(1)_p_tests
Makefiles_$(1)_p = $(addprefix Makefile-$(1)-p-, $($(1)_sc_tests))
endif

ifdef $(1)_v_tests
Makefiles_$(1)_v = $(addprefix Makefile-$(1)-v-, $($(1)_sc_tests))
endif

$$(Makefiles_$(1)_p): Makefile-$(1)-p-%: $(1)/%.S
	@/bin/echo -e "NAME = $(1)-$$*-p\nSRCS = $$<\nEXTRA=p\nLIBS += klib\nCOMMON_FLAGS += -DRVTEST_AM\nINCLUDES += -I$(shell pwd)/../env/p -I$(shell pwd)/macros/scalar\ninclude $${AM_HOME}/Makefile.app" > $$@
	-@make -s -f $$@ ARCH=$$(ARCH)
	-@rm -f Makefile-$(1)-p-$$*

$$(Makefiles_$(1)_v): Makefile-$(1)-v-%: $(1)/%.S
	@/bin/echo -e "NAME = $(1)-$$*-v\nSRCS = $$< $(src_dir)/../env/v/entry.S $(src_dir)/../env/v/vm.c $(src_dir)/../env/v/string.c\nEXTRA=v\nLIBS += klib\nINCLUDES += -I$(shell pwd)/../env/v \
		-I$(shell pwd)/macros/scalar\nCOMMON_FLAGS += -DRVTEST_AM -D$(SV) -DENTROPY=0x$$(shell echo \$$@ | md5sum | cut -c 1-7)\ninclude $${AM_HOME}/Makefile.app" > $$@
	-@make -s -f $$@ ARCH=$$(ARCH)
	-@rm -f Makefile-$(1)-v-$$* 

MakeTargets += $$(Makefiles_$(1)_p) $$(Makefiles_$(1)_v)

endef

# $(eval $(call compile_am,rv64ui))
# $(eval $(call compile_am,rv64uc))
# $(eval $(call compile_am,rv64um))
# $(eval $(call compile_am,rv64ua))
# $(eval $(call compile_am,rv64uf))
# $(eval $(call compile_am,rv64ud))
# $(eval $(call compile_am,rv64uzfh))
# $(eval $(call compile_am,rv64si))
# $(eval $(call compile_am,rv64ssvnapot))
# $(eval $(call compile_am,rv64mi))
$(eval $(call compile_am,rv64rocc))

all: $(MakeTargets)
	@echo "Compile programs such as:" $(ALL)

default: all ;

clean:
	rm -rf Makefile-rv* build/

.PHONY: all clean $(ALL)