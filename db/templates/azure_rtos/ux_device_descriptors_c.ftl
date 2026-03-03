[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ux_device_descriptors.c
  * @author  MCD Application Team
  * @brief   USBX Device descriptor header file
  ******************************************************************************
 [@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

[#assign usbd_builder_enabled = "0"]
[#assign UX_DEVICE_HID_CORE_ENABLED_Value = "false"]
[#assign UX_DEVICE_HID_MOUSE_ENABLED_Value = "false"]
[#assign UX_DEVICE_HID_KEYBOARD_ENABLED_Value = "false"]
[#assign UX_DEVICE_HID_CUSTOM_ENABLED_Value = "false"]
[#assign UX_DEVICE_STORAGE_ENABLED_Value = "false"]
[#assign UX_DEVICE_CDC_ACM_ENABLED_Value = "false"]
[#assign UX_DEVICE_CDC_ECM_ENABLED_Value = "false"]
[#assign UX_DEVICE_DFU_ENABLED_Value = "false"]
[#assign UX_DEVICE_VIDEO_ENABLED_Value = "false"]
[#assign UX_DEVICE_PIMA_MTP_ENABLED_Value = "false"]
[#assign UX_DEVICE_CCID_ENABLED_Value = "false"]
[#assign UX_DEVICE_PRINTER_ENABLED_Value = "false"]
[#assign UX_DEVICE_RNDIS_ENABLED_Value = "false"]
[#assign UX_DEVICE_AUDIO_CORE_ENABLED_Value = "false"]
[#assign UX_DEVICE_AUDIO_PLAY_ENABLED_Value = "false"]
[#assign UX_DEVICE_AUDIO_RECORD_ENABLED_Value = "false"]
[#assign HID_ITF_FOUNDED_Value = "false"]
[#assign AUDIO_SUBC_FOUNDED_Value = "false"]
[#compress]
[#list SWIPdatas as SWIP]
  [#if SWIP.defines??]
    [#list SWIP.defines as definition]
      [#assign value = definition.value]
      [#assign name = definition.name]
      [#if name == "UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT"]
        [#assign UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value = value]
      [/#if]
      [#if name == "UX_PIMA_WITH_MTP_SUPPORT"]
        [#assign UX_PIMA_WITH_MTP_SUPPORT_value = value]
      [/#if]
	  [#if name == "USBD_AUDIO_CLASS"]
      [#assign USBD_AUDIO_CLASS_value = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_CHANNEL_COUNT"]
      [#assign usbd_audio_play_ch_num = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_192_K"]
      [#assign usbd_audio_play_freq_192k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_96_K"]
      [#assign usbd_audio_play_freq_96k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_48_K"]
      [#assign usbd_audio_play_freq_48k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_44_1_K"]
      [#assign usbd_audio_play_freq_44_1k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_32_K"]
      [#assign usbd_audio_play_freq_32k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_16_K"]
      [#assign usbd_audio_play_freq_16k = value]
    [/#if]
    [#if name == "USBD_AUDIO_PLAY_FREQ_8_K"]
      [#assign usbd_audio_play_freq_8k = value]
    [/#if]
    [#if name == "UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT"]
      [#assign UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value = value]
    [/#if]
    [#if name == "UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT"]
      [#assign UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_CHANNEL_COUNT"]
      [#assign usbd_audio_record_ch_num = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_192_K"]
      [#assign usbd_audio_record_freq_192k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_96_K"]
      [#assign usbd_audio_record_freq_96k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_48_K"]
      [#assign usbd_audio_record_freq_48k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_44_1_K"]
      [#assign usbd_audio_record_freq_44_1k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_32_K"]
      [#assign usbd_audio_record_freq_32k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_16_K"]
      [#assign usbd_audio_record_freq_16k = value]
    [/#if]
    [#if name == "USBD_AUDIO_RECORD_FREQ_8_K"]
      [#assign usbd_audio_record_freq_8k = value]
    [/#if]
	  [#if name == "VS_FORMAT_SUBTYPE"]
        [#assign vs_format_subtype = value]
      [/#if]
      [#list SWIPdatas as SWIP]
      [#if SWIP.variables??]
      [#list SWIP.variables as define]
        [#assign def_value = define.value]
        [#assign def_name = define.name]
          [#if (def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_STORAGE") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_CDC_ACM") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_DFU") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_RNDIS") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_PIMA") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_VIDEO") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_CCID") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_PRINTER") && def_value == "1") ||
			  (def_name?contains("UX_DEVICE_AUDIO_CORE") && def_value == "1")]
            [#if name == "USBD_DEVICE_FRAMEWORK_BUILDER_ENABLED"]
              [#assign usbd_builder_enabled = value]
            [/#if]
          [/#if]
          [#if def_name?contains("UX_DEVICE_DFU") && def_value == "1"]
            [#assign UX_DEVICE_DFU_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_STORAGE") && def_value == "1"]
            [#assign UX_DEVICE_STORAGE_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_HID_CORE") && def_value == "1"]
            [#assign UX_DEVICE_HID_CORE_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]
            [#assign UX_DEVICE_HID_MOUSE_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
            [#assign UX_DEVICE_HID_KEYBOARD_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
            [#assign UX_DEVICE_HID_CUSTOM_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_CDC_ACM") && def_value == "1"]
            [#assign UX_DEVICE_CDC_ACM_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1"]
            [#assign UX_DEVICE_CDC_ECM_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_VIDEO") && def_value == "1"]
            [#assign UX_DEVICE_VIDEO_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_PIMA") && def_value == "1"]
            [#assign UX_DEVICE_PIMA_MTP_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_CCID") && def_value == "1"]
            [#assign UX_DEVICE_CCID_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_PRINTER") && def_value == "1"]
            [#assign UX_DEVICE_PRINTER_ENABLED_Value = "true"]
          [/#if]
          [#if def_name?contains("UX_DEVICE_RNDIS") && def_value == "1"]
            [#assign UX_DEVICE_RNDIS_ENABLED_Value = "true"]
          [/#if]
		  [#if def_name?contains("UX_DEVICE_AUDIO_CORE") && def_value == "1"]
		   [#assign UX_DEVICE_AUDIO_CORE_ENABLED_Value = "true"]
		  [/#if]
		  [#if def_name?contains("UX_DEVICE_AUDIO_PLAYBACK") && def_value == "1"]
		   [#assign UX_DEVICE_AUDIO_PLAY_ENABLED_Value = "true"]
		  [/#if]
		  [#if def_name?contains("UX_DEVICE_AUDIO_RECORDING") && def_value == "1"]
		   [#assign UX_DEVICE_AUDIO_RECORD_ENABLED_Value = "true"]
		  [/#if]
          [#if ((def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1") || (def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1") || (def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"))]
            [#assign HID_ITF_FOUNDED_Value = "true"]
          [/#if]
		  [#if ((def_name?contains("UX_DEVICE_AUDIO_PLAYBACK"))&& (def_value == "1")) || ((def_name?contains("UX_DEVICE_AUDIO_RECORDING"))&& (def_value == "1"))]
		   [#assign AUDIO_SUBC_FOUNDED_Value = "1"]
		  [/#if]
      [/#list]
      [/#if]
      [/#list]
    [/#list]
  [/#if]
[/#list]
[/#compress]
[#if UX_DEVICE_AUDIO_CORE_ENABLED_Value == "true" && AUDIO_SUBC_FOUNDED_Value == "false"]
  [#assign usbd_builder_enabled = "0"]
[/#if]
[#-- Only MTP is supported in PIMA Class--]
[#if UX_PIMA_WITH_MTP_SUPPORT_value == "0"]
  [#assign usbd_builder_enabled = "0"]
[/#if]

/* Includes ------------------------------------------------------------------*/
#include "ux_device_descriptors.h"

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
[#if usbd_builder_enabled == "1"]
USBD_DevClassHandleTypeDef  USBD_Device_FS, USBD_Device_HS;
[/#if]

uint8_t UserClassInstance[USBD_MAX_CLASS_INTERFACES] = {
[#if UX_DEVICE_DFU_ENABLED_Value == "true"]
  CLASS_TYPE_DFU,
[/#if]
[#if UX_DEVICE_STORAGE_ENABLED_Value == "true"]
  CLASS_TYPE_MSC,
[/#if]
[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
[#if UX_DEVICE_HID_MOUSE_ENABLED_Value == "true"]
  CLASS_TYPE_HID,
[/#if]
[#if UX_DEVICE_HID_KEYBOARD_ENABLED_Value == "true"]
  CLASS_TYPE_HID,
[/#if]
[#if UX_DEVICE_HID_CUSTOM_ENABLED_Value == "true"]
  CLASS_TYPE_HID,
[/#if]
[#elseif UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "false"]
  CLASS_TYPE_HID,
[/#if]
[#if UX_DEVICE_CDC_ACM_ENABLED_Value == "true"]
  CLASS_TYPE_CDC_ACM,
[/#if]
[#if UX_DEVICE_CDC_ECM_ENABLED_Value == "true"]
  CLASS_TYPE_CDC_ECM,
[/#if]
[#if UX_DEVICE_VIDEO_ENABLED_Value == "true"]
  CLASS_TYPE_VIDEO,
[/#if]
[#if UX_DEVICE_PIMA_MTP_ENABLED_Value == "true"]
  CLASS_TYPE_PIMA_MTP,
[/#if]
[#if UX_DEVICE_CCID_ENABLED_Value == "true"]
  CLASS_TYPE_CCID,
[/#if]
[#if UX_DEVICE_PRINTER_ENABLED_Value == "true"]
  CLASS_TYPE_PRINTER,
[/#if]
[#if UX_DEVICE_RNDIS_ENABLED_Value == "true"]
  CLASS_TYPE_RNDIS,
[/#if]
[#if UX_DEVICE_AUDIO_CORE_ENABLED_Value == "true" && USBD_AUDIO_CLASS_value == "0"]
  CLASS_TYPE_AUDIO_10,
[/#if]
[#if UX_DEVICE_AUDIO_CORE_ENABLED_Value == "true" && USBD_AUDIO_CLASS_value == "1"]
  CLASS_TYPE_AUDIO_20,
[/#if]
};

[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
uint8_t UserHIDInterface[] = {
[#if UX_DEVICE_HID_MOUSE_ENABLED_Value == "true"]
  INTERFACE_HID_MOUSE,
[/#if]
[#if UX_DEVICE_HID_KEYBOARD_ENABLED_Value == "true"]
  INTERFACE_HID_KEYBOARD,
[/#if]
[#if UX_DEVICE_HID_CUSTOM_ENABLED_Value == "true"]
  INTERFACE_HID_CUSTOM,
[/#if]
};
[/#if]

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
[#if USBD_AUDIO_CLASS_value == "0"]
ULONG USBD_AUDIO10_PLAYBACK_FREQENCIES[USBD_AUDIO_PLAY_FREQ_COUNT] = {
[#if usbd_audio_play_freq_8k == "true"]
  USBD_AUDIO_FREQ_8_K,
[/#if]
[#if usbd_audio_play_freq_16k == "true"]
  USBD_AUDIO_FREQ_16_K,
[/#if]
[#if usbd_audio_play_freq_32k == "true"]
  USBD_AUDIO_FREQ_32_K,
[/#if]
[#if usbd_audio_play_freq_44_1k == "true"]
  USBD_AUDIO_FREQ_44_1_K,
[/#if]
[#if usbd_audio_play_freq_48k == "true"]
  USBD_AUDIO_FREQ_48_K,
[/#if]
[#if usbd_audio_play_freq_96k == "true"]
  USBD_AUDIO_FREQ_96_K,
[/#if]
};
[#else]
ULONG USBD_AUDIO20_PLAYBACK_FREQENCIES[USBD_AUDIO_PLAY_FREQ_COUNT] = {
[#if usbd_audio_play_freq_192k == "true"]
  USBD_AUDIO_FREQ_192_K,
[/#if]
[#if usbd_audio_play_freq_96k == "true"]
  USBD_AUDIO_FREQ_96_K,
[/#if]
[#if usbd_audio_play_freq_48k == "true"]
  USBD_AUDIO_FREQ_48_K,
[/#if]
[#if usbd_audio_play_freq_44_1k == "true"]
  USBD_AUDIO_FREQ_44_1_K,
[/#if]
[#if usbd_audio_play_freq_32k == "true"]
  USBD_AUDIO_FREQ_32_K,
[/#if]
[#if usbd_audio_play_freq_16k == "true"]
  USBD_AUDIO_FREQ_16_K,
[/#if]
[#if usbd_audio_play_freq_8k == "true"]
  USBD_AUDIO_FREQ_8_K,
[/#if]
};
[/#if]
[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
[#if USBD_AUDIO_CLASS_value == "0"]
ULONG USBD_AUDIO10_RECORDING_FREQENCIES[USBD_AUDIO_RECORD_FREQ_COUNT] = {
[#if usbd_audio_record_freq_8k == "true"]
  USBD_AUDIO_FREQ_8_K,
[/#if]
[#if usbd_audio_record_freq_16k == "true"]
  USBD_AUDIO_FREQ_16_K,
[/#if]
[#if usbd_audio_record_freq_32k == "true"]
  USBD_AUDIO_FREQ_32_K,
[/#if]
[#if usbd_audio_record_freq_44_1k == "true"]
  USBD_AUDIO_FREQ_44_1_K,
[/#if]
[#if usbd_audio_record_freq_48k == "true"]
  USBD_AUDIO_FREQ_48_K,
[/#if]
[#if usbd_audio_record_freq_96k == "true"]
  USBD_AUDIO_FREQ_96_K,
[/#if]
};
[#else]
ULONG USBD_AUDIO20_RECORDING_FREQENCIES[USBD_AUDIO_RECORD_FREQ_COUNT] = {
[#if usbd_audio_record_freq_192k == "true"]
  USBD_AUDIO_FREQ_192_K,
[/#if]
[#if usbd_audio_record_freq_96k == "true"]
  USBD_AUDIO_FREQ_96_K,
[/#if]
[#if usbd_audio_record_freq_48k == "true"]
  USBD_AUDIO_FREQ_48_K,
[/#if]
[#if usbd_audio_record_freq_44_1k == "true"]
  USBD_AUDIO_FREQ_44_1_K,
[/#if]
[#if usbd_audio_record_freq_32k == "true"]
  USBD_AUDIO_FREQ_32_K,
[/#if]
[#if usbd_audio_record_freq_16k == "true"]
  USBD_AUDIO_FREQ_16_K,
[/#if]
[#if usbd_audio_record_freq_8k == "true"]
  USBD_AUDIO_FREQ_8_K,
[/#if]
};
[/#if]
[/#if]
[#if usbd_builder_enabled == "1"]
/* The generic device descriptor buffer that will be filled by builder
   Size of the buffer is the maximum possible device FS descriptor size. */
#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN static uint8_t DevFrameWorkDesc_FS[USBD_FRAMEWORK_MAX_DESC_SZ] __ALIGN_END = {0};

/* The generic device descriptor buffer that will be filled by builder
   Size of the buffer is the maximum possible device HS descriptor size. */
#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN static uint8_t DevFrameWorkDesc_HS[USBD_FRAMEWORK_MAX_DESC_SZ] __ALIGN_END = {0};

static uint8_t *pDevFrameWorkDesc_FS = DevFrameWorkDesc_FS;

static uint8_t *pDevFrameWorkDesc_HS = DevFrameWorkDesc_HS;
[/#if]
/* USER CODE BEGIN PV0 */

/* USER CODE END PV0 */

/* String Device Framework :
 Byte 0 and 1 : Word containing the language ID : 0x0904 for US
 Byte 2       : Byte containing the index of the descriptor
 Byte 3       : Byte containing the length of the descriptor string
*/
#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN UCHAR USBD_string_framework[USBD_STRING_FRAMEWORK_MAX_LENGTH]
__ALIGN_END = {0};

/* Multiple languages are supported on the device, to add
   a language besides English, the Unicode language code must
   be appended to the language_id_framework array and the length
   adjusted accordingly. */

#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN UCHAR USBD_language_id_framework[LANGUAGE_ID_MAX_LENGTH]
__ALIGN_END = {0};

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]
#if USBD_HID_MOUSE_ACTIVATED == 1U

#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN uint8_t USBD_HID_MOUSE_ReportDesc[]
__ALIGN_END =
{
  /* USER CODE BEGIN USBD_HID_MOUSE_ReportDesc                 */
  0x05, 0x01,        /* Usage Page (Generic Desktop Ctrls)     */
  0x09, 0x02,        /* Usage (Mouse)                          */
  0xA1, 0x01,        /* Collection (Application)               */
  0x09, 0x01,        /*   Usage (Pointer)                      */
  0xA1, 0x00,        /*   Collection (Physical)                */
  0x05, 0x09,        /*     Usage Page (Button)                */
  0x19, 0x01,        /*     Usage Minimum (0x01)               */
  0x29, 0x03,        /*     Usage Maximum (0x03)               */
  0x15, 0x00,        /*     Logical Minimum (0)                */
  0x25, 0x01,        /*     Logical Maximum (1)                */
  0x95, 0x03,        /*     Report Count (3)                   */
  0x75, 0x01,        /*     Report Size (1)                    */
  0x81, 0x02,        /*     Input (Data,Var,Abs)               */
  0x95, 0x01,        /*     Report Count (1)                   */
  0x75, 0x05,        /*     Report Size (5)                    */
  0x81, 0x01,        /*     Input (Const,Array,Abs)            */
  0x05, 0x01,        /*     Usage Page (Generic Desktop Ctrls) */
  0x09, 0x30,        /*     Usage (X)                          */
  0x09, 0x31,        /*     Usage (Y)                          */
  0x09, 0x38,        /*     Usage (Wheel)                      */
  0x15, 0x81,        /*     Logical Minimum (-127)             */
  0x25, 0x7F,        /*     Logical Maximum (127)              */
  0x75, 0x08,        /*     Report Size (8)                    */
  0x95, 0x03,        /*     Report Count (3)                   */
  0x81, 0x06,        /*     Input (Data,Var,Rel)               */
  0xC0,              /*   End Collection                       */
  0x09, 0x3C,        /*   Usage (Motion Wakeup)                */
  0x05, 0xFF,        /*   Usage Page (Reserved 0xFF)           */
  0x09, 0x01,        /*   Usage (0x01)                         */
  0x15, 0x00,        /*   Logical Minimum (0)                  */
  0x25, 0x01,        /*   Logical Maximum (1)                  */
  0x75, 0x01,        /*   Report Size (1)                      */
  0x95, 0x02,        /*   Report Count (2)                     */
  0xB1, 0x22,        /*   Feature (Data,Var,Abs,NoWrp)         */
  0x75, 0x06,        /*   Report Size (6)                      */
  0x95, 0x01,        /*   Report Count (1)                     */
  0xB1, 0x01,        /*   Feature (Const,Array,Abs,NoWrp)      */
  /* USER CODE END USBD_HID_MOUSE_ReportDesc                   */
  0xC0               /* End Collection                         */
};

#endif /* USBD_HID_MOUSE_ACTIVATED == 1U */

[/#if]
[#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
#if USBD_HID_KEYBOARD_ACTIVATED == 1U

#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN uint8_t USBD_HID_KEYBOARD_ReportDesc[]
__ALIGN_END =
{
  /* USER CODE BEGIN USBD_HID_KEYBOARD_ReportDesc             */
  0x05, 0x01,        /* Usage Page (Generic Desktop Ctrls)    */
  0x09, 0x06,        /* Usage (Keyboard)                      */
  0xa1, 0x01,        /* Collection (Application)              */
  0x05, 0x07,        /*   Usage (Keyboard)                    */
  0x19, 0xe0,        /*     Usage Minimum (LeftControl)       */
  0x29, 0xe7,        /*     Usage Maximum (0x03)              */
  0x15, 0x00,        /*     Logical Minimum (0)               */
  0x25, 0x01,        /*     Logical Maximum (1)               */
  0x75, 0x01,        /*     Report Size  (1)                  */
  0x95, 0x08,        /*     Report Count (8)                  */
  0x81, 0x02,        /*     Input (Data,Var,Abs)              */
  0x95, 0x01,        /*     Report Count (1)                  */
  0x75, 0x08,        /*     Report Size (8)                   */
  0x81, 0x03,        /*     Input (Const,Array,Abs)           */
  0x95, 0x06,        /*     Report Count (6)                  */
  0x75, 0x08,        /*     Report Size (8)                   */
  0x15, 0x00,        /*     Logical Minimum (0)               */
  0x25, 0x65,        /*     Logical Maximum (101)             */
  0x05, 0x07,        /*     Usage Page (Keyboard)             */
  0x19, 0x00,        /*     Logical Minimum (Reserved)        */
  0x29, 0x65,        /*     Logical Maximum (Keyboard)        */
  0x81, 0x00,        /*     Input (Data,Var,Abs)              */
  /* USER CODE END USBD_HID_KEYBOARD_ReportDesc               */
  0xc0               /* End Collection                        */
};

#endif /* USBD_HID_KEYBOARD_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
#if USBD_HID_CUSTOM_ACTIVATED == 1U

#if defined ( __ICCARM__ ) /* IAR Compiler */
#pragma data_alignment=4
#endif /* defined ( __ICCARM__ ) */
__ALIGN_BEGIN uint8_t USBD_CustomHID_ReportDesc[]
__ALIGN_END =
{
  /* USER CODE BEGIN USBD_CustomHID_ReportDesc */

  /* USER CODE END USBD_CustomHID_ReportDesc */
  0xc0                          /* End Collection                       */
};

#endif /* USBD_HID_CUSTOM_ACTIVATED == 1U */
[/#if]
[/#list]
[/#if]
[/#list]

/* USER CODE BEGIN PV1 */

/* USER CODE END PV1 */

/* Private function prototypes -----------------------------------------------*/
static void USBD_Desc_GetString(uint8_t *desc, uint8_t *Buffer, uint16_t *len);
static uint8_t USBD_Desc_GetLen(uint8_t *buf);

[#if usbd_builder_enabled == "1"]
static uint8_t *USBD_Device_Framework_Builder(USBD_DevClassHandleTypeDef *pdev,
                                              uint8_t *pDevFrameWorkDesc,
                                              uint8_t *UserClassInstance,
                                              uint8_t Speed);

static uint8_t USBD_FrameWork_AddToConfDesc(USBD_DevClassHandleTypeDef *pdev,
                                            uint8_t Speed,
                                            uint8_t *pCmpstConfDesc);

static uint8_t USBD_FrameWork_AddClass(USBD_DevClassHandleTypeDef *pdev,
                                       USBD_CompositeClassTypeDef class,
                                       uint8_t cfgidx, uint8_t Speed,
                                       uint8_t *pCmpstConfDesc);

static uint8_t USBD_FrameWork_FindFreeIFNbr(USBD_DevClassHandleTypeDef *pdev);

static void USBD_FrameWork_AddConfDesc(uint32_t Conf, uint32_t *pSze);

static void USBD_FrameWork_AssignEp(USBD_DevClassHandleTypeDef *pdev, uint8_t Add,
                                    uint8_t Type, uint32_t Sze);


[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
#if USBD_HID_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_HID_Desc(USBD_DevClassHandleTypeDef *pdev,
                                    uint32_t pConf, uint32_t *Sze);
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_STORAGE") && def_value == "1"]
#if USBD_MSC_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_MSCDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze);
#endif /* USBD_MSC_CLASS_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_CDC_ACM") && def_value == "1"]
#if USBD_CDC_ACM_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_CDCDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze);
#endif /* USBD_CDC_ACM_CLASS_ACTIVATED == 1U */
[/#if]
[#if def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1"]
#if USBD_CDC_ECM_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_CDCECMDesc(USBD_DevClassHandleTypeDef *pdev,
                                      uint32_t pConf, uint32_t *Sze);
#endif /* USBD_CDC_ECM_CLASS_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_RNDIS") && def_value == "1"]
#if USBD_RNDIS_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_RNDISDesc(USBD_DevClassHandleTypeDef *pdev,
                                     uint32_t pConf, uint32_t *Sze);
#endif /* USBD_RNDIS_CLASS_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_DFU") && def_value == "1"]
#if USBD_DFU_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_DFUDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze);
#endif /* USBD_DFU_CLASS_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_PIMA") && def_value == "1"]
#if USBD_PIMA_MTP_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_MTPDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze);
#endif /* USBD_PIMA_MTP_CLASS_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_VIDEO") && def_value == "1"]
#if USBD_VIDEO_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_VIDEO_Desc(USBD_DevClassHandleTypeDef *pdev,
                                      uint32_t pConf, uint32_t *Sze);
#endif /* USBD_VIDEO_CLASS_ACTIVATED == 1U */
[/#if]
[#if def_name?contains("UX_DEVICE_CCID") && def_value == "1"]
#if USBD_CCID_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_CCID_Desc(USBD_DevClassHandleTypeDef *pdev,
                                     uint32_t pConf, uint32_t *Sze);
#endif /* USBD_CCID_CLASS_ACTIVATED == 1U */
[/#if]
[#if def_name?contains("UX_DEVICE_PRINTER") && def_value == "1"]
#if USBD_PRINTER_CLASS_ACTIVATED == 1U
static void USBD_FrameWork_PRINTER_Desc(USBD_DevClassHandleTypeDef *pdev,
                                        uint32_t pConf, uint32_t *Sze);
#endif /* USBD_PRINTER_CLASS_ACTIVATED == 1U */
[/#if]
[#if def_name?contains("UX_DEVICE_AUDIO_CORE") && def_value == "1"]
#if USBD_AUDIO_CLASS_ACTIVATED == 1U
[#if USBD_AUDIO_CLASS_value == "0"]
static void USBD_FrameWork_AUDIO10_Desc(USBD_DevClassHandleTypeDef *pdev,
                                        uint32_t pConf, uint32_t *Sze);
[#else]
static void USBD_FrameWork_AUDIO20_Desc(USBD_DevClassHandleTypeDef *pdev,
                                        uint32_t pConf, uint32_t *Sze);
[/#if]
#endif /* USBD_AUDIO_CLASS_ACTIVATED == 1U */
[/#if]

[/#list]
[/#if]
[/#list]
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */

/* USER CODE END 0 */

/**
  * @brief  USBD_Get_Device_Framework_Speed
  *         Return the device speed descriptor
  * @param  Speed : HIGH or FULL SPEED flag
  * @param  length : length of HIGH or FULL SPEED array
  * @retval Pointer to descriptor buffer
  */
uint8_t *USBD_Get_Device_Framework_Speed(uint8_t Speed, ULONG *Length)
{
  uint8_t *pFrameWork = NULL;
  /* USER CODE BEGIN Device_Framework0 */

  /* USER CODE END Device_Framework0 */


  [#if usbd_builder_enabled == "1"]
  if (USBD_FULL_SPEED == Speed)
  {
  [#if FamilyName?lower_case?starts_with("stm32wba")]
	_ux_utility_memory_set(&USBD_Device_FS, 0U, sizeof(USBD_Device_FS));
  [/#if]
    USBD_Device_Framework_Builder(&USBD_Device_FS, pDevFrameWorkDesc_FS,
                                  UserClassInstance, Speed);

    /* Get the length of USBD_device_framework_full_speed */
    *Length = (ULONG)(USBD_Device_FS.CurrDevDescSz + USBD_Device_FS.CurrConfDescSz);

    pFrameWork = pDevFrameWorkDesc_FS;
  }
  else
  {
    [#if FamilyName?lower_case?starts_with("stm32wba")]
    _ux_utility_memory_set(&USBD_Device_HS, 0U, sizeof(USBD_Device_HS));
    [/#if]
    USBD_Device_Framework_Builder(&USBD_Device_HS, pDevFrameWorkDesc_HS,
                                  UserClassInstance, Speed);

    /* Get the length of USBD_device_framework_high_speed */
    *Length = (ULONG)(USBD_Device_HS.CurrDevDescSz + USBD_Device_HS.CurrConfDescSz);

    pFrameWork = pDevFrameWorkDesc_HS;
  }
  [/#if]
  /* USER CODE BEGIN Device_Framework1 */

  /* USER CODE END Device_Framework1 */
  return pFrameWork;
}

/**
  * @brief  USBD_Get_String_Framework
  *         Return the language_id_framework
  * @param  Length : Length of String_Framework
  * @retval Pointer to language_id_framework buffer
  */
uint8_t *USBD_Get_String_Framework(ULONG *Length)
{
  uint16_t len = 0U;
  uint8_t count = 0U;

  /* USER CODE BEGIN String_Framework0 */

  /* USER CODE END String_Framework0 */

  /* Set the Manufacturer language Id and index in USBD_string_framework */
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = USBD_IDX_MFC_STR;

  /* Set the Manufacturer string in string_framework */
  USBD_Desc_GetString((uint8_t *)USBD_MANUFACTURER_STRING, USBD_string_framework + count, &len);

  /* Set the Product language Id and index in USBD_string_framework */
  count += len + 1;
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = USBD_IDX_PRODUCT_STR;

  /* Set the Product string in USBD_string_framework */
  USBD_Desc_GetString((uint8_t *)USBD_PRODUCT_STRING, USBD_string_framework + count, &len);

  /* Set Serial language Id and index in string_framework */
  count += len + 1;
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = USBD_IDX_SERIAL_STR;

  /* Set the Serial number in USBD_string_framework */
  USBD_Desc_GetString((uint8_t *)USBD_SERIAL_NUMBER, USBD_string_framework + count, &len);

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1"]
#if USBD_CDC_ECM_CLASS_ACTIVATED == 1

  /* Set MAC_STRING_INDEX and MAC_STRING in string_framework */
  count += len + 1;
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = CDC_ECM_MAC_STRING_INDEX;

  /* Set the Mac address in USBD_string_framework */
  USBD_Desc_GetString((uint8_t *)CDC_ECM_LOCAL_MAC_STR_DESC, USBD_string_framework + count, &len);

#endif /* USBD_CDC_ECM_CLASS_ACTIVATED */

[/#if]
[#if def_name?contains("UX_DEVICE_RNDIS") && def_value == "1"]
#if USBD_RNDIS_CLASS_ACTIVATED == 1

  /* Set MAC_STRING_INDEX and MAC_STRING in string_framework */
  count += len + 1;
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = RNDIS_MAC_STRING_INDEX;

  /* Set the Mac address in USBD_string_framework */
  USBD_Desc_GetString((uint8_t *)RNDIS_LOCAL_MAC_STR_DESC, USBD_string_framework + count, &len);

#endif /* USBD_RNDIS_CLASS_ACTIVATED */

[/#if]
[#if def_name?contains("UX_DEVICE_DFU") && def_value == "1"]
#if USBD_DFU_CLASS_ACTIVATED
  /* Set DFU_STRING_DESC_INDEX and DFU_STRING_DESC in string_framework */
  count += len + 1;
  USBD_string_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_string_framework[count++] = USBD_LANGID_STRING >> 8;
  USBD_string_framework[count++] = USBD_DFU_STRING_DESC_INDEX;

  /* Set the USBD_DFU_STRING_DESC in USBD_string_framework */
  USBD_Desc_GetString((uint8_t *)USBD_DFU_STRING_DESC, USBD_string_framework + count, &len);
#endif /* USBD_DFU_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]

  /* USER CODE BEGIN String_Framework1 */

  /* USER CODE END String_Framework1 */

  /* Get the length of USBD_string_framework */
  *Length = strlen((const char *)USBD_string_framework);

  return USBD_string_framework;
}

/**
  * @brief  USBD_Get_Language_Id_Framework
  *         Return the language_id_framework
  * @param  Length : Length of Language_Id_Framework
  * @retval Pointer to language_id_framework buffer
  */
uint8_t *USBD_Get_Language_Id_Framework(ULONG *Length)
{
  uint8_t count = 0U;

  /* Set the language Id in USBD_language_id_framework */
  USBD_language_id_framework[count++] = USBD_LANGID_STRING & 0xFF;
  USBD_language_id_framework[count++] = USBD_LANGID_STRING >> 8;

  /* Get the length of USBD_language_id_framework */
  *Length = strlen((const char *)USBD_language_id_framework);

  return USBD_language_id_framework;
}

/**
  * @brief  USBD_Get_Interface_Number
  *         Return interface number
  * @param  class_type : Device class type
  * @param  interface_type : Device interface type
  * @retval interface number
  */
uint16_t USBD_Get_Interface_Number(uint8_t class_type, uint8_t interface_type)
{
  uint8_t itf_num = 0U;
[#if usbd_builder_enabled == "1"]
  uint8_t idx = 0U;
[/#if]

  /* USER CODE BEGIN USBD_Get_Interface_Number0 */

  /* USER CODE END USBD_Get_Interface_Number0 */
[#if usbd_builder_enabled == "1"]

  for(idx = 0; idx < USBD_MAX_SUPPORTED_CLASS; idx++)
  {
    if ((USBD_Device_FS.tclasslist[idx].ClassType == class_type) &&
        (USBD_Device_FS.tclasslist[idx].InterfaceType == interface_type))
    {
      itf_num = USBD_Device_FS.tclasslist[idx].Ifs[0];
    }
  }
[/#if]

  /* USER CODE BEGIN USBD_Get_Interface_Number1 */

  /* USER CODE END USBD_Get_Interface_Number1 */

  return itf_num;
}

/**
  * @brief  USBD_Get_Configuration_Number
  *         Return configuration number
  * @param  class_type : Device class type
  * @param  interface_type : Device interface type
  * @retval configuration number
  */
uint16_t USBD_Get_Configuration_Number(uint8_t class_type, uint8_t interface_type)
{
  uint8_t cfg_num = 1U;

  /* USER CODE BEGIN USBD_Get_CONFIGURATION_Number0 */

  /* USER CODE END USBD_Get_CONFIGURATION_Number0 */

  /* USER CODE BEGIN USBD_Get_CONFIGURATION_Number1 */

  /* USER CODE END USBD_Get_CONFIGURATION_Number1 */

  return cfg_num;
}

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_CORE") && def_value == "1"]

#if USBD_HID_CLASS_ACTIVATED == 1U
/**
  * @brief  USBD_HID_ReportDesc
  *         Return the device HID Report Descriptor
  * @param  hid_type : HID Device type
  * @retval Pointer to HID Report Descriptor buffer
  */
uint8_t *USBD_HID_ReportDesc(uint8_t hid_type)
{
  uint8_t *pHidReportDesc = NULL;

  /* USER CODE BEGIN HidReportDesc0 */

  /* USER CODE END HidReportDesc0 */

  switch(hid_type)
  {
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]
    case INTERFACE_HID_MOUSE:
      pHidReportDesc = USBD_HID_MOUSE_ReportDesc;
      break;
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
    case INTERFACE_HID_KEYBOARD:
      pHidReportDesc = USBD_HID_KEYBOARD_ReportDesc;
      break;
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
    case INTERFACE_HID_CUSTOM:
      pHidReportDesc = USBD_CustomHID_ReportDesc;
      break;
[/#if]
[/#list]
[/#if]
[/#list]
    default:
      break;
  }

  /* USER CODE BEGIN HidReportDesc1 */

  /* USER CODE END HidReportDesc1 */

  return pHidReportDesc;
}

/**
  * @brief  USBD_HID_ReportDesc_length
  *         Return the device HID Report Descriptor
  * @param  hid_type : HID Device type
  * @retval Size of HID Report Descriptor buffer
  */
uint16_t USBD_HID_ReportDesc_length(uint8_t hid_type)
{
  uint16_t ReportDesc_Size = 0;

  /* USER CODE BEGIN ReportDesc_Size0 */

  /* USER CODE END ReportDesc_Size0 */

  switch(hid_type)
  {
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]
    case INTERFACE_HID_MOUSE:
      ReportDesc_Size = sizeof(USBD_HID_MOUSE_ReportDesc);
      break;
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
    case INTERFACE_HID_KEYBOARD:
      ReportDesc_Size = sizeof(USBD_HID_KEYBOARD_ReportDesc);
      break;
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
    case INTERFACE_HID_CUSTOM:
      ReportDesc_Size = sizeof(USBD_CustomHID_ReportDesc);
      break;
[/#if]
[/#list]
[/#if]
[/#list]
    default:
      break;
  }

  /* USER CODE BEGIN ReportDesc_Size1 */

  /* USER CODE END ReportDesc_Size1 */

  return ReportDesc_Size;
}
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]
[/#list]
[/#if]
[/#list]

/**
  * @brief  USBD_Desc_GetString
  *         Convert ASCII string into Unicode one
  * @param  desc : descriptor buffer
  * @param  Unicode : Formatted string buffer (Unicode)
  * @param  len : descriptor length
  * @retval None
  */
static void USBD_Desc_GetString(uint8_t *desc, uint8_t *unicode, uint16_t *len)
{
  uint8_t idx = 0U;
  uint8_t *pdesc;

  if (desc == NULL)
  {
    return;
  }

  pdesc = desc;
  *len = (uint16_t)USBD_Desc_GetLen(pdesc);

  unicode[idx++] = *(uint8_t *)len;

  while (*pdesc != (uint8_t)'\0')
  {
    unicode[idx++] = *pdesc;
    pdesc++;
  }
}

/**
  * @brief  USBD_Desc_GetLen
  *         return the string length
  * @param  buf : pointer to the ASCII string buffer
  * @retval string length
  */
static uint8_t USBD_Desc_GetLen(uint8_t *buf)
{
  uint8_t  len = 0U;
  uint8_t *pbuff = buf;

  while (*pbuff != (uint8_t)'\0')
  {
    len++;
    pbuff++;
  }

  return len;
}

[#if usbd_builder_enabled == "1"]
/**
  * @brief  USBD_Device_Framework_Builder
  *         Device Framework builder
  * @param  pdev: device instance
  * @param  pDevFrameWorkDesc: Pointer to the device framework descriptor
  * @param  UserClassInstance: type of the class to be added
  * @param  Speed: Speed parameter HS or FS
  * @retval status
  */
static uint8_t *USBD_Device_Framework_Builder(USBD_DevClassHandleTypeDef *pdev,
                                              uint8_t *pDevFrameWorkDesc,
                                              uint8_t *UserClassInstance,
                                              uint8_t Speed)
{
  static USBD_DeviceDescTypedef   *pDevDesc;
  static USBD_DevQualiDescTypedef *pDevQualDesc;
  uint8_t Idx_Instance = 0U;

  /* Set Dev and conf descriptors size to 0 */
  pdev->CurrConfDescSz = 0U;
  pdev->CurrDevDescSz = 0U;

  /* Set the pointer to the device descriptor area*/
  pDevDesc = (USBD_DeviceDescTypedef *)pDevFrameWorkDesc;

  /* Start building the generic device descriptor common part */
  pDevDesc->bLength = (uint8_t)sizeof(USBD_DeviceDescTypedef);
  pDevDesc->bDescriptorType = UX_DEVICE_DESCRIPTOR_ITEM;
  pDevDesc->bcdUSB = USB_BCDUSB;
  pDevDesc->bDeviceClass = 0x00;
  pDevDesc->bDeviceSubClass = 0x00;
  pDevDesc->bDeviceProtocol = 0x00;
  pDevDesc->bMaxPacketSize = USBD_MAX_EP0_SIZE;
  pDevDesc->idVendor = USBD_VID;
  pDevDesc->idProduct = USBD_PID;
  pDevDesc->bcdDevice = 0x0200;
  pDevDesc->iManufacturer = USBD_IDX_MFC_STR;
  pDevDesc->iProduct = USBD_IDX_PRODUCT_STR;
  pDevDesc->iSerialNumber = USBD_IDX_SERIAL_STR;
  pDevDesc->bNumConfigurations = USBD_MAX_NUM_CONFIGURATION;
  pdev->CurrDevDescSz += (uint32_t)sizeof(USBD_DeviceDescTypedef);

  /* Check if USBx is in high speed mode to add qualifier descriptor */
  if (Speed == USBD_HIGH_SPEED)
  {
    pDevQualDesc = (USBD_DevQualiDescTypedef *)(pDevFrameWorkDesc + pdev->CurrDevDescSz);
    pDevQualDesc->bLength = (uint8_t)sizeof(USBD_DevQualiDescTypedef);
    pDevQualDesc->bDescriptorType = UX_DEVICE_QUALIFIER_DESCRIPTOR_ITEM;
    pDevQualDesc->bcdDevice = 0x0200;
    pDevQualDesc->Class = 0x00;
    pDevQualDesc->SubClass = 0x00;
    pDevQualDesc->Protocol = 0x00;
    pDevQualDesc->bMaxPacketSize = 0x40;
    pDevQualDesc->bNumConfigurations = 0x01;
    pDevQualDesc->bReserved = 0x00;
    pdev->CurrDevDescSz += (uint32_t)sizeof(USBD_DevQualiDescTypedef);
  }

  /* Build the device framework */
  while (Idx_Instance < USBD_MAX_SUPPORTED_CLASS)
  {
    if ((pdev->classId < USBD_MAX_SUPPORTED_CLASS) &&
        (pdev->NumClasses < USBD_MAX_SUPPORTED_CLASS) &&
        (UserClassInstance[Idx_Instance] != CLASS_TYPE_NONE))
    {
      /* Call the composite class builder */
      (void)USBD_FrameWork_AddClass(pdev,
                                    (USBD_CompositeClassTypeDef)UserClassInstance[Idx_Instance],
                                    0, Speed,
                                    (pDevFrameWorkDesc + pdev->CurrDevDescSz));

      /* Increment the ClassId for the next occurrence */
      pdev->classId ++;
      pdev->NumClasses ++;
    }

    Idx_Instance++;
  }

  /* Check if there is a composite class and update device class */
  if (pdev->NumClasses > 1)
  {
    pDevDesc->bDeviceClass = 0xEF;
    pDevDesc->bDeviceSubClass = 0x02;
    pDevDesc->bDeviceProtocol = 0x01;
  }
 [#if UX_DEVICE_VIDEO_ENABLED_Value == "true"]
  else if (UserClassInstance[0] == CLASS_TYPE_VIDEO)
  {
    pDevDesc->bDeviceClass = 0xEF;
    pDevDesc->bDeviceSubClass = 0x02;
    pDevDesc->bDeviceProtocol = 0x01;
  }
  [/#if]
  else
  {
    /* Check if the CDC ACM class is set and update device class */
    if (UserClassInstance[0] == CLASS_TYPE_CDC_ACM)
    {
      pDevDesc->bDeviceClass = 0x02;
      pDevDesc->bDeviceSubClass = 0x02;
      pDevDesc->bDeviceProtocol = 0x00;
    }
	[#if UX_DEVICE_AUDIO_CORE_ENABLED_Value == "true"]
    else if ((UserClassInstance[0] == CLASS_TYPE_AUDIO_20) ||
             (UserClassInstance[0] == CLASS_TYPE_AUDIO_10))
    {
      pDevDesc->bDeviceClass = 0xEF;
      pDevDesc->bDeviceSubClass = 0x02;
      pDevDesc->bDeviceProtocol = 0x01;
    }
[/#if]
  }

  return pDevFrameWorkDesc;
}


/**
  * @brief  USBD_FrameWork_AddClass
  *         Register a class in the class builder
  * @param  pdev: device instance
  * @param  class: type of the class to be added (from USBD_CompositeClassTypeDef)
  * @param  cfgidx: configuration index
  * @param  speed: device speed
  * @param  pCmpstConfDesc: to composite device configuration descriptor
  * @retval status
  */
uint8_t  USBD_FrameWork_AddClass(USBD_DevClassHandleTypeDef *pdev,
                                 USBD_CompositeClassTypeDef class,
                                 uint8_t cfgidx, uint8_t Speed,
                                 uint8_t *pCmpstConfDesc)
{

[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
  static uint8_t interface_idx = 0U;
[/#if]

  if ((pdev->classId < USBD_MAX_SUPPORTED_CLASS) &&
      (pdev->tclasslist[pdev->classId].Active == 0U))
  {
    /* Store the class parameters in the global tab */
    pdev->tclasslist[pdev->classId].ClassId = pdev->classId;
    pdev->tclasslist[pdev->classId].Active = 1U;
    pdev->tclasslist[pdev->classId].ClassType = class;

[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
    if (class == CLASS_TYPE_HID)
    {
      pdev->tclasslist[pdev->classId].InterfaceType = UserHIDInterface[interface_idx];

      interface_idx++;

      if (interface_idx == sizeof(UserHIDInterface))
      {
        interface_idx = 0U;
      }
    }

[/#if]

    /* Call configuration descriptor builder and endpoint configuration builder */
    if (USBD_FrameWork_AddToConfDesc(pdev, Speed, pCmpstConfDesc) != UX_SUCCESS)
    {
      return UX_ERROR;
    }
  }

  UNUSED(cfgidx);

  return UX_SUCCESS;
}

/**
  * @brief  USBD_FrameWork_AddToConfDesc
  *         Add a new class to the configuration descriptor
  * @param  pdev: device instance
  * @param  Speed: device speed
  * @param  pCmpstConfDesc: to composite device configuration descriptor
  * @retval status
  */
uint8_t  USBD_FrameWork_AddToConfDesc(USBD_DevClassHandleTypeDef *pdev, uint8_t Speed,
                                      uint8_t *pCmpstConfDesc)
{
  uint8_t interface = 0U;

  /* USER CODE BEGIN FrameWork_AddToConfDesc_0 */

  /* USER CODE END FrameWork_AddToConfDesc_0 */

  /* The USB drivers do not set the speed value, so set it here before starting */
  pdev->Speed = Speed;

  /* start building the config descriptor common part */
  if (pdev->classId == 0U)
  {
    /* Add configuration and IAD descriptors */
    USBD_FrameWork_AddConfDesc((uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);
  }

  switch (pdev->tclasslist[pdev->classId].ClassType)
  {

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if (def_name?contains("UX_DEVICE_HID_CORE") && def_value == "1")]
#if USBD_HID_CLASS_ACTIVATED == 1U

    case CLASS_TYPE_HID:

      switch(pdev->tclasslist[pdev->classId].InterfaceType)
      {
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]

#if USBD_HID_MOUSE_ACTIVATED == 1U

        case INTERFACE_HID_MOUSE:

          /* Find the first available interface slot and Assign number of interfaces */
          interface = USBD_FrameWork_FindFreeIFNbr(pdev);
          pdev->tclasslist[pdev->classId].NumIf = 1U;
          pdev->tclasslist[pdev->classId].Ifs[0] = interface;

          /* Assign endpoint numbers */
          pdev->tclasslist[pdev->classId].NumEps = 1U; /* EP_IN */

          /* Check the current speed to assign endpoint IN */
          if (pdev->Speed == USBD_HIGH_SPEED)
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_MOUSE_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_MOUSE_EPIN_HS_MPS);
          }
          else
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_MOUSE_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_MOUSE_EPIN_FS_MPS);
          }

          /* Configure and Append the Descriptor */
          USBD_FrameWork_HID_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

          break;

#endif /* USBD_HID_MOUSE_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
#if USBD_HID_KEYBOARD_ACTIVATED == 1U

        case INTERFACE_HID_KEYBOARD:

          /* Find the first available interface slot and Assign number of interfaces */
          interface = USBD_FrameWork_FindFreeIFNbr(pdev);
          pdev->tclasslist[pdev->classId].NumIf = 1U;
          pdev->tclasslist[pdev->classId].Ifs[0] = interface;

          /* Assign endpoint numbers */
          pdev->tclasslist[pdev->classId].NumEps = 1U; /* EP_IN */

          /* Check the current speed to assign endpoint IN */
          if (pdev->Speed == USBD_HIGH_SPEED)
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_KEYBOARD_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_KEYBOARD_EPIN_HS_MPS);
          }
          else
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_KEYBOARD_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_KEYBOARD_EPIN_FS_MPS);
          }

          /* Configure and Append the Descriptor */
          USBD_FrameWork_HID_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

          break;

#endif /* USBD_HID_KEYBOARD_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
#if USBD_HID_CUSTOM_ACTIVATED == 1U

        case INTERFACE_HID_CUSTOM:

          /* Find the first available interface slot and Assign number of interfaces */
          interface = USBD_FrameWork_FindFreeIFNbr(pdev);
          pdev->tclasslist[pdev->classId].NumIf = 1U;
          pdev->tclasslist[pdev->classId].Ifs[0] = interface;

          /* Assign endpoint numbers */
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]
          pdev->tclasslist[pdev->classId].NumEps = 2U; /* EP_IN, EP_OUT */
[#else]
          pdev->tclasslist[pdev->classId].NumEps = 1U; /* EP_IN */
[/#if]

          /* Check the current speed to assign endpoints */
          if (pdev->Speed == USBD_HIGH_SPEED)
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_CUSTOM_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_CUSTOM_EPIN_HS_MPS);
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]

            /* Assign OUT Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_CUSTOM_EPOUT_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_CUSTOM_EPOUT_HS_MPS);
[/#if]
          }
          else
          {
            /* Assign IN Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_CUSTOM_EPIN_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_CUSTOM_EPIN_FS_MPS);
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]

            /* Assign OUT Endpoint */
            USBD_FrameWork_AssignEp(pdev, USBD_HID_CUSTOM_EPOUT_ADDR,
                                    USBD_EP_TYPE_INTR, USBD_HID_CUSTOM_EPOUT_FS_MPS);
[/#if]
          }

          /* Configure and Append the Descriptor */
          USBD_FrameWork_HID_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

          break;

#endif /* USBD_HID_CUSTOM_ACTIVATED == 1U */

[/#if]
[/#list]
[/#if]
[/#list]

        default:
          break;
      }

      break;
#endif /* USBD_HID_CLASS_ACTIVATED == 1U */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_STORAGE") && def_value == "1"]
#if USBD_MSC_CLASS_ACTIVATED == 1U

    case CLASS_TYPE_MSC:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 1U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 2; /* EP_IN, EP_OUT */

      /* Check the current speed to assign endpoints */
      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_MSC_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_MSC_EPIN_HS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_MSC_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_MSC_EPOUT_HS_MPS);
      }
      else
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_MSC_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_MSC_EPIN_FS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_MSC_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_MSC_EPOUT_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_MSCDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_MSC_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CDC_ACM") && def_value == "1"]
#if USBD_CDC_ACM_CLASS_ACTIVATED == 1

    case CLASS_TYPE_CDC_ACM:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 3U;  /* EP_IN, EP_OUT, CMD_EP */

      /* Check the current speed to assign endpoints */
      if (Speed == USBD_HIGH_SPEED)
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCACM_EPOUT_HS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCACM_EPIN_HS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CDCACM_EPINCMD_HS_MPS);
      }
      else
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCACM_EPOUT_FS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCACM_EPIN_FS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCACM_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CDCACM_EPINCMD_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_CDCDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_CDC_ACM_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1"]
#if USBD_CDC_ECM_CLASS_ACTIVATED == 1

    case CLASS_TYPE_CDC_ECM:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 3U; /* EP_IN, EP_OUT, CMD_EP */

      /* Check the current speed to assign endpoints */
      if (Speed == USBD_HIGH_SPEED)
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCECM_EPOUT_HS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCECM_EPIN_HS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CDCECM_EPINCMD_HS_MPS);
      }
      else
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCECM_EPOUT_FS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CDCECM_EPIN_FS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CDCECM_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CDCECM_EPINCMD_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_CDCECMDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_CDC_ECM_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_RNDIS") && def_value == "1"]
#if USBD_RNDIS_CLASS_ACTIVATED == 1

    case CLASS_TYPE_RNDIS:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 3U; /* EP_IN, EP_OUT, CMD_EP */

      /* Check the current speed to assign endpoints */
      if (Speed == USBD_HIGH_SPEED)
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_RNDIS_EPOUT_HS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_RNDIS_EPIN_HS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_RNDIS_EPINCMD_HS_MPS);
      }
      else
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_RNDIS_EPOUT_FS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_RNDIS_EPIN_FS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_RNDIS_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_RNDIS_EPINCMD_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_RNDISDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_RNDIS_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_DFU") && def_value == "1"]
#if USBD_DFU_CLASS_ACTIVATED == 1

    case CLASS_TYPE_DFU:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf  = 1U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 0U; /* only EP0 is used */

      /* Configure and Append the Descriptor */
      USBD_FrameWork_DFUDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_DFU_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign def_value = define.value]
    [#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_VIDEO") && def_value == "1"]
#if USBD_VIDEO_CLASS_ACTIVATED == 1

    case CLASS_TYPE_VIDEO:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 1U; /* EP_IN */

      /* Check the current speed to assign endpoint IN */
      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_VIDEO_EPIN_ADDR,
                                USBD_EP_TYPE_ISOC, USBD_VIDEO_EPIN_HS_MPS);
      }
      else
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_VIDEO_EPIN_ADDR,
                                USBD_EP_TYPE_ISOC, USBD_VIDEO_EPIN_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_VIDEO_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_VIDEO_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]


[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
    [#assign def_value = define.value]
    [#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_AUDIO_CORE") && def_value == "1"]
#if USBD_AUDIO_CLASS_ACTIVATED == 1
[#if USBD_AUDIO_CLASS_value == "0"]
    case CLASS_TYPE_AUDIO_10:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
[#if (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false") ||
     (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true")]
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
      pdev->tclasslist[pdev->classId].NumIf = 3U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);
      pdev->tclasslist[pdev->classId].Ifs[2] = (uint8_t)(interface + 2U);
[/#if]

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_INTERRUPT */
#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[/#if]
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_OUT */
[/#if]
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]

#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_Feedback */
#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */

[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_IN */
[/#if]

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT

      /* Assign interrupt IN Endpoint */
      USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_INTERRUPT_EPIN_ADDR,
                              USBD_EP_TYPE_INTR, USBD_AUDIO_INTERRUPT_EPIN_FS_MPS);

#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[/#if]
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
      /* Assign OUT Endpoint */
      USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EPOUT_ADDR,
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
                              USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC,
[#else]
                              USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_NOSYNC,
[/#if]
                              USBD_AUDIO_PLAY_EPOUT_FS_MPS);

[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]

#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT

      /* Assign FEEDBACK Endpoint */
      USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EP_FEEDBACK_ADDR,
                              USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_FEEDBACK,
                              USBD_AUDIO_PLAY_EP_FEEDBACK_FS_MPS);

#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
[/#if]
[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
      /* Assign IN Endpoint */
      USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_RECORD_EPIN_ADDR,
                              USBD_EP_TYPE_ISOC,
                              USBD_AUDIO_RECORD_EPIN_FS_MPS);
[/#if]

      /* Configure and Append the Descriptor */
      USBD_FrameWork_AUDIO10_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;
[/#if]


[#if USBD_AUDIO_CLASS_value == "1"]
    case CLASS_TYPE_AUDIO_20:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
[#if (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false") ||
     (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true")]
      pdev->tclasslist[pdev->classId].NumIf = 2U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
      pdev->tclasslist[pdev->classId].NumIf = 3U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;
      pdev->tclasslist[pdev->classId].Ifs[1] = (uint8_t)(interface + 1U);
      pdev->tclasslist[pdev->classId].Ifs[2] = (uint8_t)(interface + 2U);
[/#if]

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_INTERRUPT */

      /* Check the current speed to assign endpoint interrupt */
      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Assign interrupt IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_INTERRUPT_EPIN_ADDR,
                                USBD_EP_TYPE_INTR, USBD_AUDIO_INTERRUPT_EPIN_HS_MPS);
      }
      else
      {
        /* Assign interrupt IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_INTERRUPT_EPIN_ADDR,
                                USBD_EP_TYPE_INTR, USBD_AUDIO_INTERRUPT_EPIN_FS_MPS);
      }

#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[/#if]

      /* Assign endpoint numbers */
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_OUT */
[/#if]
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT
      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_Feedback */
#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */

[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]

      pdev->tclasslist[pdev->classId].NumEps += 1U; /* EP_IN */
[/#if]

      /* Check the current speed to assign endpoint OUT */
      if (pdev->Speed == USBD_HIGH_SPEED)
      {
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EPOUT_ADDR,
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC,
[#else]
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_NOSYNC,
[/#if]
                                USBD_AUDIO_PLAY_EPOUT_HS_MPS);
[/#if]
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT

        /* Assign FEEDBACK Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EP_FEEDBACK_ADDR,
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_FEEDBACK,
                                USBD_AUDIO_PLAY_EP_FEEDBACK_HS_MPS);

#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_RECORD_EPIN_ADDR,
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC,
                                USBD_AUDIO_RECORD_EPIN_HS_MPS);
[/#if]
      }
      else
      {
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EPOUT_ADDR,
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC,
[#else]
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_NOSYNC,
[/#if]
                                USBD_AUDIO_PLAY_EPOUT_FS_MPS);
[/#if]
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]

#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT

        /* Assign FEEDBACK Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_PLAY_EP_FEEDBACK_ADDR,
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_FEEDBACK,
                                USBD_AUDIO_PLAY_EP_FEEDBACK_FS_MPS);

#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_AUDIO_RECORD_EPIN_ADDR,
                                USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC,
                                USBD_AUDIO_RECORD_EPIN_FS_MPS);
[/#if]
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_AUDIO20_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;
[/#if]

#endif /* USBD_AUDIO_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_PIMA") && def_value == "1"]
#if USBD_PIMA_MTP_CLASS_ACTIVATED == 1U

    case CLASS_TYPE_PIMA_MTP:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 1U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 3U; /* EP_IN, EP_OUT, EP_CMD */

      /* Check the current speed to assign endpoints */
      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PIMA_EPIN_HS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PIMA_EPOUT_HS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_PIMA_EPINCMD_HS_MPS);
      }
      else
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PIMA_EPIN_FS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PIMA_EPOUT_FS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PIMA_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_PIMA_EPINCMD_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_MTPDesc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_PIMA_MTP_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CCID") && def_value == "1"]
#if USBD_CCID_CLASS_ACTIVATED == 1U

    case CLASS_TYPE_CCID:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 1U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 3U; /* EP_IN, EP_OUT, CMD_EP */

      /* Check the current speed to assign endpoint IN */
      if (Speed == USBD_HIGH_SPEED)
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CCID_EPOUT_HS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CCID_EPIN_HS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CCID_EPINCMD_HS_MPS);
      }
      else
      {
        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CCID_EPOUT_FS_MPS);

        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_CCID_EPIN_FS_MPS);

        /* Assign CMD Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_CCID_EPINCMD_ADDR,
                                USBD_EP_TYPE_INTR, USBD_CCID_EPINCMD_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_CCID_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_CCID_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
   [#assign def_value = define.value]
   [#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_PRINTER") && def_value == "1"]
#if USBD_PRINTER_CLASS_ACTIVATED == 1U

    case CLASS_TYPE_PRINTER:

      /* Find the first available interface slot and Assign number of interfaces */
      interface = USBD_FrameWork_FindFreeIFNbr(pdev);
      pdev->tclasslist[pdev->classId].NumIf = 1U;
      pdev->tclasslist[pdev->classId].Ifs[0] = interface;

      /* Assign endpoint numbers */
      pdev->tclasslist[pdev->classId].NumEps = 2U; /* EP_IN, EP_OUT */

      /* Check the current speed to assign endpoint IN */
      if (Speed == USBD_HIGH_SPEED)
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PRNT_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PRNT_EPIN_HS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PRNT_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PRNT_EPOUT_HS_MPS);

      }
      else
      {
        /* Assign IN Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PRNT_EPIN_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PRNT_EPIN_FS_MPS);

        /* Assign OUT Endpoint */
        USBD_FrameWork_AssignEp(pdev, USBD_PRNT_EPOUT_ADDR,
                                USBD_EP_TYPE_BULK, USBD_PRNT_EPOUT_FS_MPS);
      }

      /* Configure and Append the Descriptor */
      USBD_FrameWork_PRINTER_Desc(pdev, (uint32_t)pCmpstConfDesc, &pdev->CurrConfDescSz);

      break;

#endif /* USBD_PRINTER_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
    /* USER CODE BEGIN FrameWork_AddToConfDesc_1 */

    /* USER CODE END FrameWork_AddToConfDesc_1 */

    default:
      /* USER CODE BEGIN FrameWork_AddToConfDesc_2 */

      /* USER CODE END FrameWork_AddToConfDesc_2 */
      break;
  }

  return UX_SUCCESS;
}

/**
  * @brief  USBD_FrameWork_FindFreeIFNbr
  *         Find the first interface available slot
  * @param  pdev: device instance
  * @retval The interface number to be used
  */
static uint8_t USBD_FrameWork_FindFreeIFNbr(USBD_DevClassHandleTypeDef *pdev)
{
  uint32_t idx = 0U;

  /* Unroll all already activated classes */
  for (uint32_t i = 0U; i < pdev->NumClasses; i++)
  {
    /* Unroll each class interfaces */
    for (uint32_t j = 0U; j < pdev->tclasslist[i].NumIf; j++)
    {
      /* Increment the interface counter index */
      idx++;
    }
  }

  /* Return the first available interface slot */
  return (uint8_t)idx;
}

/**
  * @brief  USBD_FrameWork_AddConfDesc
  *         Add a new class to the configuration descriptor
  * @param  Conf: configuration descriptor
  * @param  pSze: pointer to the configuration descriptor size
  * @retval none
  */
static void  USBD_FrameWork_AddConfDesc(uint32_t Conf, uint32_t *pSze)
{
  /* Intermediate variable to comply with MISRA-C Rule 11.3 */
  USBD_ConfigDescTypedef *ptr = (USBD_ConfigDescTypedef *)Conf;

  ptr->bLength = (uint8_t)sizeof(USBD_ConfigDescTypedef);
  ptr->bDescriptorType = USB_DESC_TYPE_CONFIGURATION;
  ptr->wDescriptorLength = 0U;
  ptr->bNumInterfaces = 0U;
  ptr->bConfigurationValue = 1U;
  ptr->iConfiguration = USBD_CONFIG_STR_DESC_IDX;
  ptr->bmAttributes = USBD_CONFIG_BMATTRIBUTES;
  ptr->bMaxPower = USBD_CONFIG_MAXPOWER;
  *pSze += sizeof(USBD_ConfigDescTypedef);
}

/**
  * @brief  USBD_FrameWork_AssignEp
  *         Assign and endpoint
  * @param  pdev: device instance
  * @param  Add: Endpoint address
  * @param  Type: Endpoint type
  * @param  Sze: Endpoint max packet size
  * @retval none
  */
static void  USBD_FrameWork_AssignEp(USBD_DevClassHandleTypeDef *pdev,
                                     uint8_t Add, uint8_t Type, uint32_t Sze)
{
  uint32_t idx = 0U;

  /* Find the first available endpoint slot */
  while (((idx < (pdev->tclasslist[pdev->classId]).NumEps) && \
          ((pdev->tclasslist[pdev->classId].Eps[idx].is_used) != 0U)))
  {
    /* Increment the index */
    idx++;
  }

  /* Configure the endpoint */
  pdev->tclasslist[pdev->classId].Eps[idx].add = Add;
  pdev->tclasslist[pdev->classId].Eps[idx].type = Type;
  pdev->tclasslist[pdev->classId].Eps[idx].size = (uint16_t) Sze;
  pdev->tclasslist[pdev->classId].Eps[idx].is_used = 1U;
}

[#if UX_DEVICE_HID_CORE_ENABLED_Value == "true" && HID_ITF_FOUNDED_Value == "true"]
#if USBD_HID_CLASS_ACTIVATED == 1U
/**
  * @brief  USBD_FrameWork_HID_Desc
  *         Configure and Append the HID Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void  USBD_FrameWork_HID_Desc(USBD_DevClassHandleTypeDef *pdev,
                                     uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef       *pIfDesc;
  static USBD_EpDescTypedef       *pEpDesc;
  static USBD_HIDDescTypedef      *pHidDesc;

  switch(pdev->tclasslist[pdev->classId].InterfaceType)
  {

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_HID_MOUSE") && def_value == "1"]
#if USBD_HID_MOUSE_ACTIVATED == 1U
    case INTERFACE_HID_MOUSE:

      /* Append HID Interface descriptor to Configuration descriptor */
      __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U,
                              (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                              UX_DEVICE_CLASS_HID_CLASS,
                              0x01U, INTERFACE_HID_MOUSE, 0U);

      /* Append HID Functional descriptor to Configuration descriptor */
      pHidDesc = ((USBD_HIDDescTypedef *)(pConf + *Sze));
      pHidDesc->bLength = (uint8_t)sizeof(USBD_HIDDescTypedef);
      pHidDesc->bDescriptorType = UX_DEVICE_CLASS_HID_DESCRIPTOR_HID;
      pHidDesc->bcdHID = 0x0111U;
      pHidDesc->bCountryCode = 0x00U;
      pHidDesc->bNumDescriptors = 0x01U;
      pHidDesc->bHIDDescriptorType = 0x22U;
      pHidDesc->wDescriptorLength = USBD_HID_ReportDesc_length(INTERFACE_HID_MOUSE);
      *Sze += (uint32_t)sizeof(USBD_HIDDescTypedef);

      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_MOUSE_EPIN_HS_BINTERVAL,
                                USBD_HID_MOUSE_EPIN_FS_BINTERVAL);
      }
      else
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_MOUSE_EPIN_HS_BINTERVAL,
                                USBD_HID_MOUSE_EPIN_FS_BINTERVAL);
      }

      break;
#endif /* USBD_HID_MOUSE_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_HID_KEYBOARD") && def_value == "1"]
#if USBD_HID_KEYBOARD_ACTIVATED == 1U
    case INTERFACE_HID_KEYBOARD:

      /* Append HID Interface descriptor to Configuration descriptor */
      __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U,
                              (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                              UX_DEVICE_CLASS_HID_CLASS,
                              0x01U, INTERFACE_HID_KEYBOARD, 0U);

      /* Append HID Functional descriptor to Configuration descriptor */
      pHidDesc = ((USBD_HIDDescTypedef *)(pConf + *Sze));
      pHidDesc->bLength = (uint8_t)sizeof(USBD_HIDDescTypedef);
      pHidDesc->bDescriptorType = UX_DEVICE_CLASS_HID_DESCRIPTOR_HID;
      pHidDesc->bcdHID = 0x0111U;
      pHidDesc->bCountryCode = 0x00U;
      pHidDesc->bNumDescriptors = 0x01U;
      pHidDesc->bHIDDescriptorType = 0x22U;
      pHidDesc->wDescriptorLength = USBD_HID_ReportDesc_length(INTERFACE_HID_KEYBOARD);
      *Sze += (uint32_t)sizeof(USBD_HIDDescTypedef);

      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_KEYBOARD_EPIN_HS_BINTERVAL,
                                USBD_HID_KEYBOARD_EPIN_FS_BINTERVAL);
      }
      else
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_KEYBOARD_EPIN_HS_BINTERVAL,
                                USBD_HID_KEYBOARD_EPIN_FS_BINTERVAL);
      }

      break;

#endif /* USBD_HID_KEYBOARD_ACTIVATED == 1U */
[/#if]

[#if def_name?contains("UX_DEVICE_HID_CUSTOM") && def_value == "1"]
#if USBD_HID_CUSTOM_ACTIVATED == 1U
    case  INTERFACE_HID_CUSTOM:

      /* Append HID Interface descriptor to Configuration descriptor */
      __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, \
                              (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                              UX_DEVICE_CLASS_HID_CLASS,
                              0x00U, INTERFACE_HID_CUSTOM, 0U);

      /* Append HID Functional descriptor to Configuration descriptor */
      pHidDesc = ((USBD_HIDDescTypedef *)(pConf + *Sze));
      pHidDesc->bLength = (uint8_t)sizeof(USBD_HIDDescTypedef);
      pHidDesc->bDescriptorType = UX_DEVICE_CLASS_HID_DESCRIPTOR_HID;
      pHidDesc->bcdHID = 0x0111U;
      pHidDesc->bCountryCode = 0x00U;
      pHidDesc->bNumDescriptors = 0x01U;
      pHidDesc->bHIDDescriptorType = 0x22U;
      pHidDesc->wDescriptorLength = USBD_HID_ReportDesc_length(INTERFACE_HID_CUSTOM);
      *Sze += (uint32_t)sizeof(USBD_HIDDescTypedef);

      if (pdev->Speed == USBD_HIGH_SPEED)
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_CUSTOM_EPIN_FS_BINTERVAL,
                                USBD_HID_CUSTOM_EPIN_HS_BINTERVAL);
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]

        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[1].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[1].size,
                                USBD_HID_CUSTOM_EPOUT_HS_BINTERVAL,
                                USBD_HID_CUSTOM_EPOUT_FS_BINTERVAL);
[/#if]
      }
      else
      {
        /* Append Endpoint descriptor to Configuration descriptor */
        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[0].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                                USBD_HID_CUSTOM_EPIN_FS_BINTERVAL,
                                USBD_HID_CUSTOM_EPIN_HS_BINTERVAL);
[#if UX_DEVICE_CLASS_HID_INTERRUPT_OUT_SUPPORT_value == "1"]

        __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[1].add,
                                USBD_EP_TYPE_INTR,
                                (uint16_t)pdev->tclasslist[pdev->classId].Eps[1].size,
                                USBD_HID_CUSTOM_EPOUT_HS_BINTERVAL,
                                USBD_HID_CUSTOM_EPOUT_FS_BINTERVAL);
[/#if]
      }

      break;

#endif /* USBD_HID_CUSTOM_ACTIVATED == 1U */
[/#if]
[/#list]
[/#if]
[/#list]

    default:
      break;
  }

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;

}
#endif /* USBD_HID_CLASS_ACTIVATED */
[/#if]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_STORAGE") && def_value == "1"]
#if USBD_MSC_CLASS_ACTIVATED == 1
/**
  * @brief  USBD_FrameWork_MSCDesc
  *         Configure and Append the MSC Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void  USBD_FrameWork_MSCDesc(USBD_DevClassHandleTypeDef *pdev,
                                    uint32_t pConf, uint32_t *Sze)
{
  USBD_IfDescTypedef       *pIfDesc;
  USBD_EpDescTypedef       *pEpDesc;

  /* Append MSC Interface descriptor */
  __USBD_FRAMEWORK_SET_IF((pdev->tclasslist[pdev->classId].Ifs[0]), (0U), \
                          (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                          (0x08U), (0x06U), (0x50U), (0U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          (0U), (0U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[1].size),
                          (0U), (0U));

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;
}
#endif /* USBD_MSC_CLASS_ACTIVATED == 1 */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CDC_ACM") && def_value == "1"]
#if USBD_CDC_ACM_CLASS_ACTIVATED == 1
/**
  * @brief  USBD_FrameWork_CDCDesc
  *         Configure and Append the CDC Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_CDCDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef               *pIfDesc;
  static USBD_EpDescTypedef               *pEpDesc;
  static USBD_CDCHeaderFuncDescTypedef    *pHeadDesc;
  static USBD_CDCCallMgmFuncDescTypedef   *pCallMgmDesc;
  static USBD_CDCACMFuncDescTypedef       *pACMDesc;
  static USBD_CDCUnionFuncDescTypedef     *pUnionDesc;
#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef              *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

#if USBD_COMPOSITE_USE_IAD == 1
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = USB_DESC_TYPE_IAD; /* IAD descriptor */
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pIadDesc->bInterfaceCount = 2U;    /* 2 interfaces */
  pIadDesc->bFunctionClass = 0x02U;
  pIadDesc->bFunctionSubClass = 0x02U;
  pIadDesc->bFunctionProtocol = 0x01U;
  pIadDesc->iFunction = 0; /* String Index */
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Control Interface Descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, 1U, 0x02,
                          0x02U, 0x01U, 0U);

  /* Control interface headers */
  pHeadDesc = ((USBD_CDCHeaderFuncDescTypedef *)((uint32_t)pConf + *Sze));
  /* Header Functional Descriptor*/
  pHeadDesc->bLength = 0x05U;
  pHeadDesc->bDescriptorType = 0x24U;
  pHeadDesc->bDescriptorSubtype = 0x00U;
  pHeadDesc->bcdCDC = 0x0110;
  *Sze += (uint32_t)sizeof(USBD_CDCHeaderFuncDescTypedef);

  /* Call Management Functional Descriptor*/
  pCallMgmDesc = ((USBD_CDCCallMgmFuncDescTypedef *)((uint32_t)pConf + *Sze));
  pCallMgmDesc->bLength = 0x05U;
  pCallMgmDesc->bDescriptorType = 0x24U;
  pCallMgmDesc->bDescriptorSubtype = 0x01U;
  pCallMgmDesc->bmCapabilities = 0x00U;
  pCallMgmDesc->bDataInterface = pdev->tclasslist[pdev->classId].Ifs[1];
  *Sze += (uint32_t)sizeof(USBD_CDCCallMgmFuncDescTypedef);

  /* ACM Functional Descriptor*/
  pACMDesc = ((USBD_CDCACMFuncDescTypedef *)((uint32_t)pConf + *Sze));
  pACMDesc->bLength = 0x04U;
  pACMDesc->bDescriptorType = 0x24U;
  pACMDesc->bDescriptorSubtype = 0x02U;
  pACMDesc->bmCapabilities = 0x02;
  *Sze += (uint32_t)sizeof(USBD_CDCACMFuncDescTypedef);

  /* Union Functional Descriptor*/
  pUnionDesc = ((USBD_CDCUnionFuncDescTypedef *)((uint32_t)pConf + *Sze));
  pUnionDesc->bLength = 0x05U;
  pUnionDesc->bDescriptorType = 0x24U;
  pUnionDesc->bDescriptorSubtype = 0x06U;
  pUnionDesc->bMasterInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pUnionDesc->bSlaveInterface = pdev->tclasslist[pdev->classId].Ifs[1];
  *Sze += (uint32_t)sizeof(USBD_CDCUnionFuncDescTypedef);

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[2].add, \
                          USBD_EP_TYPE_INTR,
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[2].size,
                          USBD_CDCACM_EPINCMD_HS_BINTERVAL,
                          USBD_CDCACM_EPINCMD_FS_BINTERVAL);

  /* Data Interface Descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[1], 0U, 2U, 0x0A,
                          0U, 0U, 0U);

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add), \
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          (0x00U), (0x00U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add), \
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[1].size),
                          (0x00U), (0x00U));

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 2U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;
}
#endif /* USBD_CDC_ACM_CLASS_ACTIVATED == 1 */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CDC_ECM") && def_value == "1"]
#if USBD_CDC_ECM_CLASS_ACTIVATED
/**
  * @brief  USBD_FrameWork_CDCECMDesc
  *         Configure and Append the CDC_ECM Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_CDCECMDesc(USBD_DevClassHandleTypeDef *pdev,
                                      uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef             *pIfDesc;
  static USBD_EpDescTypedef             *pEpDesc;
  static USBD_ECMFuncDescTypedef        *pFuncDesc;
  static USBD_CDCHeaderFuncDescTypedef  *pHeadDesc;
  static USBD_CDCUnionFuncDescTypedef   *pUnionDesc;

#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef              *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

#if USBD_COMPOSITE_USE_IAD == 1
  /* IAD descriptor */
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = USB_DESC_TYPE_IAD;
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pIadDesc->bInterfaceCount = 2U;    /* 2 interfaces */
  pIadDesc->bFunctionClass = 0x02U;
  pIadDesc->bFunctionSubClass = 0x06U;
  pIadDesc->bFunctionProtocol = 0x00U;
  pIadDesc->iFunction = 0U; /* String Index */
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Append ECM Interface descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, 1U, 0x02U,
                          0x06U, 0U, 0U);

  /* Append ECM header functional descriptor to Configuration descriptor */
  pHeadDesc = ((USBD_CDCHeaderFuncDescTypedef *)(pConf + *Sze));
  pHeadDesc->bLength = (uint8_t)sizeof(USBD_CDCHeaderFuncDescTypedef);
  pHeadDesc->bDescriptorType = 0x24U;
  pHeadDesc->bDescriptorSubtype = 0x00U;
  pHeadDesc->bcdCDC = USBD_DESC_ECM_BCD;
  *Sze += (uint32_t)sizeof(USBD_CDCHeaderFuncDescTypedef);

  /* Append ECM functional descriptor to Configuration descriptor */
  pFuncDesc = ((USBD_ECMFuncDescTypedef *)(pConf + *Sze));
  pFuncDesc->bFunctionLength = (uint8_t)sizeof(USBD_ECMFuncDescTypedef);
  pFuncDesc->bDescriptorType = 0x24U;
  pFuncDesc->bDescriptorSubType = USBD_DESC_SUBTYPE_ACM;
  pFuncDesc->iMacAddress = CDC_ECM_MAC_STRING_INDEX;
  pFuncDesc->bEthernetStatistics3 = CDC_ECM_ETH_STATS_BYTE3;
  pFuncDesc->bEthernetStatistics2 = CDC_ECM_ETH_STATS_BYTE2;
  pFuncDesc->bEthernetStatistics1 = CDC_ECM_ETH_STATS_BYTE1;
  pFuncDesc->bEthernetStatistics0 = CDC_ECM_ETH_STATS_BYTE0;
  pFuncDesc->wMaxSegmentSize = CDC_ECM_ETH_MAX_SEGSZE;
  pFuncDesc->bNumberMCFiltes = CDC_ECM_ETH_NBR_MACFILTERS;
  pFuncDesc->bNumberPowerFiltes = CDC_ECM_ETH_NBR_PWRFILTERS;
  *Sze += (uint32_t)sizeof(USBD_ECMFuncDescTypedef);

  /* Append ECM Union functional descriptor to Configuration descriptor */
  pUnionDesc = ((USBD_CDCUnionFuncDescTypedef *)((uint32_t)pConf + *Sze));
  pUnionDesc->bLength = (uint8_t)sizeof(USBD_CDCUnionFuncDescTypedef);
  pUnionDesc->bDescriptorType = 0x24U;
  pUnionDesc->bDescriptorSubtype = 0x06U;
  pUnionDesc->bMasterInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pUnionDesc->bSlaveInterface = pdev->tclasslist[pdev->classId].Ifs[1];
  *Sze += (uint32_t)sizeof(USBD_CDCUnionFuncDescTypedef);

  /* Append ECM Communication IN Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[2].add,
                          USBD_EP_TYPE_INTR,
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[2].size,
                          USBD_CDCECM_EPINCMD_HS_BINTERVAL,
                          USBD_CDCECM_EPINCMD_FS_BINTERVAL);

  /* Append ECM Data class interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[1], 0U, 2U, 0x0AU, 0U,
                          0U, 0U);

  /* Append ECM OUT Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          (0x00U), (0x00U));

  /* Append ECM IN Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[1].size),
                          (0x00U), (0x00U));

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef*)pConf)->bNumInterfaces += 2U;
  ((USBD_ConfigDescTypedef*)pConf)->wDescriptorLength = *Sze;
}
#endif /* USBD_CDC_ECM_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_RNDIS") && def_value == "1"]
#if USBD_RNDIS_CLASS_ACTIVATED
/**
  * @brief  USBD_FrameWork_RNDISDesc
  *         Configure and Append the RNDIS Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_RNDISDesc(USBD_DevClassHandleTypeDef *pdev,
                                     uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef             *pIfDesc;
  static USBD_EpDescTypedef             *pEpDesc;
  static USBD_CDCCallMgmFuncDescTypedef *pCallMgmDesc;
  static USBD_CDCHeaderFuncDescTypedef  *pHeadDesc;
  static USBD_CDCACMFuncDescTypedef     *pACMDesc;
  static USBD_CDCUnionFuncDescTypedef   *pUnionDesc;

#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef            *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

#if USBD_COMPOSITE_USE_IAD == 1
  /* IAD descriptor */
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = USB_DESC_TYPE_IAD;
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pIadDesc->bInterfaceCount = 2U;
  pIadDesc->bFunctionClass = 0xE0U;
  pIadDesc->bFunctionSubClass = 0x01U;
  pIadDesc->bFunctionProtocol = 0x03U;
  pIadDesc->iFunction = 0;
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Append RNDIS Control Interface descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0x0U, 0x01U,
                          UX_DEVICE_CLASS_RNDIS_CLASS_COMMUNICATION_CONTROL,
                          0x02U, 0xFFU, 0U);

  /* Append RNDIS header functional descriptor to Configuration descriptor */
  pHeadDesc = ((USBD_CDCHeaderFuncDescTypedef *)(pConf + *Sze));
  pHeadDesc->bLength = (uint8_t)sizeof(USBD_CDCHeaderFuncDescTypedef);
  pHeadDesc->bDescriptorType = 0x24U;
  pHeadDesc->bDescriptorSubtype = 0x00U;
  pHeadDesc->bcdCDC = 0x0110U;
  *Sze += (uint32_t)sizeof(USBD_CDCHeaderFuncDescTypedef);

  /* Call Management Functional Descriptor*/
  pCallMgmDesc = ((USBD_CDCCallMgmFuncDescTypedef *)((uint32_t)pConf + *Sze));
  pCallMgmDesc->bLength = (uint8_t)sizeof(USBD_CDCCallMgmFuncDescTypedef);
  pCallMgmDesc->bDescriptorType = 0x24U;
  pCallMgmDesc->bDescriptorSubtype = 0x01U;
  pCallMgmDesc->bmCapabilities = 0x00U;
  pCallMgmDesc->bDataInterface = pdev->tclasslist[pdev->classId].Ifs[1];
  *Sze += (uint32_t)sizeof(USBD_CDCCallMgmFuncDescTypedef);

  /* ACM Functional Descriptor*/
  pACMDesc = ((USBD_CDCACMFuncDescTypedef *)(pConf + *Sze));
  pACMDesc->bLength = (uint8_t)sizeof(USBD_CDCACMFuncDescTypedef);
  pACMDesc->bDescriptorType = 0x24U;
  pACMDesc->bDescriptorSubtype = 0x02U;
  pACMDesc->bmCapabilities = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_CDCACMFuncDescTypedef);

  /* Union Functional Descriptor*/
  pUnionDesc = ((USBD_CDCUnionFuncDescTypedef *)(pConf + *Sze));
  pUnionDesc->bLength = (uint8_t)sizeof(USBD_CDCUnionFuncDescTypedef);
  pUnionDesc->bDescriptorType = 0x24U;
  pUnionDesc->bDescriptorSubtype = 0x06U;
  pUnionDesc->bMasterInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pUnionDesc->bSlaveInterface = pdev->tclasslist[pdev->classId].Ifs[1];
  *Sze += (uint32_t)sizeof(USBD_CDCUnionFuncDescTypedef);

  /* Append RNDIS Communication IN Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[2].add,
                          USBD_EP_TYPE_INTR,
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[2].size,
                          USBD_RNDIS_EPINCMD_HS_BINTERVAL,
                          USBD_RNDIS_EPINCMD_FS_BINTERVAL);

  /* Append RNDIS Data class interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[1], 0x00U, 0x02U,
                          UX_DEVICE_CLASS_RNDIS_CLASS_COMMUNICATION_DATA,
                          0x00U, 0x00U, 0x00U);

  /* Append RNDIS OUT Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          (0x00U), (0x00U));

  /* Append RNDIS IN Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[1].size),
                          (0x00U), (0x00U));

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef*)pConf)->bNumInterfaces += 2U;
  ((USBD_ConfigDescTypedef*)pConf)->wDescriptorLength = *Sze;
}
#endif /* USBD_RNDIS_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_DFU") && def_value == "1"]
#if USBD_DFU_CLASS_ACTIVATED
/**
  * @brief  USBD_FrameWork_DFUDesc
  *         Configure and Append the DFU Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_DFUDesc(USBD_DevClassHandleTypeDef *pdev,
                                   uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef        *pIfDesc;
  static USBD_DFUFuncDescTypedef   *pDFUFuncDesc;

  /* Append DFU Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U,
                          0U, 0xFEU, 0x01U, 0x02U, 0x06U);

  /* Append DFU Functional descriptor to Configuration descriptor */
  pDFUFuncDesc = ((USBD_DFUFuncDescTypedef*)(pConf + *Sze));
  pDFUFuncDesc->bLength = (uint8_t)sizeof(USBD_DFUFuncDescTypedef);
  pDFUFuncDesc->bDescriptorType = DFU_DESCRIPTOR_TYPE;
  pDFUFuncDesc->bmAttributes = USBD_DFU_BM_ATTRIBUTES;
  pDFUFuncDesc->wDetachTimeout = USBD_DFU_DetachTimeout;
  pDFUFuncDesc->wTransferSze = USBD_DFU_XFER_SIZE;
  pDFUFuncDesc->bcdDFUVersion = 0x011AU;
  *Sze += (uint32_t)sizeof(USBD_DFUFuncDescTypedef);

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef*)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef*)pConf)->wDescriptorLength = *Sze;

  UNUSED(USBD_FrameWork_AssignEp);
}
#endif /* USBD_DFU_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_VIDEO") && def_value == "1"]
#if USBD_VIDEO_CLASS_ACTIVATED == 1
/**
  * @brief  USBD_FrameWork_VIDEO_Desc
  *         Configure and Append the VIDEO Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_VIDEO_Desc(USBD_DevClassHandleTypeDef *pdev,
                                      uint32_t pConf, uint32_t *Sze)
{
[#if vs_format_subtype == "1"]
  __ALIGN_BEGIN static uint8_t usbd_uvc_guid[16] __ALIGN_END = {DBVAL(UVC_UNCOMPRESSED_GUID),
                                                                0x00, 0x00, 0x10,
                                                                0x00, 0x80, 0x00,
                                                                0x00, 0xAA, 0x00,
                                                                0x38, 0x9B, 0x71};
[/#if]

  USBD_IfDescTypedef *pIfDesc;
  USBD_EpDescTypedef *pEpDesc;

#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  USBD_VIDEOCSVCIfDescTypeDef *pVideoVCInDesc;
  USBD_VIDEOInputTerminalDescTypeDef *pVideoITDesc;
  USBD_VIDEOOutputTerminalDescTypeDef *pVideoOTDesc;
  USBD_VIDEOVSHeaderDescTypeDef *pVideoSHeaderDesc;
  USBD_VIDEOPayloadFormatDescTypeDef *pVideoPayForDesc;
  USBD_VIDEOFrameDescTypeDef *pVideoFrameDesc;
[#if vs_format_subtype == "1"]
  USBD_ColorMatchingDescTypeDef *pColMaDesc;
[/#if]

#if USBD_COMPOSITE_USE_IAD == 1
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = USB_DESC_TYPE_IAD; /* IAD descriptor */
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
  pIadDesc->bInterfaceCount = 2U;    /* 2 interfaces */
  pIadDesc->bFunctionClass = UX_DEVICE_CLASS_VIDEO_CC_VIDEO;
  pIadDesc->bFunctionSubClass = UX_DEVICE_CLASS_VIDEO_SC_INTERFACE_COLLECTION;
  pIadDesc->bFunctionProtocol = UX_DEVICE_CLASS_VIDEO_PC_PROTOCOL_UNDEFINED;
  pIadDesc->iFunction = 0U; /* String Index */
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Append VIDEO Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, 0U,
                          UX_DEVICE_CLASS_VIDEO_CC_VIDEO,
                          UX_DEVICE_CLASS_VIDEO_SC_CONTROL,
                          UX_DEVICE_CLASS_VIDEO_PC_PROTOCOL_UNDEFINED,
                          0U);

  /* Append Class-specific VC Interface Descriptor to Configuration descriptor*/
  pVideoVCInDesc = ((USBD_VIDEOCSVCIfDescTypeDef *)(pConf + *Sze));
  pVideoVCInDesc->bLength = (uint8_t)sizeof(USBD_VIDEOCSVCIfDescTypeDef);
  pVideoVCInDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
  pVideoVCInDesc->bDescriptorSubtype = 0x01U;
  pVideoVCInDesc->bcdUVC = 0x0110U;
  pVideoVCInDesc->wTotalLength = 0x001EU;
  pVideoVCInDesc->dwClockFrequency = 0x02DC6C00U;
  pVideoVCInDesc->bInCollection = 0x01U;
  pVideoVCInDesc->aInterfaceNr = 0x01U;
  *Sze += (uint32_t)sizeof(USBD_VIDEOCSVCIfDescTypeDef);

  /*Append Input Terminal Descriptor to Configuration descriptor */
  pVideoITDesc = ((USBD_VIDEOInputTerminalDescTypeDef *)(pConf + *Sze));
  pVideoITDesc->bLength = (uint8_t)sizeof(USBD_VIDEOInputTerminalDescTypeDef);
  pVideoITDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
  pVideoITDesc->bDescriptorSubtype = 0x02U;
  pVideoITDesc->bTerminalID = 0x01U;
  pVideoITDesc->wTerminalType = 0x0200U;
  pVideoITDesc->bAssocTerminal = 0x00U;
  pVideoITDesc->iTerminal =  0x00U;
  *Sze += (uint32_t)sizeof(USBD_VIDEOInputTerminalDescTypeDef);

  /* Append Output Terminal Descriptor to Configuration descriptor */
  pVideoOTDesc = ((USBD_VIDEOOutputTerminalDescTypeDef *)(pConf + *Sze));
  pVideoOTDesc->bLength = (uint8_t)sizeof(USBD_VIDEOOutputTerminalDescTypeDef);
  pVideoOTDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
  pVideoOTDesc->bDescriptorSubtype = 0x03U;
  pVideoOTDesc->bTerminalID = 0x02U;
  pVideoOTDesc->wTerminalType = 0x0101U;
  pVideoOTDesc->bAssocTerminal = 0x00U;
  pVideoOTDesc->bSourceID = 0x01U;
  pVideoOTDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_VIDEOOutputTerminalDescTypeDef);

  /* Standard VS (Video Streaming) Interface Descriptor */
  /* Interface 1, Alternate Setting 0 = Zero Bandwidth*/
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[1], 0U, 0U,
                          UX_DEVICE_CLASS_VIDEO_CC_VIDEO,
                          UX_DEVICE_CLASS_VIDEO_SC_STREAMING,
                          UX_DEVICE_CLASS_VIDEO_PC_PROTOCOL_UNDEFINED,
                          0U);

  /* Append Class-specific VS Header Descriptor (Input) to Configuration descriptor */
  pVideoSHeaderDesc = ((USBD_VIDEOVSHeaderDescTypeDef *)(pConf + *Sze));
  pVideoSHeaderDesc->bLength = (uint8_t)sizeof(USBD_VIDEOVSHeaderDescTypeDef);
  pVideoSHeaderDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
  pVideoSHeaderDesc->bDescriptorSubtype = UX_DEVICE_CLASS_VIDEO_VC_HEADER;
  pVideoSHeaderDesc->bNumFormats = 0x01U;
  pVideoSHeaderDesc->wTotalLength = VC_HEADER_SIZE;
  pVideoSHeaderDesc->bEndpointAddress = USBD_VIDEO_EPIN_ADDR;
  pVideoSHeaderDesc->bmInfo = 0x00U;
  pVideoSHeaderDesc->bTerminalLink = 0x02U;
  pVideoSHeaderDesc->bStillCaptureMethod = 0x00U;
  pVideoSHeaderDesc->bTriggerSupport = 0x00U;
  pVideoSHeaderDesc->bTriggerUsage = 0x00U;
  pVideoSHeaderDesc->bControlSize = 0x01U;
  pVideoSHeaderDesc->bmaControls = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_VIDEOVSHeaderDescTypeDef);

  /* Append Payload Format Descriptor to Configuration descriptor */
  pVideoPayForDesc = ((USBD_VIDEOPayloadFormatDescTypeDef *)(pConf + *Sze));
  pVideoPayForDesc->bLength = (uint8_t)sizeof(USBD_VIDEOPayloadFormatDescTypeDef);
  pVideoPayForDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
[#if vs_format_subtype == "0"]
  pVideoPayForDesc->bDescriptorSubType = UX_DEVICE_CLASS_VIDEO_VS_FORMAT_MJPEG;
[#else]
  pVideoPayForDesc->bDescriptorSubType = UX_DEVICE_CLASS_VIDEO_VS_FORMAT_UNCOMPRESSED;
[/#if]
  pVideoPayForDesc->bFormatIndex = 0x01U;
  pVideoPayForDesc->bNumFrameDescriptors = 0x01U;
[#if vs_format_subtype == "1"]

  ux_utility_memory_copy(pVideoPayForDesc->pGiudFormat, usbd_uvc_guid, 16);

  pVideoPayForDesc->bBitsPerPixel = UVC_BITS_PER_PIXEL;
[#else]
  pVideoPayForDesc->bmFlags = 0x01U;
[/#if]
  pVideoPayForDesc->bDefaultFrameIndex = 0x01U;
  pVideoPayForDesc->bAspectRatioX = 0x00U;
  pVideoPayForDesc->bAspectRatioY = 0x00U;
  pVideoPayForDesc->bmInterfaceFlag = 0x00U;
  pVideoPayForDesc->bCopyProtect = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_VIDEOPayloadFormatDescTypeDef);

  /* Append Class-specific VS (Video Streaming) Frame Descriptor to
     Configuration descriptor */
  pVideoFrameDesc = ((USBD_VIDEOFrameDescTypeDef *)(pConf + *Sze));
  pVideoFrameDesc->bLength = (uint8_t)sizeof(USBD_VIDEOFrameDescTypeDef);
  pVideoFrameDesc->bDescriptorType = UX_DEVICE_CLASS_VIDEO_CS_INTERFACE;
[#if vs_format_subtype == "0"]
  pVideoFrameDesc->bDescriptorSubType = UX_DEVICE_CLASS_VIDEO_VS_FRAME_MJPEG;
[#else]
  pVideoFrameDesc->bDescriptorSubType = UX_DEVICE_CLASS_VIDEO_VS_FRAME_UNCOMPRESSED;
[/#if]

  pVideoFrameDesc->bFrameIndex = 0x01U;
[#if vs_format_subtype == "1"]
  pVideoFrameDesc->bmCapabilities = 0x00U;
[#else]
  pVideoFrameDesc->bmCapabilities = 0x02U;
[/#if]
  pVideoFrameDesc->wWidth = UVC_FRAME_WIDTH;
  pVideoFrameDesc->wHeight = UVC_FRAME_HEIGHT;

  if (pdev->Speed == (uint8_t)USBD_HIGH_SPEED)
  {
    pVideoFrameDesc->dwMinBitRate = UVC_MIN_BIT_RATE(UVC_CAM_FPS_HS);
    pVideoFrameDesc->dwMaxBitRate = UVC_MAX_BIT_RATE(UVC_CAM_FPS_HS);
    pVideoFrameDesc->dwDefaultFrameInterval = UVC_INTERVAL(UVC_CAM_FPS_HS);
    pVideoFrameDesc->dwFrameInterval = UVC_INTERVAL(UVC_CAM_FPS_HS);
  }
  else
  {
    pVideoFrameDesc->dwMinBitRate = UVC_MIN_BIT_RATE(UVC_CAM_FPS_FS);
    pVideoFrameDesc->dwMaxBitRate = UVC_MAX_BIT_RATE(UVC_CAM_FPS_FS);
    pVideoFrameDesc->dwDefaultFrameInterval = UVC_INTERVAL(UVC_CAM_FPS_FS);
    pVideoFrameDesc->dwFrameInterval = UVC_INTERVAL(UVC_CAM_FPS_FS);
  }

  pVideoFrameDesc->dwMaxVideoFrameBufferSize = UVC_MAX_FRAME_SIZE;
  pVideoFrameDesc->bFrameIntervalType = 0x01U;

  *Sze += (uint32_t)sizeof(USBD_VIDEOFrameDescTypeDef);

[#if vs_format_subtype == "1"]
  /* Append Color Matching Descriptor to Configuration descriptor */
  pColMaDesc = ((USBD_ColorMatchingDescTypeDef *)(pConf + *Sze));
  pColMaDesc->bLength = (uint8_t)sizeof(USBD_ColorMatchingDescTypeDef);
  pColMaDesc->bDescriptorType = 0x24U;
  pColMaDesc->bDescriptorSubType = 0x0DU;
  pColMaDesc->bColorPrimarie = UVC_COLOR_PRIMARIE;
  pColMaDesc->bTransferCharacteristics = UVC_TFR_CHARACTERISTICS;
  pColMaDesc->bMatrixCoefficients = UVC_MATRIX_COEFFICIENTS;
  *Sze += (uint32_t)sizeof(USBD_ColorMatchingDescTypeDef);
[/#if]

  /* USB Standard VS Interface  Descriptor - data transfer mode */
  /* Interface 1, Alternate Setting 1*/
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[1], 1U, 1U,
                          UX_DEVICE_CLASS_VIDEO_CC_VIDEO,
                          UX_DEVICE_CLASS_VIDEO_SC_STREAMING,
                          UX_DEVICE_CLASS_VIDEO_PC_PROTOCOL_UNDEFINED,
                          0U);

    /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          (USBD_EP_TYPE_ISOC|USBD_EP_ATTR_ISOC_ASYNC),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          USBD_VIDEO_EPIN_HS_BINTERVAL,
                          USBD_VIDEO_EPIN_FS_BINTERVAL);

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 2U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;
}
#endif /* USBD_VIDEO_CLASS_ACTIVATED == 1 */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_PIMA") && def_value == "1"]
#if USBD_PIMA_MTP_CLASS_ACTIVATED == 1
/**
  * @brief  USBD_FrameWork_MTPDesc
  *         Configure and Append the MTP Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void  USBD_FrameWork_MTPDesc(USBD_DevClassHandleTypeDef *pdev,
                                    uint32_t pConf, uint32_t *Sze)
{
  USBD_IfDescTypedef *pIfDesc;
  USBD_EpDescTypedef *pEpDesc;

  /* Append MTP Interface descriptor */
  __USBD_FRAMEWORK_SET_IF((pdev->tclasslist[pdev->classId].Ifs[0]), (0U),
                          (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                          UX_DEVICE_CLASS_PIMA_CLASS,
                          UX_DEVICE_CLASS_PIMA_SUBCLASS,
                          UX_DEVICE_CLASS_PIMA_PROTOCOL, (0U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[0].size),
                          (0x01U), (0x01U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          (USBD_EP_TYPE_BULK),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[1].size),
                          (0x01U), (0x01U));

  /* Append ECM IN Endpoint Descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[2].add),
                          (USBD_EP_TYPE_INTR),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[2].size),
                          USBD_PIMA_EPINCMD_HS_BINTERVAL,
                          USBD_PIMA_EPINCMD_FS_BINTERVAL);

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength  = *Sze;
}
#endif /* USBD_PIMA_MTP_CLASS_ACTIVATED == 1 */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_CCID") && def_value == "1"]
#if USBD_CCID_CLASS_ACTIVATED == 1U
/**
  * @brief  USBD_FrameWork_CCID_Desc
  *         Configure and Append the CCID Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void  USBD_FrameWork_CCID_Desc(USBD_DevClassHandleTypeDef *pdev,
                                      uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef       *pIfDesc;
  static USBD_EpDescTypedef       *pEpDesc;
  static USBD_CCIDDescTypedef     *pCCIDDesc;

  /* Append HID Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, \
                          (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                          0x0BU, 0U, 0U, 0U);

  /* Append CCID Functional descriptor to Configuration descriptor */
  pCCIDDesc = ((USBD_CCIDDescTypedef *)(pConf + *Sze));
  pCCIDDesc->bLength = 0x36U;
  pCCIDDesc->bDescriptorType = 0x21U;
  pCCIDDesc->bcdCCID = 0x0110U;
  pCCIDDesc->bMaxSlotIndex = USBD_CCID_MAX_SLOT_INDEX;
  pCCIDDesc->bVoltageSupport = USBD_CCID_VOLTAGE_SUPPLY;
  pCCIDDesc->dwProtocols = USBD_CCID_PROTOCOL;
  pCCIDDesc->dwDefaultClock = USBD_CCID_DEFAULT_CLOCK_FREQ;
  pCCIDDesc->dwMaximumClock = USBD_CCID_MAX_CLOCK_FREQ;
  pCCIDDesc->bNumClockSupported = USBD_CCID_N_CLOCKS;
  pCCIDDesc->dwDataRate = USBD_CCID_DEFAULT_DATA_RATE;
  pCCIDDesc->dwMaxDataRate = USBD_CCID_MAX_DATA_RATE;
  pCCIDDesc->bNumDataRatesSupported = USBD_CCID_N_DATA_RATES;
  pCCIDDesc->dwMaxIFSD = 0U;
  pCCIDDesc->dwSynchProtocols = 0x00000007;
  pCCIDDesc->dwMechanical = 0U;
  pCCIDDesc->dwFeatures = 0x000407B8;
  pCCIDDesc->dwMaxCCIDMessageLength = USBD_CCID_MAX_BLOCK_SIZE_HEADER;
  pCCIDDesc->bClassGetResponse = 0xFF;
  pCCIDDesc->bClassEnvelope = 0xFF;
  pCCIDDesc->wLcdLayout = 0U;
  pCCIDDesc->bPINSupport = 0U;
  pCCIDDesc->bMaxCCIDBusySlots = USBD_CCID_MAX_BUSY_SLOTS;

  *Sze += (uint32_t)sizeof(USBD_CCIDDescTypedef);

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          USBD_EP_TYPE_BULK,  \
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                          (0x00U), (0x00U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          USBD_EP_TYPE_BULK,  \
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[1].size,
                          (0x00U), (0x00U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP(pdev->tclasslist[pdev->classId].Eps[2].add,
                          USBD_EP_TYPE_INTR, \
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[2].size,
                          USBD_CCID_EPINCMD_HS_BINTERVAL, USBD_CCID_EPINCMD_FS_BINTERVAL);

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength  = *Sze;

}
#endif /* USBD_CCID_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]
[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_PRINTER") && def_value == "1"]
#if USBD_PRINTER_CLASS_ACTIVATED == 1U
/**
  * @brief  USBD_FrameWork_PRINTER_Desc
  *         Configure and Append the CCID Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void  USBD_FrameWork_PRINTER_Desc(USBD_DevClassHandleTypeDef *pdev,
                                     uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef       *pIfDesc;
  static USBD_EpDescTypedef       *pEpDesc;

  /* Append Printer Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[0], 0U, \
                          (uint8_t)(pdev->tclasslist[pdev->classId].NumEps),
                          0x07U, 0x01U, USBD_PRNT_IF_PROTOCOL, 0U);

    /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[0].add),
                          USBD_EP_TYPE_BULK,  \
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[0].size,
                          (0x00U), (0x00U));

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[1].add),
                          USBD_EP_TYPE_BULK,  \
                          (uint16_t)pdev->tclasslist[pdev->classId].Eps[1].size,
                          (0x00U), (0x00U));

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += 1U;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength  = *Sze;

}
#endif /* USBD_PRINTER_CLASS_ACTIVATED */
[/#if]
[/#list]
[/#if]
[/#list]

[#list SWIPdatas as SWIP]
[#if SWIP.variables??]
[#list SWIP.variables as define]
	[#assign def_value = define.value]
	[#assign def_name = define.name]
[#if def_name?contains("UX_DEVICE_AUDIO_CORE") && def_value == "1"]



#if USBD_AUDIO_CLASS_ACTIVATED == 1
[#if USBD_AUDIO_CLASS_value == "0"]

/**
  * @brief  USBD_FrameWork_AUDIO10_Desc
  *         Configure and Append the AUDIO 1.0 Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_AUDIO10_Desc(USBD_DevClassHandleTypeDef *pdev,
                                        uint32_t pConf, uint32_t *Sze)
{
  static USBD_IfDescTypedef           *pIfDesc;
  static USBD_AUDIOCCSIfDescTypeDef   *pACCSIfDesc;
[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
  static USBD_AUDIOEpDataDescTypeDef  *pSpeakerASInterruptEpDesc;
[/#if]
  uint8_t interface_index = 0U;
  uint8_t endpoint_index = 0U;
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
  uint8_t play_freq_index = 0U;
[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  uint8_t record_freq_index = 0U;
[/#if]

#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef                   *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U
  static USBD_AUDIOInputTerminalDescTypeDef    *pSpeakerITDesc;
  static USBD_AUDIOFeatureUnitPlayDescTypeDef  *pSpeakerFUDesc;
  static USBD_AUDIOOutputTerminalDescTypeDef   *pSpeakerOTDesc;
  static USBD_AUDIOSCSIfDescTypeDef            *pSpeakerASCSIfDesc;
  static USBD_AUDIOSFormatIfDescTypeDef        *pSpeakerASFormatDesc;
  static USBD_AUDIOEpDataDescTypeDef           *pSpeakerASDataEpDesc;
  static USBD_AUDIOSCSEpDescTypeDef            *pSpeakerASCSEpDesc;
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
  static USBD_AUDIOEpDataDescTypeDef           *pSpeakerASFeedbackEpDesc;
[/#if]
#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */
[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
#if USBD_AUDIO_RECORDING_ACTIVATED == 1U
  static USBD_AUDIOInputTerminalDescTypeDef    *pMicrophoneITDesc;
  static USBD_AUDIOFeatureUnitRecordDescTypeDef*pMicrophoneFUDesc;
  static USBD_AUDIOOutputTerminalDescTypeDef   *pMicrophoneOTDesc;
  static USBD_AUDIOSCSIfDescTypeDef            *pMicrophoneASCSIfDesc;
  static USBD_AUDIOSFormatIfDescTypeDef        *pMicrophoneASFormatDesc;
  static USBD_AUDIOEpDataDescTypeDef           *pMicrophoneASDataEpDesc;
  static USBD_AUDIOSCSEpDescTypeDef            *pMicrophoneASCSEpDesc;
#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

#if USBD_COMPOSITE_USE_IAD == 1
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = UX_INTERFACE_ASSOCIATION_DESCRIPTOR_ITEM;
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
[#if (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false") ||
     (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true")]
  pIadDesc->bInterfaceCount = 0x02U;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pIadDesc->bInterfaceCount = 0x03U;
[/#if]
  pIadDesc->bFunctionClass = UX_DEVICE_CLASS_AUDIO_FUNCTION_CLASS;
  pIadDesc->bFunctionSubClass = UX_DEVICE_CLASS_AUDIO_FUNCTION_SUBCLASS_UNDEFINED;
  pIadDesc->bFunctionProtocol = UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED;
  pIadDesc->iFunction = 0U;
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Append AUDIO Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
                          0x01U,
#else /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
                          0x00U,
#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[#else]
                          0x00U,
[/#if]
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_CONTROL,
                          UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* Append AUDIO USB Class-specific AC Interface descriptor to Configuration descriptor */
  pACCSIfDesc = ((USBD_AUDIOCCSIfDescTypeDef *)(pConf + *Sze));
  pACCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOCCSIfDescTypeDef);
  pACCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pACCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_HEADER;
  pACCSIfDesc->bcdADC = 0x0100U;
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false"]
  pACCSIfDesc->wTotalLength = USBD_AUDIO_CONTROL_INTERFACE_SIZE;
  pACCSIfDesc->bInCollection = 0x01U;
  pACCSIfDesc->baInterfaceNr = interface_index;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pACCSIfDesc->wTotalLength = USBD_AUDIO_CONTROL_INTERFACE_SIZE;
  pACCSIfDesc->bInCollection = 0x01U;
  pACCSIfDesc->baInterfaceNr = interface_index;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pACCSIfDesc->wTotalLength = USBD_AUDIO_CONTROL_INTERFACE_SIZE;
  pACCSIfDesc->bInCollection = 0x02U;
  pACCSIfDesc->baInterfaceNr1 = interface_index;
  pACCSIfDesc->baInterfaceNr2 = interface_index+1;
[/#if]
  *Sze += (uint32_t)sizeof(USBD_AUDIOCCSIfDescTypeDef);

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U

  /* Append USB Speaker Input Terminal Descriptor to Configuration descriptor */
  pSpeakerITDesc = ((USBD_AUDIOInputTerminalDescTypeDef *)(pConf + *Sze));
  pSpeakerITDesc->bLength = (uint8_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);
  pSpeakerITDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerITDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_INPUT_TERMINAL;
  pSpeakerITDesc->bTerminalID = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerITDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_USB_STREAMING;
  pSpeakerITDesc->bAssocTerminal = 0x00U;
  pSpeakerITDesc->bNrChannels = USBD_AUDIO_PLAY_CHANNEL_COUNT;
  pSpeakerITDesc->bmChannelConfig = USBD_AUDIO_PLAY_CHANNEL_MAP;
  pSpeakerITDesc->iChannelNames = 0x00U;
  pSpeakerITDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);

  /* Append USB Speaker Audio Feature Unit Descriptor to Configuration descriptor */
  pSpeakerFUDesc = ((USBD_AUDIOFeatureUnitPlayDescTypeDef *)(pConf + *Sze));
  pSpeakerFUDesc->bLength = (uint8_t)sizeof(USBD_AUDIOFeatureUnitPlayDescTypeDef);
  pSpeakerFUDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerFUDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_FEATURE_UNIT;
  pSpeakerFUDesc->bUnitID = USBD_AUDIO_PLAY_FEATURE_UNIT_ID;
  pSpeakerFUDesc->bSourceID = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerFUDesc->bControlSize = 0x01U;
  pSpeakerFUDesc->bmaControls[0] = USBD_AUDIO_FU_CONTROL_MUTE|USBD_AUDIO_FU_CONTROL_VOLUME;
[#if usbd_audio_play_ch_num == "1"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
[#elseif usbd_audio_play_ch_num == "2"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
[#elseif usbd_audio_play_ch_num == "3"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
[#elseif usbd_audio_play_ch_num == "4"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
  pSpeakerFUDesc->bmaControls[4] = 0x00U;
[#elseif usbd_audio_play_ch_num == "5"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
  pSpeakerFUDesc->bmaControls[4] = 0x00U;
  pSpeakerFUDesc->bmaControls[5] = 0x00U;
[#elseif usbd_audio_play_ch_num == "6"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
  pSpeakerFUDesc->bmaControls[4] = 0x00U;
  pSpeakerFUDesc->bmaControls[5] = 0x00U;
  pSpeakerFUDesc->bmaControls[6] = 0x00U;
[#elseif usbd_audio_play_ch_num == "7"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
  pSpeakerFUDesc->bmaControls[4] = 0x00U;
  pSpeakerFUDesc->bmaControls[5] = 0x00U;
  pSpeakerFUDesc->bmaControls[6] = 0x00U;
  pSpeakerFUDesc->bmaControls[7] = 0x00U;
[#elseif usbd_audio_play_ch_num == "8"]
  pSpeakerFUDesc->bmaControls[1] = 0x00U;
  pSpeakerFUDesc->bmaControls[2] = 0x00U;
  pSpeakerFUDesc->bmaControls[3] = 0x00U;
  pSpeakerFUDesc->bmaControls[4] = 0x00U;
  pSpeakerFUDesc->bmaControls[5] = 0x00U;
  pSpeakerFUDesc->bmaControls[6] = 0x00U;
  pSpeakerFUDesc->bmaControls[7] = 0x00U;
  pSpeakerFUDesc->bmaControls[8] = 0x00U;
[/#if]
  pSpeakerFUDesc->iFeature = 0x00;
  *Sze += (uint32_t)sizeof(USBD_AUDIOFeatureUnitPlayDescTypeDef);

  /* Append USB Speaker Output Terminal Descriptor to Configuration descriptor */
  pSpeakerOTDesc = ((USBD_AUDIOOutputTerminalDescTypeDef *)(pConf + *Sze));
  pSpeakerOTDesc->bLength = (uint8_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);
  pSpeakerOTDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerOTDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_OUTPUT_TERMINAL;
  pSpeakerOTDesc->bTerminalID = USBD_AUDIO_PLAY_TERMINAL_OUTPUT_ID;
  pSpeakerOTDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_SPEAKER;
  pSpeakerOTDesc->bAssocTerminal = 0x00U;
  pSpeakerOTDesc->bSourceID = USBD_AUDIO_PLAY_FEATURE_UNIT_ID;
  pSpeakerOTDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);

#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */

[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
#if USBD_AUDIO_RECORDING_ACTIVATED == 1U

  /* Append USB Speaker Input Terminal Descriptor to Configuration descriptor */
  pMicrophoneITDesc = ((USBD_AUDIOInputTerminalDescTypeDef *)(pConf + *Sze));
  pMicrophoneITDesc->bLength = (uint8_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);
  pMicrophoneITDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneITDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_INPUT_TERMINAL;
  pMicrophoneITDesc->bTerminalID = USBD_AUDIO_RECORD_TERMINAL_INPUT_ID;
  pMicrophoneITDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_MICROPHONE;
  pMicrophoneITDesc->bAssocTerminal = 0x00U;
  pMicrophoneITDesc->bNrChannels = USBD_AUDIO_RECORD_CHANNEL_COUNT;
  pMicrophoneITDesc->bmChannelConfig = USBD_AUDIO_RECORD_CHANNEL_MAP;
  pMicrophoneITDesc->iChannelNames = 0x00U;
  pMicrophoneITDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);

  /* Append USB Microphone Audio Feature Unit Descriptor to Configuration descriptor */
  pMicrophoneFUDesc = ((USBD_AUDIOFeatureUnitRecordDescTypeDef *)(pConf + *Sze));
  pMicrophoneFUDesc->bLength = (uint8_t)sizeof(USBD_AUDIOFeatureUnitRecordDescTypeDef);
  pMicrophoneFUDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneFUDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_FEATURE_UNIT;
  pMicrophoneFUDesc->bUnitID = USBD_AUDIO_RECORD_FEATURE_UNIT_ID;
  pMicrophoneFUDesc->bSourceID = USBD_AUDIO_RECORD_TERMINAL_INPUT_ID;
  pMicrophoneFUDesc->bControlSize = 0x01U;
  pMicrophoneFUDesc->bmaControls[0] = USBD_AUDIO_FU_CONTROL_MUTE|USBD_AUDIO_FU_CONTROL_VOLUME;
[#if usbd_audio_record_ch_num == "1"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
[#elseif usbd_audio_record_ch_num == "2"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
[#elseif usbd_audio_record_ch_num == "3"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
[#elseif usbd_audio_record_ch_num == "4"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00U;
[#elseif usbd_audio_record_ch_num == "5"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00U;
[#elseif usbd_audio_record_ch_num == "6"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00U;
[#elseif usbd_audio_record_ch_num == "7"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00U;
  pMicrophoneFUDesc->bmaControls[7] = 0x00U;
[#elseif usbd_audio_record_ch_num == "8"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00U;
  pMicrophoneFUDesc->bmaControls[7] = 0x00U;
  pMicrophoneFUDesc->bmaControls[8] = 0x00U;
[/#if]
  pMicrophoneFUDesc->iFeature = 0x00;
  *Sze += (uint32_t)sizeof(USBD_AUDIOFeatureUnitRecordDescTypeDef);

  /* Append USB Microphone Output Terminal Descriptor to Configuration descriptor */
  pMicrophoneOTDesc = ((USBD_AUDIOOutputTerminalDescTypeDef *)(pConf + *Sze));
  pMicrophoneOTDesc->bLength = (uint8_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);
  pMicrophoneOTDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneOTDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_OUTPUT_TERMINAL;
  pMicrophoneOTDesc->bTerminalID = USBD_AUDIO_RECORD_TERMINAL_OUTPUT_ID;
  pMicrophoneOTDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_USB_STREAMING;
  pMicrophoneOTDesc->bAssocTerminal = 0x00U;
  pMicrophoneOTDesc->bSourceID = USBD_AUDIO_RECORD_FEATURE_UNIT_ID;
  pMicrophoneOTDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);

#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT

  /* Append Endpoint Interrupt descriptor to Configuration descriptor */
  pSpeakerASInterruptEpDesc = ((USBD_AUDIOEpDataDescTypeDef *)(pConf + *Sze));
  pSpeakerASInterruptEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOEpDataDescTypeDef);
  pSpeakerASInterruptEpDesc->bDescriptorType = UX_ENDPOINT_DESCRIPTOR_ITEM;
  pSpeakerASInterruptEpDesc->bEndpointAddress = pdev->tclasslist[pdev->classId].Eps[endpoint_index].add;
  pSpeakerASInterruptEpDesc->bmAttributes = pdev->tclasslist[pdev->classId].Eps[endpoint_index].type;
  pSpeakerASInterruptEpDesc->wMaxPacketSize = (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size);
  pSpeakerASInterruptEpDesc->bInterval = USBD_AUDIO_INTERRUPT_EPIN_FS_BINTERVAL;
  pSpeakerASInterruptEpDesc->bRefresh = 0x01U;
  pSpeakerASInterruptEpDesc->bSynchAddress = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOEpDataDescTypeDef);

  /* Increment endpoint index */
  endpoint_index++;

#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */

[/#if]

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U

  /* USB Speaker Standard AS Interface Descriptor - Audio Streaming Zero Bandwidth */
  /* Interface 1, Alternate Setting 0 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
                          0x00U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED,
                          0x00U);

  /* USB Speaker Standard AS Interface Descriptor - Audio Streaming Operational */
  /* Interface 1, Alternate Setting 1 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x01U,
#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT
                          0x02U,
#else /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
                          0x01U,
#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* USB Speaker Audio Streaming Class-Specific Interface Descriptor */
  pSpeakerASCSIfDesc = ((USBD_AUDIOSCSIfDescTypeDef *)(pConf + *Sze));
  pSpeakerASCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);
  pSpeakerASCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerASCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_GENERAL;
  pSpeakerASCSIfDesc->bTerminalLink = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerASCSIfDesc->bDelay = 0x01U;
  pSpeakerASCSIfDesc->wFormatTag = 0x0001U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);
  
  /* USB Speaker Audio Format Interface Descriptor */
  pSpeakerASFormatDesc = ((USBD_AUDIOSFormatIfDescTypeDef *)(pConf + *Sze));
  pSpeakerASFormatDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);
  pSpeakerASFormatDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerASFormatDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_FORMAT_TYPE;
  pSpeakerASFormatDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pSpeakerASFormatDesc->bNrChannels = USBD_AUDIO_PLAY_CHANNEL_COUNT;
  pSpeakerASFormatDesc->bSubFrameSize = USBD_AUDIO_PLAY_RES_BYTE;
  pSpeakerASFormatDesc->bBitResolution = USBD_AUDIO_PLAY_RES_BIT;
  pSpeakerASFormatDesc->bSamFreqType = USBD_AUDIO_PLAY_FREQ_COUNT;

  for(play_freq_index = 0U; play_freq_index < USBD_AUDIO_PLAY_FREQ_COUNT; play_freq_index++)
  {
    pSpeakerASFormatDesc->tSamFreq[play_freq_index].tSamFreq2 =
      (uint8_t)UX_DW0(USBD_AUDIO10_PLAYBACK_FREQENCIES[play_freq_index]);
    pSpeakerASFormatDesc->tSamFreq[play_freq_index].tSamFreq1 =
      (uint8_t)UX_DW1(USBD_AUDIO10_PLAYBACK_FREQENCIES[play_freq_index]);
    pSpeakerASFormatDesc->tSamFreq[play_freq_index].tSamFreq0 =
      (uint8_t)UX_DW2(USBD_AUDIO10_PLAYBACK_FREQENCIES[play_freq_index]);
  }

  *Sze += (uint32_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);

  /* Append Endpoint Data descriptor to Configuration descriptor */
  pSpeakerASDataEpDesc = ((USBD_AUDIOEpDataDescTypeDef *)(pConf + *Sze));
  pSpeakerASDataEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOEpDataDescTypeDef);
  pSpeakerASDataEpDesc->bDescriptorType = UX_ENDPOINT_DESCRIPTOR_ITEM;
  pSpeakerASDataEpDesc->bEndpointAddress = pdev->tclasslist[pdev->classId].Eps[endpoint_index].add;
  pSpeakerASDataEpDesc->bmAttributes = pdev->tclasslist[pdev->classId].Eps[endpoint_index].type;
  pSpeakerASDataEpDesc->wMaxPacketSize = (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size);
  pSpeakerASDataEpDesc->bInterval = USBD_AUDIO_PLAY_EPOUT_FS_BINTERVAL;
  pSpeakerASDataEpDesc->bRefresh = 0x00U;
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]
  pSpeakerASDataEpDesc->bSynchAddress = pdev->tclasslist[pdev->classId].Eps[endpoint_index+1].add;
[#else]
  pSpeakerASDataEpDesc->bSynchAddress = 0x00U;
[/#if]
  *Sze += (uint32_t)sizeof(USBD_AUDIOEpDataDescTypeDef);

  /* Increment endpoint index */
  endpoint_index++;

  /* USB Speaker Audio Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
  pSpeakerASCSEpDesc = ((USBD_AUDIOSCSEpDescTypeDef *)(pConf + *Sze));
  pSpeakerASCSEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);
  pSpeakerASCSEpDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_ENDPOINT;
  pSpeakerASCSEpDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_EP_GENERAL;
#ifdef USBD_AUDIO_PLAY_MULTI_FREQUENCIES
  pSpeakerASCSEpDesc->bmAttributes = UX_DEVICE_CLASS_AUDIO10_EP_SAMPLING_FREQ_CONTROL;
  pSpeakerASCSEpDesc->bLockDelayUnits = 0x00U;
  pSpeakerASCSEpDesc->wLockDelay = 0x00U;
#else /* USBD_AUDIO_PLAY_MULTI_FREQUENCIES */
  pSpeakerASCSEpDesc->bmAttributes = 0x00U;
  pSpeakerASCSEpDesc->bLockDelayUnits = 0x00U;
  pSpeakerASCSEpDesc->wLockDelay = 0x00U;
#endif /* USBD_AUDIO_PLAY_MULTI_FREQUENCIES */
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1"]

#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT

  /* Append Endpoint feedback descriptor to Configuration descriptor */
  pSpeakerASFeedbackEpDesc = ((USBD_AUDIOEpDataDescTypeDef *)(pConf + *Sze));
  pSpeakerASFeedbackEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOEpDataDescTypeDef);
  pSpeakerASFeedbackEpDesc->bDescriptorType = UX_ENDPOINT_DESCRIPTOR_ITEM;
  pSpeakerASFeedbackEpDesc->bEndpointAddress = pdev->tclasslist[pdev->classId].Eps[endpoint_index].add;
  pSpeakerASFeedbackEpDesc->bmAttributes = pdev->tclasslist[pdev->classId].Eps[endpoint_index].type;
  pSpeakerASFeedbackEpDesc->wMaxPacketSize = (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size);
  pSpeakerASFeedbackEpDesc->bInterval = USBD_AUDIO_PLAY_EP_FEEDBACK_FS_BINTERVAL;
  pSpeakerASFeedbackEpDesc->bRefresh = 0x07U;
  pSpeakerASFeedbackEpDesc->bSynchAddress = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOEpDataDescTypeDef);

#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */

[/#if]

#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */
[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]

#if USBD_AUDIO_RECORDING_ACTIVATED == 1U

  /* USB Microphone Standard AS Interface Descriptor - Audio Streaming Zero Bandwidth */
  /* Interface 1, Alternate Setting 0 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
                          0x00U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED,
                          0x00U);

  /* USB Microphone Standard AS Interface Descriptor - Audio Streaming Operational */
  /* Interface 1, Alternate Setting 1 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x01U,
                          0x01U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUDIO_PROTOCOL_UNDEFINED,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* USB Microphone Audio Streaming Class-Specific Interface Descriptor */
  pMicrophoneASCSIfDesc = ((USBD_AUDIOSCSIfDescTypeDef *)(pConf + *Sze));
  pMicrophoneASCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);
  pMicrophoneASCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneASCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_GENERAL;
  pMicrophoneASCSIfDesc->bTerminalLink = USBD_AUDIO_RECORD_TERMINAL_OUTPUT_ID;
  pMicrophoneASCSIfDesc->bDelay = 0x01U;
  pMicrophoneASCSIfDesc->wFormatTag = 0x0001U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);

  /* USB Microphone Audio Format Interface Descriptor */
  pMicrophoneASFormatDesc = ((USBD_AUDIOSFormatIfDescTypeDef *)(pConf + *Sze));
  pMicrophoneASFormatDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);
  pMicrophoneASFormatDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneASFormatDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_FORMAT_TYPE;
  pMicrophoneASFormatDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pMicrophoneASFormatDesc->bNrChannels = USBD_AUDIO_RECORD_CHANNEL_COUNT;
  pMicrophoneASFormatDesc->bSubFrameSize = USBD_AUDIO_RECORD_RES_BYTE;
  pMicrophoneASFormatDesc->bBitResolution = USBD_AUDIO_RECORD_RES_BIT;
  pMicrophoneASFormatDesc->bSamFreqType = USBD_AUDIO_RECORD_FREQ_COUNT;

  for(record_freq_index = 0U; record_freq_index < USBD_AUDIO_RECORD_FREQ_COUNT; record_freq_index++)
  {
    pMicrophoneASFormatDesc->tSamFreq[record_freq_index].tSamFreq2 =
      (uint8_t)UX_DW0(USBD_AUDIO10_RECORDING_FREQENCIES[record_freq_index]);
    pMicrophoneASFormatDesc->tSamFreq[record_freq_index].tSamFreq1 =
      (uint8_t)UX_DW1(USBD_AUDIO10_RECORDING_FREQENCIES[record_freq_index]);
    pMicrophoneASFormatDesc->tSamFreq[record_freq_index].tSamFreq0 =
      (uint8_t)UX_DW2(USBD_AUDIO10_RECORDING_FREQENCIES[record_freq_index]);
  }

  *Sze += (uint32_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);

  /* Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
  pMicrophoneASDataEpDesc = ((USBD_AUDIOEpDataDescTypeDef *)(pConf + *Sze));
  pMicrophoneASDataEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOEpDataDescTypeDef);
  pMicrophoneASDataEpDesc->bDescriptorType = UX_ENDPOINT_DESCRIPTOR_ITEM;
  pMicrophoneASDataEpDesc->bEndpointAddress = pdev->tclasslist[pdev->classId].Eps[endpoint_index].add;
  pMicrophoneASDataEpDesc->bmAttributes = pdev->tclasslist[pdev->classId].Eps[endpoint_index].type;
  pMicrophoneASDataEpDesc->wMaxPacketSize = (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size);
  pMicrophoneASDataEpDesc->bInterval = USBD_AUDIO_RECORD_EPIN_FS_BINTERVAL;
  pMicrophoneASDataEpDesc->bRefresh = 0x00U;
  pMicrophoneASDataEpDesc->bSynchAddress = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOEpDataDescTypeDef);

  /* Increment endpoint index */
  endpoint_index++;

  /* USB Speaker Audio Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
  pMicrophoneASCSEpDesc = ((USBD_AUDIOSCSEpDescTypeDef *)(pConf + *Sze));
  pMicrophoneASCSEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);
  pMicrophoneASCSEpDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_ENDPOINT;
  pMicrophoneASCSEpDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_EP_GENERAL;
#ifdef USBD_AUDIO_RECORD_MULTI_FREQUENCIES
  pMicrophoneASCSEpDesc->bmAttributes = UX_DEVICE_CLASS_AUDIO10_EP_SAMPLING_FREQ_CONTROL;
#else /* USBD_AUDIO_RECORD_MULTI_FREQUENCIES */
  pMicrophoneASCSEpDesc->bmAttributes = 0x00U;
#endif /* USBD_AUDIO_RECORD_MULTI_FREQUENCIES */
  pMicrophoneASCSEpDesc->bLockDelayUnits = 0x00U;
  pMicrophoneASCSEpDesc->wLockDelay = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);

#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += interface_index;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;
}

[#else]

/**
  * @brief  USBD_FrameWork_AUDIO20_Desc
  *         Configure and Append the AUDIO 2.0 Descriptor
  * @param  pdev: device instance
  * @param  pConf: Configuration descriptor pointer
  * @param  Sze: pointer to the current configuration descriptor size
  * @retval None
  */
static void USBD_FrameWork_AUDIO20_Desc(USBD_DevClassHandleTypeDef *pdev,
                                        uint32_t pConf, uint32_t *Sze)
{

  static USBD_IfDescTypedef       *pIfDesc;
  static USBD_EpDescTypedef       *pEpDesc;
  uint8_t interface_index = 0U;
  uint8_t endpoint_index = 0U;

#if USBD_COMPOSITE_USE_IAD == 1
  static USBD_IadDescTypedef                    *pIadDesc;
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  static USBD_AUDIOCCSIfDescTypeDef             *pACCSIfDesc;

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U
  static USBD_AUDIOClockSourceDescTypeDef       *pSpeakerCSDesc;
  static USBD_AUDIOInputTerminalDescTypeDef     *pSpeakerITDesc;
  static USBD_AUDIOFeatureUnitPlayDescTypeDef   *pSpeakerFUDesc;
  static USBD_AUDIOOutputTerminalDescTypeDef    *pSpeakerOTDesc;
  static USBD_AUDIOSCSIfDescTypeDef             *pSpeakerASCSIfDesc;
  static USBD_AUDIOSFormatIfDescTypeDef         *pSpeakerASFormatDesc;
  static USBD_AUDIOSCSEpDescTypeDef             *pSpeakerASCSEpDesc;
#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */
[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
#if USBD_AUDIO_RECORDING_ACTIVATED == 1U
  static USBD_AUDIOClockSourceDescTypeDef       *pMicrophoneCSDesc;
  static USBD_AUDIOInputTerminalDescTypeDef     *pMicrophoneITDesc;
  static USBD_AUDIOFeatureUnitRecordDescTypeDef *pMicrophoneFUDesc;
  static USBD_AUDIOOutputTerminalDescTypeDef    *pMicrophoneOTDesc;
  static USBD_AUDIOSCSIfDescTypeDef             *pMicrophoneASCSIfDesc;
  static USBD_AUDIOSFormatIfDescTypeDef         *pMicrophoneASFormatDesc;
  static USBD_AUDIOSCSEpDescTypeDef             *pMicrophoneASCSEpDesc;
#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

#if USBD_COMPOSITE_USE_IAD == 1
  pIadDesc = ((USBD_IadDescTypedef *)(pConf + *Sze));
  pIadDesc->bLength = (uint8_t)sizeof(USBD_IadDescTypedef);
  pIadDesc->bDescriptorType = USB_DESC_TYPE_IAD;
  pIadDesc->bFirstInterface = pdev->tclasslist[pdev->classId].Ifs[0];
[#if (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false") ||
     (UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true")]
  pIadDesc->bInterfaceCount = 0x02U;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pIadDesc->bInterfaceCount = 0x03U;
[/#if]
  pIadDesc->bFunctionClass = UX_DEVICE_CLASS_AUDIO_FUNCTION_CLASS;
  pIadDesc->bFunctionSubClass = UX_DEVICE_CLASS_AUDIO_FUNCTION_SUBCLASS_UNDEFINED;
  pIadDesc->bFunctionProtocol = UX_DEVICE_CLASS_AUDIO_FUNCTION_PROTOCOL_VERSION_02_00;
  pIadDesc->iFunction = 0U; /* String Index */
  *Sze += (uint32_t)sizeof(USBD_IadDescTypedef);
#endif /* USBD_COMPOSITE_USE_IAD == 1 */

  /* Append AUDIO Interface descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT
                          0x01U,
#else /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
                          0x00U,
#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */
[#else]
                          0x00U,
[/#if]
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_CONTROL,
                          UX_DEVICE_CLASS_AUTIO_PROTOCOL_VERSION_02_00,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* Append AUDIO USB Class-specific AC Interface descriptor to Configuration descriptor */
  pACCSIfDesc = ((USBD_AUDIOCCSIfDescTypeDef *)(pConf + *Sze));
  pACCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOCCSIfDescTypeDef);
  pACCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pACCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_HEADER;
  pACCSIfDesc->bcdADC = 0x0200U;
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "false"]
  pACCSIfDesc->bCategory = UX_DEVICE_CLASS_AUDIO20_CATEGORY_DESKTOP_SPEAKER;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "false" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pACCSIfDesc->bCategory = UX_DEVICE_CLASS_AUDIO20_CATEGORY_MICROPHONE;
[#elseif UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true" && UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
  pACCSIfDesc->bCategory = UX_DEVICE_CLASS_AUDIO20_CATEGORY_I_O_BOX;
[/#if]
  pACCSIfDesc->wTotalLength = USBD_AUDIO_CONTROL_INTERFACE_SIZE;
  pACCSIfDesc->bmControls = 0x00;
  *Sze += (uint32_t)sizeof(USBD_AUDIOCCSIfDescTypeDef);

[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U

  /* Append USB Speaker Clock Source Descriptor to Configuration descriptor */
  pSpeakerCSDesc = ((USBD_AUDIOClockSourceDescTypeDef *)(pConf + *Sze));
  pSpeakerCSDesc->bLength = (uint8_t)sizeof(USBD_AUDIOClockSourceDescTypeDef);
  pSpeakerCSDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerCSDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO20_AC_CLOCK_SOURCE;
  pSpeakerCSDesc->bClockID = USBD_AUDIO_PLAY_CLOCK_SOURCE_ID;
#if USBD_AUDIO_PLAYBACK_MULTI_FREQUENCIES == 1U
  pSpeakerCSDesc->bmAttributes = 0x03U;
  pSpeakerCSDesc->bmControls = 0x07U;
#else /* USBD_AUDIO_PLAYBACK_MULTI_FREQUENCIES == 1U */
  pSpeakerCSDesc->bmAttributes = 0x01U;
  pSpeakerCSDesc->bmControls = 0x01U;
#endif /* USBD_AUDIO_PLAYBACK_MULTI_FREQUENCIES == 1U */
  pSpeakerCSDesc->bAssocTerminal = 0x00U;
  pSpeakerCSDesc->iClockSource = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOClockSourceDescTypeDef);

  /* Append USB Speaker Input Terminal Descriptor to Configuration descriptor */
  pSpeakerITDesc = ((USBD_AUDIOInputTerminalDescTypeDef *)(pConf + *Sze));
  pSpeakerITDesc->bLength = (uint8_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);
  pSpeakerITDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerITDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_INPUT_TERMINAL;
  pSpeakerITDesc->bTerminalID = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerITDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_USB_STREAMING;
  pSpeakerITDesc->bAssocTerminal = 0x00U;
  pSpeakerITDesc->bCSourceID = USBD_AUDIO_PLAY_CLOCK_SOURCE_ID;
  pSpeakerITDesc->bNrChannels = USBD_AUDIO_PLAY_CHANNEL_COUNT;
  pSpeakerITDesc->bmChannelConfig = USBD_AUDIO_PLAY_CHANNEL_MAP;
  pSpeakerITDesc->iChannelNames = 0x00U;
  pSpeakerITDesc->bmControls = 0x0000U;
  pSpeakerITDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);

  /* Append USB Speaker Audio Feature Unit Descriptor to Configuration descriptor */
  pSpeakerFUDesc = ((USBD_AUDIOFeatureUnitPlayDescTypeDef *)(pConf + *Sze));
  pSpeakerFUDesc->bLength = (uint8_t)sizeof(USBD_AUDIOFeatureUnitPlayDescTypeDef);
  pSpeakerFUDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerFUDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_FEATURE_UNIT;
  pSpeakerFUDesc->bUnitID = USBD_AUDIO_PLAY_FEATURE_UNIT_ID;
  pSpeakerFUDesc->bSourceID = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerFUDesc->bmaControls[0] = USBD_AUDIO_FU_CONTROL_MUTE|USBD_AUDIO_FU_CONTROL_VOLUME;
[#if usbd_audio_play_ch_num == "1"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "2"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "3"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "4"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[4] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "5"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[4] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[5] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "6"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[4] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[5] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[6] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "7"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[4] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[5] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[6] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[7] = 0x00000000U;
[#elseif usbd_audio_play_ch_num == "8"]
  pSpeakerFUDesc->bmaControls[1] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[2] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[3] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[4] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[5] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[6] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[7] = 0x00000000U;
  pSpeakerFUDesc->bmaControls[8] = 0x00000000U;
[/#if]
  pSpeakerFUDesc->iFeature = 0x00;
  *Sze += (uint32_t)sizeof(USBD_AUDIOFeatureUnitPlayDescTypeDef);

  /* Append USB Speaker Output Terminal Descriptor to Configuration descriptor */
  pSpeakerOTDesc = ((USBD_AUDIOOutputTerminalDescTypeDef *)(pConf + *Sze));
  pSpeakerOTDesc->bLength = (uint8_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);
  pSpeakerOTDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerOTDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_OUTPUT_TERMINAL;
  pSpeakerOTDesc->bTerminalID = USBD_AUDIO_PLAY_TERMINAL_OUTPUT_ID;
  pSpeakerOTDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_SPEAKER;
  pSpeakerOTDesc->bAssocTerminal = 0x00U;
  pSpeakerOTDesc->bSourceID = USBD_AUDIO_PLAY_FEATURE_UNIT_ID;
  pSpeakerOTDesc->bCSourceID = USBD_AUDIO_PLAY_CLOCK_SOURCE_ID;
  pSpeakerOTDesc->bmaControls = 0x0000U;
  pSpeakerOTDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);

#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */
[/#if]

[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
#if USBD_AUDIO_RECORDING_ACTIVATED == 1U

  /* Append USB Microphone Clock Source Descriptor to Configuration descriptor */
  pMicrophoneCSDesc = ((USBD_AUDIOClockSourceDescTypeDef *)(pConf + *Sze));
  pMicrophoneCSDesc->bLength = (uint8_t)sizeof(USBD_AUDIOClockSourceDescTypeDef);
  pMicrophoneCSDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneCSDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO20_AC_CLOCK_SOURCE;
  pMicrophoneCSDesc->bClockID = USBD_AUDIO_RECORD_CLOCK_SOURCE_ID;
#if USBD_AUDIO_RECORDING_MULTI_FREQUENCIES == 1U
  pMicrophoneCSDesc->bmAttributes = 0x03U;
  pMicrophoneCSDesc->bmControls = 0x07U;
#else /* USBD_AUDIO_RECORDING_MULTI_FREQUENCIES == 1U */
  pMicrophoneCSDesc->bmAttributes = 0x01U;
  pMicrophoneCSDesc->bmControls = 0x01U;
#endif /* USBD_AUDIO_RECORDING_MULTI_FREQUENCIES == 1U */
  pMicrophoneCSDesc->bAssocTerminal = 0x00U;
  pMicrophoneCSDesc->iClockSource = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOClockSourceDescTypeDef);

  /* Append USB Microphone Input Terminal Descriptor to Configuration descriptor */
  pMicrophoneITDesc = ((USBD_AUDIOInputTerminalDescTypeDef *)(pConf + *Sze));
  pMicrophoneITDesc->bLength = (uint8_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);
  pMicrophoneITDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneITDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_INPUT_TERMINAL;
  pMicrophoneITDesc->bTerminalID = USBD_AUDIO_RECORD_TERMINAL_INPUT_ID;
  pMicrophoneITDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_MICROPHONE;
  pMicrophoneITDesc->bAssocTerminal = 0x00U;
  pMicrophoneITDesc->bCSourceID = USBD_AUDIO_RECORD_CLOCK_SOURCE_ID;
  pMicrophoneITDesc->bNrChannels = USBD_AUDIO_RECORD_CHANNEL_COUNT;
  pMicrophoneITDesc->bmChannelConfig = USBD_AUDIO_RECORD_CHANNEL_MAP;
  pMicrophoneITDesc->iChannelNames = 0x00U;
  pMicrophoneITDesc->bmControls = 0x0000U;
  pMicrophoneITDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOInputTerminalDescTypeDef);

  /* Append USB Microphone Audio Feature Unit Descriptor to Configuration descriptor */
  pMicrophoneFUDesc = ((USBD_AUDIOFeatureUnitRecordDescTypeDef *)(pConf + *Sze));
  pMicrophoneFUDesc->bLength = (uint8_t)sizeof(USBD_AUDIOFeatureUnitRecordDescTypeDef);
  pMicrophoneFUDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneFUDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_FEATURE_UNIT;
  pMicrophoneFUDesc->bUnitID = USBD_AUDIO_RECORD_FEATURE_UNIT_ID;
  pMicrophoneFUDesc->bSourceID = USBD_AUDIO_RECORD_TERMINAL_INPUT_ID;
  pMicrophoneFUDesc->bmaControls[0] = USBD_AUDIO_FU_CONTROL_MUTE|USBD_AUDIO_FU_CONTROL_VOLUME;
[#if usbd_audio_record_ch_num == "1"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "2"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "3"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "4"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "5"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "6"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "7"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[7] = 0x00000000U;
[#elseif usbd_audio_record_ch_num == "8"]
  pMicrophoneFUDesc->bmaControls[1] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[2] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[3] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[4] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[5] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[6] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[7] = 0x00000000U;
  pMicrophoneFUDesc->bmaControls[8] = 0x00000000U;
[/#if]
  pMicrophoneFUDesc->iFeature = 0x00;
  *Sze += (uint32_t)sizeof(USBD_AUDIOFeatureUnitRecordDescTypeDef);

  /* Append USB Microphone Output Terminal Descriptor to Configuration descriptor */
  pMicrophoneOTDesc = ((USBD_AUDIOOutputTerminalDescTypeDef *)(pConf + *Sze));
  pMicrophoneOTDesc->bLength = (uint8_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);
  pMicrophoneOTDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneOTDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AC_OUTPUT_TERMINAL;
  pMicrophoneOTDesc->bTerminalID = USBD_AUDIO_RECORD_TERMINAL_OUTPUT_ID;
  pMicrophoneOTDesc->wTerminalType = UX_DEVICE_CLASS_AUDIO_USB_STREAMING;
  pMicrophoneOTDesc->bAssocTerminal = 0x00U;
  pMicrophoneOTDesc->bSourceID = USBD_AUDIO_RECORD_FEATURE_UNIT_ID;
  pMicrophoneOTDesc->bCSourceID = USBD_AUDIO_RECORD_CLOCK_SOURCE_ID;
  pMicrophoneOTDesc->bmaControls = 0x0000U;
  pMicrophoneOTDesc->iTerminal = 0x00U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOOutputTerminalDescTypeDef);

#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

[#if UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT_value == "1"]
#ifdef UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT

  /* Append Standard AC Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[endpoint_index].add),
                          (pdev->tclasslist[pdev->classId].Eps[endpoint_index].type),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size),
                          USBD_AUDIO_INTERRUPT_EPIN_HS_BINTERVAL,
                          USBD_AUDIO_INTERRUPT_EPIN_FS_BINTERVAL);

  /* Increment endpoint index */
  endpoint_index++;

#endif /* UX_DEVICE_CLASS_AUDIO_INTERRUPT_SUPPORT */

[/#if]
[#if UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#if USBD_AUDIO_PLAYBACK_ACTIVATED == 1U

  /* USB Speaker Standard AS Interface Descriptor - Audio Streaming Zero Bandwidth */
  /* Interface 1, Alternate Setting 0 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
                          0x00U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUTIO_PROTOCOL_VERSION_02_00,
                          0x00U);

  /* USB Speaker Standard AS Interface Descriptor - Audio Streaming Operational */
  /* Interface 1, Alternate Setting 1 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x01U,
[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]
#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT
                          0x02U,
#else /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
                          0x01U,
#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */
[#else]
                          0x01U,
[/#if]
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUTIO_PROTOCOL_VERSION_02_00,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* USB Speaker Audio Streaming Class-Specific Interface Descriptor */
  pSpeakerASCSIfDesc = ((USBD_AUDIOSCSIfDescTypeDef *)(pConf + *Sze));
  pSpeakerASCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);
  pSpeakerASCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerASCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_GENERAL;
  pSpeakerASCSIfDesc->bTerminalLink = USBD_AUDIO_PLAY_TERMINAL_INPUT_ID;
  pSpeakerASCSIfDesc->bmControls = 0x00U;
  pSpeakerASCSIfDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pSpeakerASCSIfDesc->bmFormats = 0x00000001U;
  pSpeakerASCSIfDesc->bNrChannels = USBD_AUDIO_PLAY_CHANNEL_COUNT;
  pSpeakerASCSIfDesc->bmChannelConfig = USBD_AUDIO_PLAY_CHANNEL_MAP;
  pSpeakerASCSIfDesc->iChannelNames = 0x0000U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);

  /* USB Speaker Audio Format Interface Descriptor */
  pSpeakerASFormatDesc = ((USBD_AUDIOSFormatIfDescTypeDef *)(pConf + *Sze));
  pSpeakerASFormatDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);
  pSpeakerASFormatDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pSpeakerASFormatDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_FORMAT_TYPE;
  pSpeakerASFormatDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pSpeakerASFormatDesc->bSubslotSize = USBD_AUDIO_PLAY_RES_BYTE;
  pSpeakerASFormatDesc->bBitResolution = USBD_AUDIO_PLAY_RES_BIT;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[endpoint_index].add),
                          (pdev->tclasslist[pdev->classId].Eps[endpoint_index].type),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size),
                          USBD_AUDIO_PLAY_EPOUT_HS_BINTERVAL,
                          USBD_AUDIO_PLAY_EPOUT_FS_BINTERVAL);

  /* Increment endpoint index */
  endpoint_index++;

  /* USB Speaker Audio Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
  pSpeakerASCSEpDesc = ((USBD_AUDIOSCSEpDescTypeDef *)(pConf + *Sze));
  pSpeakerASCSEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);
  pSpeakerASCSEpDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_ENDPOINT;
  pSpeakerASCSEpDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_EP_GENERAL;
  pSpeakerASCSEpDesc->bmAttributes = 0x00U;
  pSpeakerASCSEpDesc->bmControls = 0x00U;
  pSpeakerASCSEpDesc->bLockDelayUnits = 0x00U;
  pSpeakerASCSEpDesc->wLockDelay = 0x0000U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);

[#if UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT_value == "1" && UX_DEVICE_AUDIO_PLAY_ENABLED_Value == "true"]

#ifdef UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[endpoint_index].add),
                          (pdev->tclasslist[pdev->classId].Eps[endpoint_index].type),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size),
                          USBD_AUDIO_PLAY_EP_FEEDBACK_HS_BINTERVAL,
                          USBD_AUDIO_PLAY_EP_FEEDBACK_FS_BINTERVAL);

#endif /* UX_DEVICE_CLASS_AUDIO_FEEDBACK_SUPPORT */

[/#if]
#endif /* USBD_AUDIO_PLAYBACK_ACTIVATED == 1 */
[/#if]
[#if UX_DEVICE_AUDIO_RECORD_ENABLED_Value == "true"]
#if USBD_AUDIO_RECORDING_ACTIVATED == 1U

  /* USB Microphone Standard AS Interface Descriptor - Audio Streaming Zero Bandwidth */
  /* Interface 1, Alternate Setting 0 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x00U,
                          0x00U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUTIO_PROTOCOL_VERSION_02_00,
                          0x00U);

  /* USB Microphone Standard AS Interface Descriptor - Audio Streaming Operational */
  /* Interface 1, Alternate Setting 1 */
  __USBD_FRAMEWORK_SET_IF(pdev->tclasslist[pdev->classId].Ifs[interface_index],
                          0x01U,
                          0x01U,
                          UX_DEVICE_CLASS_AUDIO_CLASS,
                          UX_DEVICE_CLASS_AUDIO_SUBCLASS_AUDIOSTREAMING,
                          UX_DEVICE_CLASS_AUTIO_PROTOCOL_VERSION_02_00,
                          0x00U);

  /* Increment interface index */
  interface_index++;

  /* USB Microphone Audio Streaming Class-Specific Interface Descriptor */
  pMicrophoneASCSIfDesc = ((USBD_AUDIOSCSIfDescTypeDef *)(pConf + *Sze));
  pMicrophoneASCSIfDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);
  pMicrophoneASCSIfDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneASCSIfDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_GENERAL;
  pMicrophoneASCSIfDesc->bTerminalLink = USBD_AUDIO_RECORD_TERMINAL_OUTPUT_ID;
  pMicrophoneASCSIfDesc->bmControls = 0x00U;
  pMicrophoneASCSIfDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pMicrophoneASCSIfDesc->bmFormats = 0x00000001U;
  pMicrophoneASCSIfDesc->bNrChannels = USBD_AUDIO_RECORD_CHANNEL_COUNT;
  pMicrophoneASCSIfDesc->bmChannelConfig = USBD_AUDIO_RECORD_CHANNEL_MAP;
  pMicrophoneASCSIfDesc->iChannelNames = 0x0000U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSIfDescTypeDef);

  /* USB Microphone Audio Format Interface Descriptor */
  pMicrophoneASFormatDesc = ((USBD_AUDIOSFormatIfDescTypeDef *)(pConf + *Sze));
  pMicrophoneASFormatDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);
  pMicrophoneASFormatDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_INTERFACE;
  pMicrophoneASFormatDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_AS_FORMAT_TYPE;
  pMicrophoneASFormatDesc->bFormatType = UX_DEVICE_CLASS_AUDIO_FORMAT_TYPE_I;
  pMicrophoneASFormatDesc->bSubslotSize = USBD_AUDIO_RECORD_RES_BYTE;
  pMicrophoneASFormatDesc->bBitResolution = USBD_AUDIO_RECORD_RES_BIT;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSFormatIfDescTypeDef);

  /* Append Endpoint descriptor to Configuration descriptor */
  __USBD_FRAMEWORK_SET_EP((pdev->tclasslist[pdev->classId].Eps[endpoint_index].add),
                          (pdev->tclasslist[pdev->classId].Eps[endpoint_index].type),
                          (uint16_t)(pdev->tclasslist[pdev->classId].Eps[endpoint_index].size),
                          USBD_AUDIO_RECORD_EPIN_HS_BINTERVAL,
                          USBD_AUDIO_RECORD_EPIN_FS_BINTERVAL);

  /* Increment endpoint index */
  endpoint_index++;

  /* Class-Specific AS Isochronous Audio Data Endpoint Descriptor */
  pMicrophoneASCSEpDesc = ((USBD_AUDIOSCSEpDescTypeDef *)(pConf + *Sze));
  pMicrophoneASCSEpDesc->bLength = (uint8_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);
  pMicrophoneASCSEpDesc->bDescriptorType = UX_DEVICE_CLASS_AUDIO_CS_ENDPOINT;
  pMicrophoneASCSEpDesc->bDescriptorSubtype = UX_DEVICE_CLASS_AUDIO_EP_GENERAL;
  pMicrophoneASCSEpDesc->bmAttributes = 0x00U;
  pMicrophoneASCSEpDesc->bmControls = 0x00U;
  pMicrophoneASCSEpDesc->bLockDelayUnits = 0x00U;
  pMicrophoneASCSEpDesc->wLockDelay = 0x0000U;
  *Sze += (uint32_t)sizeof(USBD_AUDIOSCSEpDescTypeDef);

#endif /* USBD_AUDIO_RECORDING_ACTIVATED == 1 */
[/#if]

  /* Update Config Descriptor and IAD descriptor */
  ((USBD_ConfigDescTypedef *)pConf)->bNumInterfaces += interface_index;
  ((USBD_ConfigDescTypedef *)pConf)->wDescriptorLength = *Sze;
}
[/#if]

#endif /* USBD_AUDIO_CLASS_ACTIVATED == 1 */

[/#if]
[/#list]
[/#if]
[/#list]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */
