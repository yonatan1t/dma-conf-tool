[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_azure_rtos.h
  * @author  MCD Application Team
  * @brief   app_azure_rtos application header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */


[#assign TX_ENABLED = "true"]
[#assign FX_ENABLED = "false"]
[#assign NX_ENABLED = "false"]
[#assign UX_ENABLED = "false"]
[#assign UX_HOST_ENABLED = "false"]
[#assign UX_DEVICE_ENABLED = "false"]
[#assign USBPD_DEVICE_ENABLED = "false"]
[#assign TOUCHSENSING_ENABLED = "false"]
[#assign GUI_INTERFACE_ENABLED = "false"]
[#assign STM32WPAN_ENABLED = "false"]
[#assign SECURE_MANAGER_API_ENABLED = "false"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]
	
    [#if name == "FILEX_ENABLED" && value == "true"]
      [#assign FX_ENABLED = value]
    [/#if]    
	[#if name == "NETXDUO_ENABLED" && value == "true"]
      [#assign NX_ENABLED = value]
    [/#if]
	[#if name == "USBXDEVICE_ENABLED" && value == "true"]
      [#assign UX_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "USBXHOST_ENABLED" && value == "true"]
      [#assign UX_HOST_ENABLED = value]
    [/#if]
	[#if name == "USBX_ENABLED" && value == "true"]
      [#assign UX_ENABLED = value]
    [/#if]
	[#if name == "USBPD_ENABLED" && value == "true"]
      [#assign USBPD_DEVICE_ENABLED = value]
    [/#if]
	[#if name == "TSC_ENABLED" && value == "true"]
      [#assign TOUCHSENSING_ENABLED = value]
    [/#if]
    [#if name == "GUI_INTERFACE_ENABLED" && value == "true"]
      [#assign GUI_INTERFACE_ENABLED = value]
    [/#if]
    [#if name == "WPAN_ENABLED" && value == "true"]
      [#assign STM32WPAN_ENABLED = value]
    [/#if]
	[#if name == "SECURE_MANAGER_API_ENABLED" && value == "true"]
      [#assign SECURE_MANAGER_API_ENABLED = value]
    [/#if]

    [#if name == "NetX_TX_FSBL"]
      [#assign NetX_TX_FSBL = value]
    [/#if]
    [#if name == "NetX_TX_APPS"]
      [#assign NetX_TX_APPS = value]
    [/#if]
    [#if name == "NetX_TX_APPNS"]
      [#assign NetX_TX_APPNS = value]
    [/#if]
    [#if name == "NetX_TX_Appli"]
      [#assign NetX_TX_Appli = value]
    [/#if]
	[#if name == "FileX_TX_FSBL"]
        [#assign FileX_TX_FSBL = value]
    [/#if]
    [#if name == "FileX_TX_APPS"]
       [#assign FileX_TX_APPS = value]
    [/#if]
    [#if name == "FileX_TX_APPNS"]
       [#assign FileX_TX_APPNS = value]
    [/#if]
    [#if name == "FileX_TX_Appli"]
       [#assign FileX_TX_Appli = value]
    [/#if]
    [/#list]
[/#if]
[/#list]
[/#compress]
[#assign familyName=FamilyName?lower_case]
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef APP_AZURE_RTOS_H
#define APP_AZURE_RTOS_H
#ifdef __cplusplus
[#if (familyName?starts_with("stm32u3")||familyName?starts_with("stm32u5")||familyName?starts_with("stm32h5")||familyName?starts_with("stm32c0")||familyName?starts_with("stm32wba"))]
extern "C" {
[#else]
 extern "C" {
[/#if]
#endif

/* Includes ------------------------------------------------------------------*/

[#if TX_ENABLED == "true"]
#include "app_threadx.h"
[/#if]
#include "${FamilyName?lower_case}xx_hal.h"
#include "app_azure_rtos_config.h"
[#if (FX_ENABLED == "true" && ((!FamilyName?lower_case?starts_with("stm32n6")) |((FamilyName?lower_case?starts_with("stm32n6") && contextFolder?? && (((contextFolder=="FSBL/" && FileX_TX_FSBL=="true") | (contextFolder=="AppliSecure/" && FileX_TX_APPS=="true") | (contextFolder=="AppliNonSecure/" && FileX_TX_APPNS=="true") | (contextFolder=="Appli/" && FileX_TX_Appli=="true")))))))]
#include "app_filex.h"
[/#if]

[#if (NX_ENABLED == "true" && ((!FamilyName?lower_case?starts_with("stm32n6")) |((FamilyName?lower_case?starts_with("stm32n6") && contextFolder?? && (((contextFolder=="FSBL/" && NetX_TX_FSBL=="true") | (contextFolder=="AppliSecure/" && NetX_TX_APPS=="true") | (contextFolder=="AppliNonSecure/" && NetX_TX_APPNS=="true") | (contextFolder=="Appli/" && NetX_TX_Appli=="true")))))))]
#include "app_netxduo.h"
[/#if]
[#if !FamilyName?lower_case?starts_with("stm32n6") && !FamilyName?lower_case?starts_with("stm32wba")]
[#if UX_HOST_ENABLED == "true"]
#include "app_usbx_host.h"
[/#if]
[#if UX_DEVICE_ENABLED == "true"]
#include "app_usbx_device.h"
[/#if]
[/#if]
[#if FamilyName?lower_case?starts_with("stm32n6") || FamilyName?lower_case?starts_with("stm32wba")]
[#if UX_ENABLED == "true"]
#include "app_usbx.h"
[/#if]
[/#if]
[#if USBPD_DEVICE_ENABLED == "true" && USBPD??]
#include "usbpd.h"
[/#if]
[#if TOUCHSENSING_ENABLED == "true"]
#include "touchsensing.h"
[/#if]
[#if GUI_INTERFACE_ENABLED == "true" && GUI_INTERFACE??]
#include "gui_api.h"
[/#if]
[#if STM32WPAN_ENABLED == "true"]
#include "app_entry.h"
[/#if]
[#if SECURE_MANAGER_API_ENABLED == "true"]
#include "secure_manager_api.h"
[/#if]

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

#ifdef __cplusplus
}
#endif
#endif /* APP_AZURE_RTOS_H */