[#ftl]
[#if mx_socDtRPN?starts_with("stm32mp2") ]
// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
[#else]
// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-3-Clause)
[/#if]
/*
 * Copyright (C) ${year}, STMicroelectronics - All Rights Reserved
 * Author: STM32CubeMX code generation for STMicroelectronics.
 */

/* For more information on Device Tree configuration, please refer to
 * https://wiki.st.com/stm32mpu/wiki/Category:Device_tree_configuration
 */
[#if mx_tdcidContext?matches("M[0-9][0-9].*") && srvcmx_isTargetedFw_inDTS("EL")]
	/* USER CODE BEGIN addons */
	/* USER CODE END addons */
[/#if]

[#-- Clock Tree configuration (rcc node)--]
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "clocks-rcc") pDtLevel=0 pOrdering=true/]
