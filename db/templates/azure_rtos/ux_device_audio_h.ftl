[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_audio.h
  * @author  MCD Application Team
  * @brief   USBX Device Audio applicative header file
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __UX_DEVICE_AUDIO_H__
#define __UX_DEVICE_AUDIO_H__

#ifdef __cplusplus
extern "C" {
#endif

[#assign UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value = "false"]
[#assign UX_DEVICE_AUDIO_RECORDING_ENABLED_Value = "false"]
[#compress]
[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "REG_UX_DEVICE_AUDIO_RECORDING"]
      [#assign REG_UX_DEVICE_AUDIO_RECORDING_value = value]
    [/#if]
    [#if name == "REG_UX_DEVICE_AUDIO_PLAYBACK"]
      [#assign REG_UX_DEVICE_AUDIO_PLAYBACK_value = value]
    [/#if]
    [#if name == "UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT"]
      [#assign UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value = value]
    [/#if]
	[#if name == "UX_DEVICE_AUDIO_PLAYBACK"]
      [#assign UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value = value]
    [/#if]
	[#if name == "UX_DEVICE_AUDIO_RECORDING"]
      [#assign UX_DEVICE_AUDIO_RECORDING_ENABLED_Value = value]
    [/#if]
   [/#list]
[/#if]
[/#list]
[/#compress]
/* Includes ------------------------------------------------------------------*/
#include "ux_api.h"
#include "ux_device_class_audio.h"
#include "ux_device_class_audio20.h"
[#if UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1"]
#include "ux_device_audio_play.h"
[/#if]
[#if UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1"]
#include "ux_device_audio_record.h"
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
[#if (REG_UX_DEVICE_AUDIO_PLAYBACK_value == "1" && UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1") ||
     (REG_UX_DEVICE_AUDIO_RECORDING_value == "1" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1")]
VOID USBD_AUDIO_Activate(VOID *audio_instance);
VOID USBD_AUDIO_Deactivate(VOID *audio_instance);
UINT USBD_AUDIO_ControlProcess(UX_DEVICE_CLASS_AUDIO *audio_instance,
                               UX_SLAVE_TRANSFER *transfer);
VOID USBD_AUDIO_SetControlValues(VOID);
[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
ULONG USBD_AUDIO_InterruptStatusSize(VOID);
ULONG USBD_AUDIO_InterruptStatusQueueSize(VOID);
#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[/#if]
[/#if]

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if (REG_UX_DEVICE_AUDIO_PLAYBACK_value == "1" && UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1") ||
     (REG_UX_DEVICE_AUDIO_RECORDING_value == "1" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1")]

[#if (UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "0") ||
     (UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "0" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1")]
#ifndef USBD_AUDIO_STREAM_NMNBER
#define USBD_AUDIO_STREAM_NMNBER  1
#endif
[#elseif UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1"]
#ifndef USBD_AUDIO_STREAM_NMNBER
#define USBD_AUDIO_STREAM_NMNBER  2
#endif
[/#if]

[/#if]
/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif  /* __UX_DEVICE_AUDIO_H__ */
