
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

 / {
[@DTBindedDtsElmtDMsList_print  pParentElmt="" pElmtsList=srvcmx_getElmtsMatchingBindedHwName(mxDtDM.dts_bindedElmtsList, "resmemories") pDtLevel=1 pOrdering=true/]
[#if srvcmx_isTargetedFw_inDTS("EL")]
    reserved-memory {
		#address-cells = <2>;
		#size-cells = <2>;
		ranges;

		/* USER CODE BEGIN reserved-memory */
		/*Applicative memory mapping can be defined in this section deduced from OP-TEE one*/
		/* USER CODE END reserved-memory */
	};
[/#if]
};