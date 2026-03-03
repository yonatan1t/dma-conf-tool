[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    peripheral_init.h
  * @author  MCD Application Team
  * @brief   Header for peripheral init module
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#assign myHash = {definition.name:definition.value} + myHash]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

#ifndef PERIPHERAL_INIT_H
#define PERIPHERAL_INIT_H

#if (CFG_LPM_STANDBY_SUPPORTED == 1)
/**
  * @brief  Configure the SoC peripherals at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_PeripheralInit(void);
#endif
[#if (myHash["HW_STOP2_SUPPORTED"]?number == 1)]
#if (CFG_LPM_STOP2_SUPPORTED == 1)
/**
  * @brief  Configure the SoC peripherals at Stop2 mode exit.
  * @param  None
  * @retval None
  */
void MX_Stop2Exit_PeripheralInit(void);
#endif

[/#if]

#endif /* PERIPHERAL_INIT_H */
