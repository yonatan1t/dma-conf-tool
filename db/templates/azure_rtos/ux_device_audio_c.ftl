[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_audio.c
  * @author  MCD Application Team
  * @brief   USBX Device Audio applicative source file
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

/* Includes ------------------------------------------------------------------*/
#include "ux_device_audio.h"
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

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */
[#if (REG_UX_DEVICE_AUDIO_PLAYBACK_value == "1" && UX_DEVICE_AUDIO_PLAYBACK_ENABLED_Value == "1") ||
     (REG_UX_DEVICE_AUDIO_RECORDING_value == "1" && UX_DEVICE_AUDIO_RECORDING_ENABLED_Value == "1")]
/**
  * @brief  USBD_AUDIO_Activate
  *         This function is called when insertion of a Audio device.
  * @param  audio_instance: Pointer to the audio class instance.
  * @retval none
  */
VOID USBD_AUDIO_Activate(VOID *audio_instance)
{
  /* USER CODE BEGIN USBD_AUDIO_Activate */
  UX_PARAMETER_NOT_USED(audio_instance);
  /* USER CODE END USBD_AUDIO_Activate */

  return;
}

/**
  * @brief  USBD_AUDIO_Deactivate
  *         This function is called when extraction of a Audio device.
  * @param  audio_instance: Pointer to the audio class instance.
  * @retval none
  */
VOID USBD_AUDIO_Deactivate(VOID *audio_instance)
{
  /* USER CODE BEGIN USBD_AUDIO_Deactivate */
  UX_PARAMETER_NOT_USED(audio_instance);
  /* USER CODE END USBD_AUDIO_Deactivate */

  return;
}

/**
  * @brief  USBD_AUDIO_ControlProcess
  *         This function is invoked to manage the UAC class requests.
  * @param  audio_instance: Pointer to Audio class stream instance.
  * @param  transfer: Pointer to the transfer request.
  * @retval status
  */
UINT USBD_AUDIO_ControlProcess(UX_DEVICE_CLASS_AUDIO *audio_instance,
                               UX_SLAVE_TRANSFER *transfer)
{
  UINT status  = UX_SUCCESS;

  /* USER CODE BEGIN USBD_AUDIO_ControlProcess */
  UX_PARAMETER_NOT_USED(audio_instance);
  UX_PARAMETER_NOT_USED(transfer);
  /* USER CODE END USBD_AUDIO_ControlProcess */

  return status;
}

/**
  * @brief  USBD_AUDIO_SetControlValues
  *         This function is invoked to Set audio control values.
  * @param  none
  * @retval none
  */
VOID USBD_AUDIO_SetControlValues(VOID)
{
  /* USER CODE BEGIN USBD_AUDIO_SetControlValues */

  /* USER CODE END USBD_AUDIO_SetControlValues */

  return;
}

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
/**
  * @brief  USBD_AUDIO_InterruptStatusSize
  *         This function is invoked to Set interrupt status size.
  * @param  none
  * @retval none
  */
ULONG USBD_AUDIO_InterruptStatusSize(VOID)
{
  ULONG interrupt_status_size = 0U;

  /* USER CODE BEGIN USBD_AUDIO_InterruptStatusSize */

  /* USER CODE END USBD_AUDIO_InterruptStatusSize */

  return interrupt_status_size;
}

/**
  * @brief  USBD_AUDIO_InterruptStatusQueueSize
  *         This function is invoked to Set interrupt status queue size.
  * @param  none
  * @retval none
  */
ULONG USBD_AUDIO_InterruptStatusQueueSize(VOID)
{
  ULONG interrupt_queue_size = 0U;

  /* USER CODE BEGIN USBD_AUDIO_InterruptStatusQueueSize */

  /* USER CODE END USBD_AUDIO_InterruptStatusQueueSize */

  return interrupt_queue_size;
}

#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
