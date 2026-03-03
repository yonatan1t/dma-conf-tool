[#ftl]
# SPDX-License-Identifier: BSD-2-Clause

flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case} = ${mx_socRPN}-${mx_projectName}-mx.dts
flavorlist-${mx_socDtRPN?substring(5,9)?upper_case} += $(flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case})
[#if mx_tdcidContext?matches("M[0-9][0-9].*") && srvcmx_isTargetedFw_inDTS("OP-TEE")]
flavorlist-M33-TDCID += $(flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case})
[/#if]
[#if mx_socDtRPN?starts_with("stm32mp1")]
 [#assign package = mx_socPtCPN?substring(10,11)?upper_case]
[#if package == "A" ||  package == "D"]
flavorlist-no_cryp += $(flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case})
[/#if]
[#if mx_ddrConfigs["general"]??  && mx_ddrConfigs["general"]["ddrSize"]??]
CFG_DRAM_SIZE = ${mx_ddrConfigs["general"]["ddrSize"]}
[/#if]
[/#if]
