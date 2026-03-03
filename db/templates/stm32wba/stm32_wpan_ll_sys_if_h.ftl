[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ll_sys_if.h
  * @author  MCD Application Team
  * @brief   Header file for initiating system
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LL_SYS_IF_H
#define LL_SYS_IF_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stdint.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "tx_api.h"
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
#include "cmsis_os2.h"
[/#if]
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
#define DRIFT_TIME_DEFAULT                      (13)
#define DRIFT_TIME_EXTRA_LSI2                   (9)
#define DRIFT_TIME_EXTRA_GCC_DEBUG              (6)

#define EXEC_TIME_DEFAULT                       (24)
#define EXEC_TIME_EXTRA_LSI2                    (3)
#define EXEC_TIME_EXTRA_GCC_DEBUG               (4)

#define SCHDL_TIME_DEFAULT                      (20)
[/#if]
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* External variables --------------------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled")]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* LINK_LAYER_TASK related resources */
extern TX_MUTEX           LinkLayerMutex;

[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
extern osMutexId_t LinkLayerMutex;

[/#if]
[/#if]
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
void ll_sys_bg_temperature_measurement(void);
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled")  || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
#if defined(STM32WBA52xx) || defined(STM32WBA54xx) || defined(STM32WBA55xx) || defined(STM32WBA65xx)
/**
 * @brief Apply CTE degradation settings
 * @param  None
 * @retval None
 */
void ll_sys_apply_cte_settings(void);
#endif /* defined(STM32WBA52xx) || defined(STM32WBA54xx) || defined(STM32WBA55xx) || defined(STM32WBA65xx) */
#if (CFG_LPM_STANDBY_SUPPORTED == 0)
void ll_sys_get_ble_profile_statistics(uint32_t* exec_time, uint32_t* drift_time, uint32_t* average_drift_time, uint8_t reset);
#endif 
[/#if]

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
void ll_sys_set_rtl_polling_time(uint8_t rtl_polling_time);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

#ifdef __cplusplus
}
#endif

#endif /*LL_SYS_IF_H */
