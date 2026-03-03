[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_wMBus.c
  * @author  MCD Application Team
  * @brief   Application of the wMBus Middleware
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

/* Includes ------------------------------------------------------------------*/
#include "app_wMBus.h"

#include "stm32_lpm.h"

/* USER CODE BEGIN Includes */
#include <stdio.h>
#include <string.h>
/* USER CODE END Includes */

/* External variables ---------------------------------------------------------*/
/* USER CODE BEGIN EV */

/* USER CODE END EV */

/* External functions ---------------------------------------------------------*/
/* USER CODE BEGIN EF */

/* USER CODE END EF */
/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator") || (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
#define WMBUS_MODE        ${myHash["ST_ACTIVE_MODE"]}          /**< wM-Bus mode (see @ref wMBus_Phy_submode_t) */
#define WMBUS_FORMAT      ${myHash["ST_WMB_FORMAT"]}  /**< wM-Bus format (see @ref wMBus_Phy_frame_format_t) */
#define WMBUS_DIRECTION   METER_TO_OTHER  /**< wM-Bus direction (see @ref wMBus_Phy_direction_t) */
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter")|| (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
#define WMBUS_MODE      ${myHash["ST_ACTIVE_MODE"]}            /**< wM-Bus mode (see @ref wMBus_Phy_submode_t) */
#define WMBUS_FORMAT    ${myHash["ST_WMB_FORMAT"]}    /**< wM-Bus format (see @ref wMBus_Phy_frame_format_t) */
#define WMBUS_DIRECTION METER_TO_OTHER    /**< wM-Bus direction (see @ref wMBus_Phy_direction_t) */
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator")]

#define MAX_WMBUS_PHY_PACKET 435 /* maximum buffer size: T-mode 3o6 frame format A */
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
#define SND_NR_LENGTH 50
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator") || (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
#define WMBUS_DEVICE_TYPE ${myHash["ST_WMB_TYPE"]}           /**< wM-Bus device type (see @ref wMBus_Phy_meter_modes_t) */
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]

#define WAKEUP_TIMEOUT 10000 // 10s
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
#define MIN(a, b) (((a) < (b)) ? (a) : (b))
[/#if]
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
VTIMER_HandleType_t timerHandle;
uint8_t wMBus_Transmission_VTimer_Callback = 0;

[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator")]
static uint8_t wMBus_RxBuffer[MAX_WMBUS_PHY_PACKET];
static uint16_t wMBus_RxBuffer_length;
static int32_t wMBus_RssiDbm = 0; /* Rx level of Rx wM-Bus packet */
static uint32_t wMBus_RxSync;
[#elseif  (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
static uint8_t wMBus_SND_NR[SND_NR_LENGTH] = { 0x31, 0x44, 0xB4, 0x4C, 0x12, 0x34, 0x45, 0x67, 0x50, 0x07,                                     /* 0x8D, 0xCA, */
                                               0x7B, 0x27, 0xD8, 0xC9, 0x6D, 0x0C, 0x32, 0xF1, 0x4E, 0x33, 0x16, 0xD0, 0xFF, 0x62, 0x98, 0x7D, /* 0x39, 0xA1, */
                                               0x85, 0xAB, 0xE1, 0x2B, 0x6D, 0x6F, 0x70, 0x1D, 0xA3, 0xD7, 0x20, 0x26, 0x34, 0x5C, 0xFB, 0x26, /* 0x5C, 0x1F, */
                                               0x8F, 0x71, 0x6A, 0x95, 0xB1, 0x04, 0x00, 0x00,                                                 /* 0xCF, 0xA5  */ };
[#elseif  (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
static uint8_t *rxBuff;
static uint16_t rxBuffLength;
[#elseif  (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator")]
static wMBus_DataLink_status_t status;
#ifdef PROCESS_FRAME
static wMBus_DataLink_frame_t receivedFrame;
#else
static uint8_t *rxBuff;
static uint16_t rxBuffLength;
#endif
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
static void SystemApp_Init(void);
static void wMBus_init(void);
/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* Exported functions --------------------------------------------------------*/
void MX_wMBus_Init()
{
  /* USER CODE BEGIN MX_wMBus_Init_1 */

  /* USER CODE END MX_wMBus_Init_1 */
  SystemApp_Init();
  /* USER CODE BEGIN MX_wMBus_Init_2 */

  /* USER CODE END MX_wMBus_Init_2 */
  wMBus_init();
  /* USER CODE BEGIN MX_wMBus_Init_3 */

  /* USER CODE END MX_wMBus_Init_3 */
}

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
void wMBus_RadioTimerConfig(void)
{
  uint8_t ret_val = SUCCESS;

  timerHandle.callback = TimeoutCallback;

  /* Start the radio timer with WAKEUP_TIMEOUT */
  ret_val = HAL_MRSUBG_TIMER_StartVirtualTimerMs(&timerHandle, WAKEUP_TIMEOUT);

  if (ret_val != SUCCESS)
  {
    /* USER CODE BEGIN wMBus_RadioTimerConfig_1 */

    /* USER CODE END wMBus_RadioTimerConfig_1 */
    while (1);
  }
}

void TimeoutCallback(void *timerHandle)
{
  uint8_t ret_val;

  ret_val = HAL_MRSUBG_TIMER_StartVirtualTimerMs(timerHandle, WAKEUP_TIMEOUT);

  if (ret_val != SUCCESS)
  {
    /* USER CODE BEGIN TimeoutCallback_1 */

    /* USER CODE END TimeoutCallback_1 */
    while (1);
  }
  /* set wM-Bus transmission flag */
  wMBus_Transmission_VTimer_Callback = 1;

  /* USER CODE BEGIN TimeoutCallback_2 */

  /* USER CODE END TimeoutCallback_2 */
}
[/#if]

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button")]
void MX_wMBus_Process()
{
  /* USER CODE BEGIN MX_wMBus_Process_1 */
  
  /* USER CODE END MX_wMBus_Process_1 */

    wMBus_Phy_prepare_Tx_CRC_mngt(wMBus_SND_NR, SND_NR_LENGTH, WMBUS_FORMAT);

    /* Send the TX command */
    wMBus_Phy_start_transmission();

    /* wait for WMBUS_TX_COMPLETED event flag set */
    while (!wMBus_Phy_check_radio_events(WMBUS_TX_COMPLETED));

  /* USER CODE BEGIN MX_wMBus_Process_2 */

  /* USER CODE END MX_wMBus_Process_2 */
}
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
void MX_wMBus_Process()
{
  static uint8_t first_trigger = 0;
    
  if(first_trigger == 0){
    wMBus_RadioTimerConfig();
    first_trigger = 1;
  }

  HAL_MRSUBG_TIMER_Tick();

  /* USER CODE BEGIN MX_wMBus_Process_1 */

  /* USER CODE END MX_wMBus_Process_1 */

  /* Wakeup source configuration */
  uint32_t wakeupInternal = HAL_PWREx_GetClearInternalWakeUpLine();

  if (wakeupInternal & PWR_WAKEUP_SUBGHOST)
  {
    /* USER CODE BEGIN MX_wMBus_Process_2 */

    /* USER CODE END MX_wMBus_Process_2 */
  }

  /* check if Wake-up for wM-Bus transmission */
  if (wMBus_Transmission_VTimer_Callback == 1)
  {
    wMBus_Transmission_VTimer_Callback = 0;

    wMBus_Phy_prepare_Tx_CRC_mngt(wMBus_SND_NR, SND_NR_LENGTH, WMBUS_FORMAT);

    /* Send the TX command */
    wMBus_Phy_start_transmission();
    /* wait for WMBUS_TX_COMPLETED event flag set */
    while (!wMBus_Phy_check_radio_events(WMBUS_TX_COMPLETED));
    /* USER CODE BEGIN MX_wMBus_Process_3 */

    /* USER CODE END MX_wMBus_Process_3 */
  }
}
[/#if]
[#if (myHash["CFG_LPM_SUPPORTED"] == "0")]
void MX_wMBus_Process()
{
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator")]
  uint8_t _wMBus_format = WMBUS_FORMAT;
[/#if]
  /* USER CODE BEGIN MX_wMBus_Process_1 */

  /* USER CODE END MX_wMBus_Process_1 */

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter")]

  wMBus_Phy_prepare_Tx_CRC_mngt(wMBus_SND_NR, SND_NR_LENGTH, WMBUS_FORMAT);

  /* Send the TX command */
  wMBus_Phy_start_transmission();

  /* wait for WMBUS_TX_COMPLETED event flag set */
  while (!wMBus_Phy_check_radio_events(WMBUS_TX_COMPLETED));
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator")]
  UNUSED(status);

#ifdef PROCESS_FRAME
  status = wMBus_DataLink_receive_frame(&receivedFrame);
#else
  status = wMBus_DataLink_receive_frame(&rxBuff, &rxBuffLength);
#endif
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
  wMBus_DataLink_C_field_t c_field = DL_SND_NR;
  wMBus_DataLink_CI_field_t ci_field = CI_EN13757_3_SHORT_TPL;
  static uint8_t acc = 0x00;
  uint8_t data[20] = {0x00, 0x00, 0x10, 0x05, 0xD8, 0x0A, 0xB5, 0x1C, 0xB4, 0xE3, 0xD8, 0x4D, 0xB8, 0x6D, 0x27, 0x45, 0x71, 0xC7, 0xEE, 0x04};
  data[0] = acc++;
  uint8_t length = 20;
  wMBus_DataLink_send_frame(c_field, ci_field, data, length, &rxBuff, &rxBuffLength);

[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator")]
  wMBus_Phy_prepare_Rx();
  /* Send the RX command */
  wMBus_Phy_start_continuousRx();

  /* register LL wM-Bus buffer & size into HAL for copy - and verification */
  /* indicate LL buffer size in wMBus_RxBuffer_length */
  wMBus_RxBuffer_length = MAX_WMBUS_PHY_PACKET;
  wMBus_Phy_register_LL_buffer(wMBus_RxBuffer, &wMBus_RxBuffer_length, &_wMBus_format, &wMBus_RxSync, &wMBus_RssiDbm);
[/#if]

  /* USER CODE BEGIN MX_wMBus_Process_2 */

  /* USER CODE END MX_wMBus_Process_2 */

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator")]
  /* wait for WMBUS_RX_COMPLETED_WITH_VALID_CRC event flag set */
  while (!wMBus_Phy_check_radio_events(WMBUS_RX_COMPLETED_WITH_VALID_CRC))
  {
    /* USER CODE BEGIN MX_wMBus_Process_3 */

    /* USER CODE END MX_wMBus_Process_3 */
  }

  /* USER CODE BEGIN MX_wMBus_Process_4 */

  /* USER CODE END MX_wMBus_Process_4 */
[/#if]
}
[/#if]

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_Button") || (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]

#if (CFG_LPM_SUPPORTED == 1)
static PowerSaveLevels App_PowerSaveLevel_Check(void)
{

  PowerSaveLevels output_level = POWER_SAVE_LEVEL_DEEPSTOP_NOTIMER;

  /* USER CODE BEGIN App_PowerSaveLevel_Check_1 */

  /* USER CODE END App_PowerSaveLevel_Check_1 */

  return output_level;
}

__weak PowerSaveLevels HAL_MRSUBG_TIMER_PowerSaveLevelCheck()
{
  return POWER_SAVE_LEVEL_DEEPSTOP_TIMER;
}
#endif

void MX_wMBus_Idle()
{
  /* USER CODE BEGIN MX_wMBus_Idle_1 */

  /* USER CODE END MX_wMBus_Idle_1 */

#if (CFG_LPM_SUPPORTED == 1)
  PowerSaveLevels app_powerSave_level, vtimer_powerSave_level, final_level;

  app_powerSave_level = App_PowerSaveLevel_Check();

  if (app_powerSave_level != POWER_SAVE_LEVEL_DISABLED)
  {
    vtimer_powerSave_level = HAL_MRSUBG_TIMER_PowerSaveLevelCheck();
    final_level = (PowerSaveLevels)MIN(vtimer_powerSave_level, app_powerSave_level);

    switch (final_level)
    {
    case POWER_SAVE_LEVEL_DISABLED:
      /* Not Power Save device is busy */
      return;
      break;
    case POWER_SAVE_LEVEL_SLEEP:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_DEEPSTOP_TIMER:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_DISABLE);
      break;
    case POWER_SAVE_LEVEL_DEEPSTOP_NOTIMER:
      UTIL_LPM_SetStopMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      UTIL_LPM_SetOffMode(1 << CFG_LPM_APP, UTIL_LPM_ENABLE);
      break;
[#if DIE=="DIE122"]
    case POWER_SAVE_LEVEL_ULTRADEEPSTOP:
      /* Not yet supported by LPM */
      return;
      break;
[/#if]
    }

    UTIL_LPM_EnterLowPower();
  }
#endif /* CFG_LPM_SUPPORTED */

  /* USER CODE BEGIN MX_wMBus_Idle_2 */

  /* USER CODE END MX_wMBus_Idle_2 */
}

[/#if]

/* USER CODE BEGIN EF */

/* USER CODE END EF */

/* Private Functions Definition -----------------------------------------------*/

static void SystemApp_Init(void)
{
  /* USER CODE BEGIN SystemApp_Init_1 */

  /* USER CODE END SystemApp_Init_1 */

  /* USER CODE BEGIN SystemApp_Init_2 */

  /* USER CODE END SystemApp_Init_2 */
}

static void wMBus_init()
{
  /* USER CODE BEGIN wMBus_init_1 */

  /* USER CODE END wMBus_init_1 */
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator")]
  uint8_t a_field[6] = {0x22, 0x01, 0x08, 0x10, 0x01, 0x02};
  uint8_t m_field[2] = {0x85, 0x5D};
  wMBus_DataLink_init(m_field, a_field, WMBUS_DEVICE_TYPE, WMBUS_MODE, WMBUS_FORMAT, WMBUS_DIRECTION);
[#elseif  (myHash["ST_WMB_APP_TYPE"] == "DataLink_Meter")]
  uint8_t a_field[6] = {0x21, 0x01, 0x08, 0x10, 0x01, 0x02};
  uint8_t m_field[2] = {0x85, 0x5D};
  wMBus_DataLink_init(m_field, a_field, WMBUS_DEVICE_TYPE, WMBUS_MODE, WMBUS_FORMAT, WMBUS_DIRECTION);
[#else]
  wMBus_Phy_init(WMBUS_MODE, WMBUS_DIRECTION, WMBUS_FORMAT);
[/#if]
[#if myHash["ST_WMB_APP_TYPE"] == "Phy_Concentrator"]
#ifdef WMBUS_ACTIVE_POWER_MODE_ENABLED
  wMBus_Phy_set_active_power_mode(WMBUS_LPM);
#endif
[/#if]
[#if (myHash["ST_WMB_APP_TYPE"] == "DataLink_Concentrator")]
  wMBus_DataLink_startRx();
[/#if]
  /* USER CODE BEGIN wMBus_init_2 */

  /* USER CODE END wMBus_init_2 */
}

[#if (myHash["ST_WMB_APP_TYPE"] == "Phy_Meter_RadioTimer")]
void HAL_MRSUBG_TIMER_CPU_WKUP_Callback(void)
{
  HAL_MRSUBG_TIMER_TimeoutCallback();
}
[/#if]
/* USER CODE BEGIN PrFD */

/* USER CODE END PrFD */
