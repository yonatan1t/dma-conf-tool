[#ftl]
[#if srvcmx_isTargetedFw_inDTS("LINUX")]
# SPDX-License-Identifier: GPL-2.0-only
[#if mx_socDtRPN?starts_with("stm32mp2")]
dtb-$(TARGET_ARM64) += \
[#else]
dtb-$(TARGET_ARM32) += \
[/#if]
${mx_socRPN}-${mx_projectName}-mx.dtb
[/#if]
[#if srvcmx_isTargetedFw_inDTS("U-BOOT")|| srvcmx_isTargetedFw_inDTS("EL")]
# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

dtb-$(CONFIG_${mx_socDtRPN?upper_case}X) += \
	${mx_socRPN}-${mx_projectName}-mx.dtb

#include $(srctree)/scripts/Makefile.dts

targets += $(dtb-y)

# Add any required device tree compiler flags here
DTC_FLAGS += -a 0x8

PHONY += dtbs
dtbs: $(addprefix $(obj)/, $(dtb-y))
	@:

clean-files := *.dtb *.dtbo *_HS
[/#if]
[#if srvcmx_isTargetedFw_inDTS("ExtMemLoader")]
ok
[/#if]