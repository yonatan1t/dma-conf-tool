[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    host_stack_if.h
  * @author  MCD Application Team
  * @brief : This file contains the interface for the stack tasks
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

#ifndef HOST_STACK_IF_H
#define HOST_STACK_IF_H

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
[#if (myHash["FREERTOS_STATUS"]?number == 1) || (myHash["THREADX_STATUS"]?number == 1)]
#include "ll_sys_if.h"
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
/* Halt if any aci/hci functions call is made under ISR context, for debug purpose. */
#define BLE_WRAP_PREPROC() do{ \
                             if( __get_IPSR() != 0 )while(1); \
                           }while(0)

/* Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC() do{ \
                            BleStackCB_Process(); \
                          }while(0)
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* Halt if any aci/hci functions call is made under ISR context, for debug purpose. */
/* Get Link Layer Mutex before calling any aci/hci functions */
#define BLE_WRAP_PREPROC() do{ \
                             if( __get_IPSR() != 0 )while(1); \
                             tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER); \
                           }while(0)

/* Put Link Layer Mutex */
/* Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC() do{ \
                              tx_mutex_put(&LinkLayerMutex); \
                              BleStackCB_Process(); \
                            }while(0)
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Halt if any aci/hci functions call is made under ISR context, for debug purpose. */
/* Aquire Link Layer Mutex before calling any aci/hci functions */
#define BLE_WRAP_PREPROC() do{ \
                             if( __get_IPSR() != 0 )while(1); \
                             osMutexAcquire(LinkLayerMutex, osWaitForever); \
                           }while(0)

/* Release Link Layer Mutex */
/* Trigger BLE Host stack process after calling any aci/hci functions */
#define BLE_WRAP_POSTPROC() do{ \
                              osMutexRelease(LinkLayerMutex); \
                              BleStackCB_Process(); \
                            }while(0)
[/#if]

/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void BleStackCB_Process(void);
[/#if]
/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 2 */

/* USER CODE END 2 */

#endif /* HOST_STACK_IF_H */
