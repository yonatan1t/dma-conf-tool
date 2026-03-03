[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_wMBus.h
  * @author  MCD Application Team
  * @brief   Header of application of the wMBus Middleware
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */
[#assign myHash = {}]
[#list SWIPdatas as SWIP]
    [#if SWIP.defines??]
        [#list SWIP.defines as definition]
            [#if ("${definition.value}"=="valueNotSetted")]
              [#assign myHash = {definition.name:0} + myHash]
            [#else]
              [#assign myHash = {definition.name:definition.value} + myHash]
            [/#if]
        [/#list]
    [/#if]
[/#list]
[#--
Key & Value:
[#list myHash?keys as key]
Key: ${key}; Value: ${myHash[key]}
[/#list]
--]

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __APP_WMBUS_H__
#define __APP_WMBUS_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator") || (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
#include "stm32wl3_wMBus_DataLink.h"
#include "stm32wl3_wMBus_DataLink_timer.h"
[/#if]
[#if !HALCompliant??]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
#include "stm32wl3_wMBus_Phy_radio.h"
[/#if]
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
extern VTIMER_HandleType_t timerHandle;
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported Functions Prototypes ---------------------------------------------*/
/**
 * @brief  Init wMBus Application
 */
void MX_wMBus_Init(void);

void MX_wMBus_Process(void);
[#if (myHash["CFG_LPM_SUPPORTED"] == "1")]
void MX_wMBus_Idle(void);

PowerSaveLevels HAL_MRSUBG_TIMER_PowerSaveLevelCheck(void);

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
void wMBus_RadioTimerConfig(void);
void TimeoutCallback(void *timerHandle);
[/#if]
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*__APP_WMBUS_H__*/
