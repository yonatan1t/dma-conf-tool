[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    app_entry.c
  * @author  MCD Application Team
  * @brief   Entry point of the application
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
[#-- If Thread with OT-CLI is activated, SerialCommandInterface is deactivated --]
[#assign SerialCommandInterface = "True"]
[#if (myHash["THREAD"] == "Enabled")]
    [#assign nbInstanceCli = 0]
    [#assign myHashCli = {}]
    [#if BspIpDatas??]
        [#list BspIpDatas as SWIP]
            [#if SWIP.variables??]
                [#list SWIP.variables as variables]
                    [#assign myHashCli = {variables.name + nbInstanceCli:variables.value} + myHashCli]
                    [#if variables.name?contains("BoardName")]
                        [#assign nbInstanceCli = nbInstanceCli + 1]
                        Instance++
                    [/#if]
                [/#list]
            [/#if]
        [/#list]
    [/#if]
    [#if nbInstanceCli !=0 ]
        [#list 0..(nbInstanceCli-1) as i]
            [#if myHashCli["bspName"+i] == "Serial Link for Command Line Interface" ]
                [#assign SerialCommandInterface = "False" ]
            [/#if]
        [/#list]
    [/#if]
[/#if]

/* Includes ------------------------------------------------------------------*/
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "app_common.h"
#include "log_module.h"
[/#if]
#include "app_conf.h"
#include "main.h"
[#if myHash["ZIGBEE"] == "Enabled"]
#include "app_zigbee.h"
[/#if]
#include "app_entry.h"
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32_rtos.h"
[/#if]
[#if myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled"]
#include "stm_list.h"
#include "rf_external_pa.h"
#include "rf_antenna_switch.h"
[/#if]
#if (CFG_LPM_LEVEL != 0)
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
#include "stm32_lpm.h"
#endif /* (CFG_LPM_LEVEL != 0) */
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "stm32_timer.h"
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#include "advanced_memory_manager.h"
[/#if]
[#if (myHash["CFG_MM_TYPE"]?number != 0)]
#include "stm32_mm.h"
[/#if]
#if (CFG_LOG_SUPPORTED != 0)
#include "stm32_adv_trace.h"
#include "serial_cmd_interpreter.h"
#endif /* CFG_LOG_SUPPORTED */
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "app_ble.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "ll_sys.h"
#include "ll_sys_if.h"
[/#if]
[#if myHash["THREAD"] == "Enabled" ]
#include "app_thread.h"
[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#include "app_sys.h"
[/#if]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#include "otp.h"
#include "scm.h"
[/#if]
[#if (myHash["BLE"] == "Enabled")]
#include "bpka.h"
[/#if]
[#if (myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK") && ((myHash["BLE"] = "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled"))]
#include "blestack.h"
#include "ble_timer.h"
[/#if]
[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
#include "flash_driver.h"
#include "flash_manager.h"
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "simple_nvm_arbiter.h"
[/#if]
[#if (myHash["BLE"] == "Enabled")]
#include "app_debug.h"
[/#if]
[#if (myHash["ZIGBEE"] == "Disabled")  && ( (myHash["FREERTOS_STATUS"]?number == 1) || (myHash["THREADX_STATUS"]?number == 1) ) ]
#include "crc_ctrl.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#include "temp_measurement.h"
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
#if(CFG_RT_DEBUG_DTB == 1)
#include "RTDebug_dtb.h"
#endif /* CFG_RT_DEBUG_DTB */
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
#include "stm32wbaxx_ll_rcc.h"
[/#if]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
#include "skel_ble.h"
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
#include "timer_if.h"
#if (CFG_LPM_LEVEL != 0) 
#include "tx_low_power.h"
#endif /* (CFG_LPM_LEVEL != 0) */
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#include "timer_if.h"
extern void xPortSysTickHandler (void);
extern void vPortSetupTimerInterrupt(void);
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
#include "assert.h"
[/#if]
[#if (myHash["CFG_LPM_ENHANCED"]?number == 1)]
#include "stm32_lpm_if.h"
[/#if]

/* Private includes -----------------------------------------------------------*/
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
extern void ll_sys_mac_cntrl_init( void );
[/#if]
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/

/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private defines -----------------------------------------------------------*/
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#define AMM_POOL_SIZE ( DIVC(CFG_MM_POOL_SIZE, sizeof (uint32_t)) +\
                      (AMM_VIRTUAL_INFO_ELEMENT_SIZE * CFG_AMM_VIRTUAL_MEMORY_NUMBER) )
[/#if]
[#if (myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK")]
#define RTOS_FLAG_ALL_MASK ((1U << CFG_RTOS_FLAG_LAST) - 1)
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#define HAL_TICK_RTC (1)
[/#if]
/* USER CODE BEGIN PD */

/* USER CODE END PD */

/* Private macros ------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private constants ---------------------------------------------------------*/
/* USER CODE BEGIN PC */

/* USER CODE END PC */

/* Private variables ---------------------------------------------------------*/
[#if myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled"]
const uint32_t FW_Version = (WPAN_FW_MAJOR_VERSION << 24) + (WPAN_FW_MINOR_VERSION << 16) + (WPAN_FW_SUBVERSION << 8)
+ (WPAN_FW_BRANCH << 4) + WPAN_FW_BUILD;

[/#if]
#if ( CFG_LPM_LEVEL != 0)
static bool system_startup_done = FALSE;
[#if myHash["THREADX_STATUS"]?number == 1 ]

/* Time remaining variables to correct next OS tick */
static uint32_t timeDiffRemaining = 0;
static uint32_t lowPowerTimeDiffRemaining = 0;
[/#if]
#endif /* ( CFG_LPM_LEVEL != 0) */

#if (CFG_LOG_SUPPORTED != 0)
/* Log configuration
 * .verbose_level can be any value of the Log_Verbose_Level_t enum.
 * .region_mask can either be :
 * - LOG_REGION_ALL_REGIONS to enable all regions
 * or
 * - One or several specific regions (any value except LOG_REGION_ALL_REGIONS)
 *   from the Log_Region_t enum and matching the mask value.
 *
 *   For example, to enable both LOG_REGION_BLE and LOG_REGION_APP,
 *   the value assigned to the define is :
 *   (1U << LOG_REGION_BLE | 1U << LOG_REGION_APP)
 */
static Log_Module_t Log_Module_Config = { .verbose_level = APPLI_CONFIG_LOG_LEVEL, .region_mask = APPLI_CONFIG_LOG_REGION };
#endif /* (CFG_LOG_SUPPORTED != 0) */

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
/* AMM configuration */
static uint32_t AMM_Pool[AMM_POOL_SIZE];
static AMM_VirtualMemoryConfig_t vmConfig[CFG_AMM_VIRTUAL_MEMORY_NUMBER] =
{
[#list 1..(myHash["CFG_AMM_VIRTUAL_MEMORY_NUMBER"]?number) as i]
  /* Virtual Memory #${i} */
  {
    .Id = CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]},
    .BufferSize = CFG_AMM_VIRTUAL_${myHash["CFG_AMM_VIRTUAL_ID_NAME_"+i?string]}_BUFFER_SIZE
  },
[/#list]
};

static AMM_InitParameters_t ammInitConfig =
{
  .p_PoolAddr = AMM_Pool,
  .PoolSize = AMM_POOL_SIZE,
  .VirtualMemoryNumber = CFG_AMM_VIRTUAL_MEMORY_NUMBER,
  .p_VirtualMemoryConfigList = vmConfig
};

[/#if]

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Timer for OS tick declaration */
static UTIL_TIMER_Object_t TimerOsTick_Id;
/* Timer for HAL tick declaration */
static UTIL_TIMER_Object_t TimerHalTick_Id;

#if ( CFG_LPM_LEVEL != 0)
/* Holds maximum number of FreeRTOS tick periods that can be suppressed */
static uint32_t maximumPossibleSuppressedTicks = 0;

/* Timer OS wakeup low power declaration */
static UTIL_TIMER_Object_t  TimerOSwakeup_Id;

/* Time remaining variables to correct next OS tick */
static uint32_t timeDiffRemaining = 0;
static uint32_t lowPowerTimeDiffRemaining = 0;
#endif /* ( CFG_LPM_LEVEL != 0) */

/* FreeRTOS objects declaration */
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static const osThreadAttr_t WpanTask_attributes = {
  .name         = "Wpan Task",
  .priority     = TASK_PRIO_WPAN,
  .stack_size   = TASK_STACK_SIZE_WPAN,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};
[#else]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static osThreadId_t     AmmTaskHandle;
static osSemaphoreId_t  AmmSemaphore;

static const osThreadAttr_t AmmTask_attributes = {
  .name         = "AMM Task",
  .priority     = TASK_PRIO_AMM,
  .stack_size   = TASK_STACK_SIZE_AMM,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

static const osSemaphoreAttr_t AmmSemaphore_attributes = {
  .name         = "AMM Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
static osThreadId_t     RngTaskHandle;
static osSemaphoreId_t  RngSemaphore;

static const osThreadAttr_t RngTask_attributes = {
  .name         = "Random Number Generator Task",
  .priority     = TASK_PRIO_RNG,
  .stack_size   = TASK_STACK_SIZE_RNG,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

static const osSemaphoreAttr_t RngSemaphore_attributes = {
  .name         = "Random Number Generator Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") ]
osThreadId_t          AppliTaskHandle;

const osThreadAttr_t AppliTask_attributes =
{
  .name         = "Application Task",
  .priority     = TASK_PRIO_ZIGBEE_APP_START,
  .stack_size   = TASK_STACK_SIZE_ZIGBEE_APP_START,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM,
};

[/#if]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
static osThreadId_t     FlashManagerTaskHandle;
static osSemaphoreId_t  FlashManagerSemaphore;

static const osThreadAttr_t FlashManagerTask_attributes = {
  .name         = "FLASH Manager Task",
  .priority     = TASK_PRIO_FLASH_MANAGER,
  .stack_size   = TASK_STACK_SIZE_FLASH_MANAGER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

static const osSemaphoreAttr_t FlashManagerSemaphore_attributes = {
  .name         = "FLASH Manager Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[/#if]
[#if (myHash["BLE"] == "Enabled")]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static osThreadId_t     BpkaTaskHandle;
static osSemaphoreId_t  BpkaSemaphore;

static const osThreadAttr_t BpkaTask_attributes = {
  .name         = "BPKA Task",
  .priority     = TASK_PRIO_BPKA,
  .stack_size   = TASK_STACK_SIZE_BPKA,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

static const osSemaphoreAttr_t BpkaSemaphore_attributes = {
  .name         = "BPKA Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Disabled") ]
static osMutexId_t      crcCtrlMutex;

static const osMutexAttr_t crcCtrlMutex_attributes = {
  .name         = "CRC CTRL Mutex",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
static osMutexId_t      adcCtrlMutex;

static const osMutexAttr_t adcCtrlMutex_attributes = {
  .name         = "ADC CTRL Mutex",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX objects declaration */
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static TX_THREAD      WpanTaskHandle;
[/#if]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static TX_THREAD      AmmTaskHandle;
static TX_SEMAPHORE   AmmSemaphore;

[/#if]
static TX_THREAD      RngTaskHandle;
static TX_SEMAPHORE   RngSemaphore;

[/#if]
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
static TX_THREAD      AppliTaskHandle;

[/#if]
[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static TX_THREAD      FlashManagerTaskHandle;
static TX_SEMAPHORE   FlashManagerSemaphore;

[#if (myHash["BLE"] == "Enabled")]
static TX_THREAD      BpkaTaskHandle;
static TX_SEMAPHORE   BpkaSemaphore;

[/#if]
[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Disabled") ]
static TX_MUTEX       crcCtrlMutex;
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
static TX_MUTEX       adcCtrlMutex;
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
#if (CFG_LPM_LEVEL != 0)
static TX_THREAD      IdleTaskHandle;
#endif
[/#if]

/* USER CODE BEGIN PV */

/* USER CODE END PV */

/* Global variables ----------------------------------------------------------*/
[#if myHash["THREADX_STATUS"]?number == 1 ]
/* ThreadX objects declaration */

/* ThreadX byte pool pointer for whole WPAN middleware */
TX_BYTE_POOL  * pBytePool;
CHAR          * pStack;
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]

TX_EVENT_FLAGS_GROUP WpanEventFlag;
[/#if]

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* FreeRTOS objects declaration */
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
osThreadId_t     WpanTaskHandle;
[/#if]
[/#if]
/* USER CODE BEGIN GV */

/* USER CODE END GV */

/* Private functions prototypes-----------------------------------------------*/
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
static void System_Init( void );
static void SystemPower_Config( void );
static void Config_HSE(void);
static void APPE_RNG_Init( void );
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static void APPE_AMM_Init(void);
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void AMM_Task_Entry(void* argument);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void AMM_Task_Entry(ULONG lArgument);
[/#if]
[/#if]
static void AMM_WrapperInit(uint32_t * const p_PoolAddr, const uint32_t PoolSize);
static uint32_t * AMM_WrapperAllocate(const uint32_t BufferSize);
static void AMM_WrapperFree(uint32_t * const p_BufferAddr);

[/#if]
[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
void MX_APPE_InitTask(void* argument);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
void MX_APPE_InitTask(ULONG lArgument);
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void RNG_Task_Entry(void* argument);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void RNG_Task_Entry(ULONG lArgument);
[/#if]
[/#if]

[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
static void APPE_FLASH_MANAGER_Init( void );
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void FLASH_Manager_Task_Entry(void* argument);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void FLASH_Manager_Task_Entry(ULONG lArgument);
[/#if]
[/#if]

[/#if]

[#if (myHash["BLE"] == "Enabled")]
static void APPE_BPKA_Init( void );
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BPKA_Task_Entry(void* argument);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BPKA_Task_Entry(ULONG lArgument);
[/#if]
[/#if]

[/#if]

[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static void Wpan_Task_Entry(ULONG lArgument);
[/#if]
#if (CFG_LPM_LEVEL != 0)
static void IDLE_Task_Entry(ULONG lArgument);
#endif
#ifndef TX_LOW_POWER_USER_ENTER
void ThreadXLowPowerUserEnter( void );
#endif
#ifndef TX_LOW_POWER_USER_EXIT
void ThreadXLowPowerUserExit( void );
#endif
[#if myHash["THREADX_STATUS"]?number == 1 ]
#if ( CFG_LPM_LEVEL != 0)
static uint32_t getCurrentTime(void);
#endif /* CFG_LPM_LEVEL */
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static void Wpan_Task_Entry(void* argument);
[/#if]
static void TimerOsTickCb(void *arg);
#if (HAL_TICK_RTC == 1)
static void TimerHalTickCb(void *arg);
static void HAL_StartTick(void);
#endif /* HAL_TICK_RTC */
#if ( CFG_LPM_LEVEL != 0)
static void TimerOSwakeupCB(void *arg);
static uint32_t getCurrentTime(void);
#endif /* CFG_LPM_LEVEL */
[/#if]

/* USER CODE BEGIN PFP */

/* USER CODE END PFP */

/* External variables --------------------------------------------------------*/

/* USER CODE BEGIN EV */

/* USER CODE END EV */


/* Functions Definition ------------------------------------------------------*/
/**
 * @brief   Wireless Private Area Network configuration.
 */
void MX_APPE_Config(void)
{
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
  /* Configure HSE Tuning */
  Config_HSE();
[#else]
  /* Apply default gain */
  HAL_RCCEx_HSESetTrimming(0x0C);
[/#if]
}

[#if myHash["ZIGBEE"] == "Enabled" || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled")]
/**
 * @brief   LinkLayer & MAC Initialisation.
 */
void MX_APPE_LinkLayerInit(void)
{
  /* Initialization of the low level : link layer and MAC */
  ll_sys_mac_cntrl_init();

}

[#if (myHash["THREADX_STATUS"]?number == 1) || (myHash["FREERTOS_STATUS"]?number == 1)]
/**
 * @brief   System Tasks Initialisations
 */
[#if myHash["THREADX_STATUS"]?number == 1]
void MX_APPE_InitTask( ULONG lArgument )
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1]
void MX_APPE_InitTask( void * argument )
[/#if]
{
  /* USER CODE BEGIN APPE_Init_Task_1 */

  /* USER CODE END APPE_Init_Task_1 */

  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

  /* Initialization of the Zigbee Application */
  /* Must be called in RTOS context
     due to dependency of ZbInit() on MAC layer semaphore */
  APP_ZIGBEE_ApplicationInit();

  /* USER CODE BEGIN APPE_Init_Task_2 */
  /* USER CODE END APPE_Init_Task_2 */

[#if myHash["THREADX_STATUS"]?number == 1]
  /* Free allocated stack before entering completed state */
  tx_byte_release(AppliTaskHandle.tx_thread_stack_start);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1]
  /* FreeRTOS hard fault if task simply returns... */
  osThreadExit();
[/#if]
}

[/#if]
[/#if]
/**
 * @brief   Wireless Private Area Network initialisation.
 */
uint32_t MX_APPE_Init(void *p_param)
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
  UNUSED(p_param);

  BLE_Init();
[#else]
[#if (myHash["THREADX_STATUS"]?number == 1)]
  UINT TXstatus;
[#if (myHash["ZIGBEE"] == "Enabled")]
  CHAR *pStack;

[/#if]
[/#if]
  APP_DEBUG_SIGNAL_SET(APP_APPE_INIT);

[#if myHash["THREADX_STATUS"]?number == 1 ]
  /* Save ThreadX byte pool for whole WPAN middleware */
  pBytePool = p_param;
[#else]
  UNUSED(p_param);
[/#if]

  /* System initialization */
  System_Init();

  /* Configure the system Power Mode */
  SystemPower_Config();

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  /* Initialize the Temperature measurement */
  TEMPMEAS_Init ();
#endif /* (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1) */

[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
  /* Initialize the Advance Memory Manager module */
  APPE_AMM_Init();

[/#if]
  /* Initialize the Random Number Generator module */
  APPE_RNG_Init();

[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
  /* Initialize the Flash Manager module */
  APPE_FLASH_MANAGER_Init();

[/#if]
  /* USER CODE BEGIN APPE_Init_1 */

  /* USER CODE END APPE_Init_1 */

[#if (myHash["ZIGBEE"] == "Disabled") ]
[#if myHash["FREERTOS_STATUS"]?number == 1]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]

  WpanTaskHandle = osThreadNew(Wpan_Task_Entry, NULL, &WpanTask_attributes);

[/#if]
  crcCtrlMutex = osMutexNew(&crcCtrlMutex_attributes);
  if (crcCtrlMutex == NULL)
  {
    LOG_ERROR_APP( "CRC CTRL FreeRTOS mutex creation FAILED");
    Error_Handler();
  }

#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  adcCtrlMutex = osMutexNew(&adcCtrlMutex_attributes);
  if (adcCtrlMutex == NULL)
  {
    LOG_ERROR_APP( "ADC CTRL FreeRTOS mutex creation FAILED");
    Error_Handler();
  }
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
[#if myHash["THREADX_STATUS"]?number == 1]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_WPAN, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&WpanTaskHandle, "Wpan Task", Wpan_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_WPAN,
                                 TASK_PRIO_WPAN, TASK_PREEMP_WPAN,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_event_flags_create(&WpanEventFlag, "Wpan EventFlag");
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "Wpan ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }

[/#if]
  TXstatus = tx_mutex_create(&crcCtrlMutex, "CRC CTRL Mutex", 0 );

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "CRC CTRL ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  TXstatus = tx_mutex_create(&adcCtrlMutex, "ADC CTRL Mutex", 0 );

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ADC CTRL ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
[/#if]
[#if (myHash["BLE"] == "Enabled")]
  /* Initialize the Ble Public Key Accelerator module */
  APPE_BPKA_Init();

[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  /* Initialize the Simple Non Volatile Memory Arbiter */
  if( SNVMA_Init((uint32_t *)CFG_SNVMA_START_ADDRESS) != SNVMA_ERROR_OK )
  {
    Error_Handler();
  }

[/#if]
[#if (myHash["BLE"] == "Enabled")]

  APP_BLE_Init();

[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
  /* Disable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_DISABLE);
[/#if]
[/#if]

[#if (myHash["THREAD"] == "Enabled")]
  /* Thread Initialisation */
  APP_THREAD_Init();
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#if ( CFG_LPM_LEVEL != 0)
  /* create a SW timer to wakeup system from low power */
  UTIL_TIMER_Create(&TimerOSwakeup_Id,
                    0,
                    UTIL_TIMER_ONESHOT,
                    &TimerOSwakeupCB, 0);

  maximumPossibleSuppressedTicks = UINT32_MAX;
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

[#if ((myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["mac_802_15_4_SKELETON"] == "Enabled"))]
[#if (myHash["SEQUENCER_STATUS"]?number == 1)]
  /* Initialization of the low level : link layer and MAC */
  MX_APPE_LinkLayerInit();

[#if (myHash["ZIGBEE"] == "Enabled")]
  /* Initialization of the Zigbee Application */
  APP_ZIGBEE_ApplicationInit();

[/#if]
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") && (myHash["THREADX_STATUS"]?number == 1)]
  /* Create the Application Startup Thread and this Stack */
  TXstatus = tx_byte_allocate( pBytePool, (VOID**) &pStack, TASK_STACK_SIZE_ZIGBEE_APP_START, TX_NO_WAIT);
  if ( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create( &AppliTaskHandle, "AppliStart Thread", MX_APPE_InitTask, 0, pStack,
                                       TASK_STACK_SIZE_ZIGBEE_APP_START, TASK_PRIO_ZIGBEE_APP_START, TASK_PREEMP_ZIGBEE_APP_START,
                                       TX_NO_TIME_SLICE, TX_AUTO_START);
  }
  if ( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "ERROR THREADX : APPLICATION START THREAD CREATION FAILED (%d)", TXstatus );
    Error_Handler();
  }
[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") && (myHash["FREERTOS_STATUS"]?number == 1)]
  /* Create the Appli Task Thread  */
  AppliTaskHandle = osThreadNew( MX_APPE_InitTask, NULL, &AppliTask_attributes );
  if ( AppliTaskHandle == NULL )
  {
    APP_DBG( "ERROR FREERTOS : APPLICATION START THREAD CREATION FAILED" );
    while(1);
  }

[/#if]
[/#if]
[#if myHash["BLE_MODE_TRANSPARENT_UART"] == "Enabled"]
#if (CFG_EXTERNAL_PA_ENABLE == 1)
  RF_CONTROL_ExternalPA(RF_EPA_ENABLE);
#endif /* CFG_EXTERNAL_PA_ENABLE */

#if (CFG_BLE_AOA_AOD_ENABLE == 1)
  RF_CONTROL_AntennaSwitch(RF_ANTSW_ENABLE);
#endif /* CFG_BLE_AOA_AOD_ENABLE */

[/#if]

  /* USER CODE BEGIN APPE_Init_2 */

  /* USER CODE END APPE_Init_2 */

  APP_DEBUG_SIGNAL_RESET(APP_APPE_INIT);
[/#if]

  return WPAN_SUCCESS;
}

[#if myHash["SEQUENCER_STATUS"]?number == 1 || (myHash["BLE_MODE_SIMPLEST_BLE"] == "Enabled")]
void MX_APPE_Process(void)
{
  /* USER CODE BEGIN MX_APPE_Process_1 */

  /* USER CODE END MX_APPE_Process_1 */
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
  UTIL_SEQ_Run(UTIL_SEQ_DEFAULT);
[#else]
  BLE_Process();
[/#if]
  /* USER CODE BEGIN MX_APPE_Process_2 */

  /* USER CODE END MX_APPE_Process_2 */
}
[/#if]

/* USER CODE BEGIN FD */

/* USER CODE END FD */

/*************************************************************
 *
 * LOCAL FUNCTIONS
 *
 *************************************************************/
[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]

/**
 * @brief Configure HSE by read this Tuning from OTP
 *
 */
static void Config_HSE(void)
{
  OTP_Data_s* otp_ptr = NULL;

  /* Read HSE_Tuning from OTP */
  if (OTP_Read(DEFAULT_OTP_IDX, &otp_ptr) != HAL_OK)
  {
    /* OTP no present in flash, apply default gain */
    HAL_RCCEx_HSESetTrimming(0x0C);
  }
  else
  {
    HAL_RCCEx_HSESetTrimming(otp_ptr->hsetune);
  }
}

/**
 *
 */
static void System_Init( void )
{
  /* Clear RCC RESET flag */
  LL_RCC_ClearResetFlags();

  /* Initialize the Timer Server */
  UTIL_TIMER_Init();

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
#if (HAL_TICK_RTC == 1)
  HAL_StartTick();
#endif /* HAL_TICK_RTC */
[/#if]
  /* USER CODE BEGIN System_Init_1 */

  /* USER CODE END System_Init_1 */

  /* Enable wakeup out of standby from RTC ( UTIL_TIMER )*/
  HAL_PWR_EnableWakeUpPin(PWR_WAKEUP_PIN7_HIGH_3);

#if (CFG_LOG_SUPPORTED != 0)
[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName == "MX_USART1_UART_Init")
      || (void.functionName == "MX_USART2_UART_Init")
      || (void.functionName == "MX_LPUART1_UART_Init")
    ]
${""?right_pad(2)}${void.functionName}();
    [/#if]
  [/#if]
  [/#list]
[/#if]

  /* Initialize the logs ( using the USART ) */
  Log_Module_Init( Log_Module_Config );
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#else]
  Log_Module_Set_Region( LOG_REGION_APP );
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
  Log_Module_Add_Region( LOG_REGION_ZIGBEE );
[/#if]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
  Log_Module_Add_Region( LOG_REGION_THREAD );
[/#if]
[/#if]
[#if SerialCommandInterface == "True"]

  /* Initialize the Command Interpreter */
  Serial_CMD_Interpreter_Init();
[/#if]
#endif  /* (CFG_LOG_SUPPORTED != 0) */

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init ();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
#if(CFG_RT_DEBUG_DTB == 1)
  /* DTB initialization and configuration */
  RT_DEBUG_DTBInit();
  RT_DEBUG_DTBConfig();
#endif /* CFG_RT_DEBUG_DTB */
#if(CFG_RT_DEBUG_GPIO_MODULE == 1)
  /* RT DEBUG GPIO_Init */
  RT_DEBUG_GPIO_Init();
#endif /* (CFG_RT_DEBUG_GPIO_MODULE == 1) */

#if ( CFG_LPM_LEVEL != 0)
  system_startup_done = TRUE;
  UNUSED(system_startup_done);
#endif /* ( CFG_LPM_LEVEL != 0) */

  return;
}

/**
 * @brief  Configure the system for power optimization
 *
 * @note  This API configures the system to be ready for low power mode
 *
 * @param  None
 * @retval None
 */
static void SystemPower_Config(void)
{
#if (CFG_SCM_SUPPORTED == 1)
  /* Initialize System Clock Manager */
  scm_init();
#endif /* CFG_SCM_SUPPORTED */

#if (CFG_DEBUGGER_LEVEL == 0)
  /* Setup GPIOA 13, 14, 15 in Analog no pull */
  if(__HAL_RCC_GPIOA_IS_CLK_ENABLED() == 0)
  {
    __HAL_RCC_GPIOA_CLK_ENABLE();
    GPIOA->PUPDR &= ~0xFC000000;
    GPIOA->MODER |= 0xFC000000;
    __HAL_RCC_GPIOA_CLK_DISABLE();
  }
  else
  {
    GPIOA->PUPDR &= ~0xFC000000;
    GPIOA->MODER |= 0xFC000000;
  }

  /* Setup GPIOB 3, 4 in Analog no pull */
  if(__HAL_RCC_GPIOB_IS_CLK_ENABLED() == 0)
  {
    __HAL_RCC_GPIOB_CLK_ENABLE();
    GPIOB->PUPDR &= ~0x3C0;
    GPIOB->MODER |= 0x3C0;
    __HAL_RCC_GPIOB_CLK_DISABLE();
  }
  else
  {
    GPIOB->PUPDR &= ~0x3C0;
    GPIOB->MODER |= 0x3C0;
  }
#endif /* CFG_DEBUGGER_LEVEL */

[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled")]
#if (CFG_SCM_SUPPORTED == 1)
  /* Set the HSE clock to 32MHz */
  scm_setsystemclock(SCM_USER_APP, HSE_32MHZ);
#endif /* CFG_SCM_SUPPORTED */

[/#if]
#if (CFG_LPM_LEVEL != 0)
  /* Initialize low Power Manager. By default enabled */
  UTIL_LPM_Init();

#if ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1))
  /* Enable SRAM1, SRAM2 and RADIO retention*/
  LL_PWR_SetSRAM1SBRetention(LL_PWR_SRAM1_SB_FULL_RETENTION);
  LL_PWR_SetSRAM2SBRetention(LL_PWR_SRAM2_SB_FULL_RETENTION);
  LL_PWR_SetRadioSBRetention(LL_PWR_RADIO_SB_FULL_RETENTION); /* Retain sleep timer configuration */

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
#else /* (CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1) */
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_APP, UTIL_LPM_MAX_MODE);
[/#if]
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1) */
[#else]
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1) */

  /* Disable LowPower during Init */
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetStopMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
  UTIL_LPM_SetOffMode(1U << CFG_LPM_APP, UTIL_LPM_DISABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_APP, UTIL_LPM_SLEEP_MODE);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1]

  UINT TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_IDLE, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&IdleTaskHandle, "IDLE Task", IDLE_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_IDLE,
                                 TASK_PRIO_IDLE, TASK_PREEMP_IDLE,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "IDLE ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }

[/#if]
#endif /* (CFG_LPM_LEVEL != 0)  */

  /* USER CODE BEGIN SystemPower_Config */

  /* USER CODE END SystemPower_Config */
}
[/#if]

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static void Wpan_Task_Entry(void* lArgument)
{
  UNUSED(lArgument);
  uint32_t actual_flags;

  for(;;)
  {
    actual_flags = osThreadFlagsWait(RTOS_FLAG_ALL_MASK, osFlagsWaitAny, osWaitForever);

    if( actual_flags & (1U << CFG_RTOS_FLAG_RNG) )
    {
      HW_RNG_Process();
    }

[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
    if( actual_flags & (1U << CFG_RTOS_FLAG_PKA) )
    {
      BPKA_BG_Process();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_FlashManager) )
    {
      FM_BackgroundProcess();
    }

[/#if]
    /* Link Layer related */
    if( actual_flags & (1U << CFG_RTOS_FLAG_LinkLayer) )
    {
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
      osMutexAcquire(LinkLayerMutex, osWaitForever);
[/#if]
      ll_sys_bg_process();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
      osMutexRelease(LinkLayerMutex);
[/#if]
    }

[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled") ]
    /* OT related */
    if( actual_flags & (1U << CFG_RTOS_FLAG_OT_Tasklet) )
    {
      osMutexAcquire(LinkLayerMutex, osWaitForever);
      APP_THREAD_ProcessOpenThreadTasklets(NULL);
      osMutexRelease(LinkLayerMutex);
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_OT_Alarm_ms) )
    {
      osMutexAcquire(LinkLayerMutex, osWaitForever);
      APP_THREAD_ProcessAlarm(NULL);
      osMutexRelease(LinkLayerMutex);
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_OT_Alarm_us) )
    {
      osMutexAcquire(LinkLayerMutex, osWaitForever);
      APP_THREAD_ProcessUsAlarm(NULL);
      osMutexRelease(LinkLayerMutex);
    }

#if (OT_CLI_USE == 1)
    if( actual_flags & (1U << CFG_RTOS_FLAG_OT_CLIuart) )
    {
      osMutexAcquire(LinkLayerMutex, osWaitForever);
      APP_THREAD_ProcessUart(NULL);
      osMutexRelease(LinkLayerMutex);
    }
#endif

[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
    if( actual_flags & (1U << CFG_RTOS_FLAG_TempRadioCalib) )
    {
      TEMPMEAS_RequestTemperatureMeasurement();
    }

[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    if( actual_flags & (1U << CFG_RTOS_FLAG_AMM) )
    {
      AMM_BackgroundProcess();
    }

[/#if]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
    /* BLE related */
    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEhost) )
    {
      BleStack_Process_BG();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEhciEvt) )
    {
      Ble_UserEvtRx();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEtimer) )
    {
      BLE_TIMER_Background();
    }
[/#if]
  }
}

[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void RNG_Task_Entry(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(RngSemaphore, osWaitForever);
    HW_RNG_Process();
  }
}
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
static void Wpan_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);
  ULONG actual_flags;

  for(;;)
  {
    tx_event_flags_get( &WpanEventFlag, UINT32_MAX,
                        TX_OR_CLEAR, &actual_flags, TX_WAIT_FOREVER);


    if( actual_flags & (1U << CFG_RTOS_FLAG_RNG) )
    {
      HW_RNG_Process();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_PKA) )
    {
      BPKA_BG_Process();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_FlashManager) )
    {
      FM_BackgroundProcess();
    }

    /* Link Layer related */
    if( actual_flags & (1U << CFG_RTOS_FLAG_LinkLayer) )
    {
      tx_mutex_get(&LinkLayerMutex, TX_WAIT_FOREVER);
      ll_sys_bg_process();
      tx_mutex_put(&LinkLayerMutex);
    }

[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
    if( actual_flags & (1U << CFG_RTOS_FLAG_TempRadioCalib) )
    {
      TEMPMEAS_RequestTemperatureMeasurement();
    }

[/#if]
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    if( actual_flags & (1U << CFG_RTOS_FLAG_AMM) )
    {
      AMM_BackgroundProcess();
    }

[/#if]
    /* BLE related */
    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEhost) )
    {
      BleStack_Process_BG();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEhciEvt) )
    {
      Ble_UserEvtRx();
    }

    if( actual_flags & (1U << CFG_RTOS_FLAG_BLEtimer) )
    {
      BLE_TIMER_Background();
    }
  }
}

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void RNG_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get( &RngSemaphore, TX_WAIT_FOREVER );
    HW_RNG_Process();
    tx_thread_relinquish();
  }
}
[/#if]
[/#if]

[#if myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled"]
/**
 * @brief Initialize Random Number Generator module
 */
static void APPE_RNG_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  HW_RNG_SetPoolThreshold(CFG_HW_RNG_POOL_THRESHOLD);
  HW_RNG_Init();
  HW_RNG_Start();

  /* Register Random Number Generator task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_HW_RNG, UTIL_SEQ_RFU, (void (*)(void))HW_RNG_Process);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
  HW_RNG_SetPoolThreshold(CFG_HW_RNG_POOL_THRESHOLD);
  HW_RNG_Init();
  HW_RNG_Start();

[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  /* Create Random Number Generator FreeRTOS objects */

  RngSemaphore = osSemaphoreNew(1U, 0U, &RngSemaphore_attributes);

  RngTaskHandle = osThreadNew(RNG_Task_Entry, NULL, &RngTask_attributes);

  if ((RngTaskHandle == NULL) || (RngSemaphore == NULL))
  {
    LOG_ERROR_APP( "RNG FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  UINT TXstatus;
  CHAR *pStack;

  HW_RNG_SetPoolThreshold(CFG_HW_RNG_POOL_THRESHOLD);
  HW_RNG_Init();
  HW_RNG_Start();

  /* Create Random Number Generator ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_RNG, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&RngTaskHandle, "RNG Task", RNG_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_RNG,
                                 TASK_PRIO_RNG, TASK_PREEMP_RNG,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&RngSemaphore, "RNG Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "RNG ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
[/#if]
}
[/#if]

[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
/**
 * @brief Initialize Flash Manager module
 */
static void APPE_FLASH_MANAGER_Init(void)
{
  /* Init the Flash Manager module */
  FM_Init();

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register Flash Manager task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_FLASH_MANAGER, UTIL_SEQ_RFU, FM_BackgroundProcess);

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  /* Create Flash Manager FreeRTOS objects */

  FlashManagerSemaphore = osSemaphoreNew(1U, 0U, &FlashManagerSemaphore_attributes);

  FlashManagerTaskHandle = osThreadNew(FLASH_Manager_Task_Entry, NULL, &FlashManagerTask_attributes);

  if ((FlashManagerTaskHandle == NULL) || (FlashManagerSemaphore == NULL))
  {
    LOG_ERROR_APP( "FLASH FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create Flash Manager ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_FLASH_MANAGER, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&FlashManagerTaskHandle, "FLASH Manager Task", FLASH_Manager_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_FLASH_MANAGER,
                                 TASK_PRIO_FLASH_MANAGER, TASK_PREEMP_FLASH_MANAGER,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&FlashManagerSemaphore, "FLASH Manager Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "FLASH ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }

[/#if]
[/#if]
  /* Disable flash before any use - RFTS */
  FD_SetStatus (FD_FLASHACCESS_RFTS, LL_FLASH_DISABLE);
  /* Enable RFTS Bypass for flash operation - Since LL has not started yet */
  FD_SetStatus (FD_FLASHACCESS_RFTS_BYPASS, LL_FLASH_ENABLE);
  /* Enable flash system flag */
  FD_SetStatus (FD_FLASHACCESS_SYSTEM, LL_FLASH_ENABLE);

  return;
}
[/#if]

[#if (myHash["BLE"] == "Enabled")]
/**
 * @brief Initialize Ble Public Key Accelerator module
 */
static void APPE_BPKA_Init(void)
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register Ble Public Key Accelerator task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_BPKA, UTIL_SEQ_RFU, BPKA_BG_Process);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  /* Create Public Key Accelerator FreeRTOS objects */

  BpkaSemaphore = osSemaphoreNew(1U, 0U, &BpkaSemaphore_attributes);

  BpkaTaskHandle = osThreadNew(BPKA_Task_Entry, NULL, &BpkaTask_attributes);

  if ((BpkaTaskHandle == NULL) || (BpkaSemaphore == NULL))
  {
    LOG_ERROR_APP( "BPKA FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create Public Key Accelerator ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_BPKA, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&BpkaTaskHandle, "BPKA Task", BPKA_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_BPKA,
                                 TASK_PRIO_BPKA, TASK_PREEMP_BPKA,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&BpkaSemaphore, "BPKA Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "BPKA ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
[/#if]
}
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
static void APPE_AMM_Init(void)
{
  /* Initialize the Advance Memory Manager */
  if( AMM_Init(&ammInitConfig) != AMM_ERROR_OK )
  {
    Error_Handler();
  }

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register Advance Memory Manager task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_AMM, UTIL_SEQ_RFU, AMM_BackgroundProcess);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  /* Create Advance Memory Manager FreeRTOS objects */

  AmmSemaphore = osSemaphoreNew(1U, 0U, &AmmSemaphore_attributes);

  AmmTaskHandle = osThreadNew(AMM_Task_Entry, NULL, &AmmTask_attributes);

  if ((AmmTaskHandle == NULL) || (AmmSemaphore == NULL))
  {
    LOG_ERROR_APP( "AMM FreeRTOS objects creation FAILED");
    Error_Handler();
  }

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create Advance Memory Manager ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_AMM, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&AmmTaskHandle, "AMM Task", AMM_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_AMM,
                                 TASK_PRIO_AMM, TASK_PREEMP_AMM,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&AmmSemaphore, "AMM Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "AMM ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
[/#if]
}

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void AMM_Task_Entry(void* argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(AmmSemaphore, osWaitForever);
    AMM_BackgroundProcess();
  }
}
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void AMM_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&AmmSemaphore, TX_WAIT_FOREVER);
    AMM_BackgroundProcess();
    tx_thread_relinquish();
  }
}
[/#if]
[/#if]
[/#if]

[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void FLASH_Manager_Task_Entry(void* argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(FlashManagerSemaphore, osWaitForever);
    FM_BackgroundProcess();
  }
}
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void FLASH_Manager_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&FlashManagerSemaphore, TX_WAIT_FOREVER);
    FM_BackgroundProcess();
    tx_thread_relinquish();
  }
}
[/#if]
[/#if]
[/#if]

[#if (myHash["BLE"] == "Enabled")]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BPKA_Task_Entry(void *argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(BpkaSemaphore, osWaitForever);
    BPKA_BG_Process();
  }
}

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BPKA_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&BpkaSemaphore, TX_WAIT_FOREVER);
    BPKA_BG_Process();
    tx_thread_relinquish();
  }
}

[/#if]
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
#if (CFG_LPM_LEVEL != 0)
static void IDLE_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  while(1)
  {
    /* When no other activities to be done we decide to go in low power
       This mechansim is in charge to mange low power at application level
       without the support of ThreadX low power framework */
    UTILS_ENTER_CRITICAL_SECTION();
    ThreadXLowPowerUserEnter();
    ThreadXLowPowerUserExit();
    UTILS_EXIT_CRITICAL_SECTION();
    tx_thread_relinquish();
  }
}

/* return current time since boot, continue to count in standby low power mode */
static uint32_t getCurrentTime(void)
{
  return TIMER_IF_GetTimerValue();
}
#endif

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Timer OS tick callback */
static void TimerOsTickCb(void *arg)
{
  xPortSysTickHandler();
  /* USER CODE BEGIN TimerOsTickCb */

  /* USER CODE END TimerOsTickCb */
  return;
}

#if (HAL_TICK_RTC == 1)
/* Timer HAL tick callback */
static void TimerHalTickCb(void *arg)
{
  HAL_IncTick();
  /* USER CODE BEGIN TimerHalTickCb */

  /* USER CODE END TimerHalTickCb */
  return;
}
#endif /* HAL_TICK_RTC */

#if ( CFG_LPM_LEVEL != 0)
/* OS wakeup callback */
static void TimerOSwakeupCB(void *arg)
{
  /* USER CODE BEGIN TimerOSwakeupCB */

  /* USER CODE END TimerOSwakeupCB */
  return;
}

/* return current time since boot, continue to count in standby low power mode */
static uint32_t getCurrentTime(void)
{
  return TIMER_IF_GetTimerValue();
}
#endif /* ( CFG_LPM_LEVEL != 0) */
[/#if]

/* USER CODE BEGIN FD_LOCAL_FUNCTIONS */

/* USER CODE END FD_LOCAL_FUNCTIONS */

/*************************************************************
 *
 * WRAP FUNCTIONS
 *
 *************************************************************/

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
[#if (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
void UTIL_SEQ_EvtIdle( UTIL_SEQ_bm_t task_id_bm, UTIL_SEQ_bm_t evt_waited_bm )
{
  UTIL_SEQ_Run( UTIL_SEQ_DEFAULT );

  return;
}

[/#if]
void UTIL_SEQ_Idle( void )
{
#if ( CFG_LPM_LEVEL != 0)
  HAL_SuspendTick();
#if (CFG_SCM_SUPPORTED == 1)
  /* SCM HSE BEGIN */
  SCM_HSE_StopStabilizationTimer();
  /* SCM HSE END */
#endif /* CFG_SCM_SUPPORTED */
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_EnterLowPower();
[#else]
  UTIL_LPM_Enter(0);
[/#if]
  HAL_ResumeTick();
#endif /* CFG_LPM_LEVEL */
  return;
}

void UTIL_SEQ_PreIdle( void )
{
  /* USER CODE BEGIN UTIL_SEQ_PreIdle_1 */

  /* USER CODE END UTIL_SEQ_PreIdle_1 */
#if ( CFG_LPM_LEVEL != 0)
  LL_PWR_ClearFlag_STOP();

#if ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1))
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
[#else]
#if (CFG_LPM_STOP2_SUPPORTED == 1)
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STOP2_MODE ) )
#else /* (CFG_LPM_STOP2_SUPPORTED == 1) */
#if (CFG_LPM_STANDBY_SUPPORTED == 1)
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STANDBY_MODE ) )
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) */
#endif /* (CFG_LPM_STOP2_SUPPORTED == 1) */
[/#if]
  {
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
    APP_SYS_BLE_EnterDeepSleep();
[#else]
    APP_SYS_LPM_EnterLowPowerMode();
[/#if]
  }
#endif /* ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1)) */
  LL_RCC_ClearResetFlags();

#if defined(STM32WBAXX_SI_CUT1_0)
  /* Wait until HSE is ready */
#if (CFG_SCM_SUPPORTED == 1)
  /* SCM HSE BEGIN */
  SCM_HSE_WaitUntilReady();
  /* SCM HSE END */
#else
  while (LL_RCC_HSE_IsReady() == 0);
#endif /* CFG_SCM_SUPPORTED */

  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO << 4U);
  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
#endif /* STM32WBAXX_SI_CUT1_0 */
#endif /* CFG_LPM_LEVEL */
  /* USER CODE BEGIN UTIL_SEQ_PreIdle_2 */

  /* USER CODE END UTIL_SEQ_PreIdle_2 */
  return;
}

void UTIL_SEQ_PostIdle( void )
{
  /* USER CODE BEGIN UTIL_SEQ_PostIdle_1 */

  /* USER CODE END UTIL_SEQ_PostIdle_1 */
#if ( CFG_LPM_LEVEL != 0)
  LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
  (void)ll_sys_dp_slp_exit();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_MAX_MODE);
[/#if]
[/#if]
#endif /* CFG_LPM_LEVEL */
  /* USER CODE BEGIN UTIL_SEQ_PostIdle_2 */

  /* USER CODE END UTIL_SEQ_PostIdle_2 */
  return;
}

[/#if]
[#if (myHash["BLE"] == "Enabled")]
void BPKACB_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_BPKA, CFG_SEQ_PRIO_0);
[#elseif myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_PKA, TX_OR);
[#else]
  tx_semaphore_put(&BpkaSemaphore);
[/#if]
[#elseif myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_PKA);
[#else]
  osSemaphoreRelease(BpkaSemaphore);
[/#if]
[/#if]
}

[/#if]

[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
/**
 * @brief Callback used by Random Number Generator to launch Task to generate Random Numbers
 */
void HWCB_RNG_Process( void )
{
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_HW_RNG, TASK_PRIO_RNG);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_RNG);
[#else]
  osSemaphoreRelease(RngSemaphore);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_RNG, TX_OR);
[#else]
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
  tx_semaphore_put(&RngSemaphore);
[#else]
  if (RngSemaphore.tx_semaphore_count == 0)
  {
    tx_semaphore_put(&RngSemaphore);
  }
[/#if]
[/#if]
[/#if]
}
[/#if]

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
void AMM_RegisterBasicMemoryManager (AMM_BasicMemoryManagerFunctions_t * const p_BasicMemoryManagerFunctions)
{
  /* Fulfill the function handle */
  p_BasicMemoryManagerFunctions->Init = AMM_WrapperInit;
  p_BasicMemoryManagerFunctions->Allocate = AMM_WrapperAllocate;
  p_BasicMemoryManagerFunctions->Free = AMM_WrapperFree;
}

void AMM_ProcessRequest(void)
{
  /* Trigger to call Advance Memory Manager process function */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_AMM, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_AMM);
[#else]
  osSemaphoreRelease(AmmSemaphore);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_AMM, TX_OR);
[#else]
  tx_semaphore_put(&AmmSemaphore);
[/#if]
[/#if]
}

static void AMM_WrapperInit(uint32_t * const p_PoolAddr, const uint32_t PoolSize)
{
  UTIL_MM_Init ((uint8_t *)p_PoolAddr, ((size_t)PoolSize * sizeof(uint32_t)));
}

static uint32_t * AMM_WrapperAllocate(const uint32_t BufferSize)
{
  return (uint32_t *)UTIL_MM_GetBuffer (((size_t)BufferSize * sizeof(uint32_t)));
}

static void AMM_WrapperFree (uint32_t * const p_BufferAddr)
{
  UTIL_MM_ReleaseBuffer ((void *)p_BufferAddr);
}

[/#if]
[#if (myHash["USE_FLASH_MANAGER"]?number != 0)]
void FM_ProcessRequest(void)
{
  /* Trigger to call Flash Manager process function */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask(1U << CFG_TASK_FLASH_MANAGER, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_FlashManager);
[#else]
  osSemaphoreRelease(FlashManagerSemaphore);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_FlashManager, TX_OR);
[#else]
  tx_semaphore_put(&FlashManagerSemaphore);
[/#if]
[/#if]
}

[/#if]
[#if myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled"]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
#if ((CFG_LOG_SUPPORTED == 0) && (CFG_LPM_LEVEL != 0))
/* RNG module turn off HSI clock when traces are not used and low power used */
void RNG_KERNEL_CLK_OFF(void)
{
  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF_1 */

  /* USER CODE END RNG_KERNEL_CLK_OFF_1 */
  LL_RCC_HSI_Disable();
  /* USER CODE BEGIN RNG_KERNEL_CLK_OFF_2 */

  /* USER CODE END RNG_KERNEL_CLK_OFF_2 */
}

#if (CFG_SCM_SUPPORTED == 1)
/* SCM module turn off HSI clock when traces are not used and low power used */
void SCM_HSI_CLK_OFF(void)
{
  /* USER CODE BEGIN SCM_HSI_CLK_OFF_1 */

  /* USER CODE END SCM_HSI_CLK_OFF_1 */
  LL_RCC_HSI_Disable();
  /* USER CODE BEGIN SCM_HSI_CLK_OFF_2 */

  /* USER CODE END SCM_HSI_CLK_OFF_2 */
}
#endif /* CFG_SCM_SUPPORTED */
#endif /* ((CFG_LOG_SUPPORTED == 0) && (CFG_LPM_LEVEL != 0)) */

#if (CFG_LOG_SUPPORTED != 0)
void UTIL_ADV_TRACE_PreSendHook(void)
{
#if (CFG_LPM_LEVEL != 0)
  /* Disable Stop mode before sending a LOG message over UART */
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetStopMode(1U << CFG_LPM_LOG, UTIL_LPM_DISABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_LOG, UTIL_LPM_SLEEP_MODE);
[/#if]
#endif /* (CFG_LPM_LEVEL != 0) */
  /* USER CODE BEGIN UTIL_ADV_TRACE_PreSendHook */

  /* USER CODE END UTIL_ADV_TRACE_PreSendHook */
}

void UTIL_ADV_TRACE_PostSendHook(void)
{
#if (CFG_LPM_LEVEL != 0)
  /* Enable Stop mode after LOG message over UART sent */
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetStopMode(1U << CFG_LPM_LOG, UTIL_LPM_ENABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_LOG, UTIL_LPM_MAX_MODE);
[/#if]
#endif /* (CFG_LPM_LEVEL != 0) */
  /* USER CODE BEGIN UTIL_ADV_TRACE_PostSendHook */

  /* USER CODE END UTIL_ADV_TRACE_PostSendHook */
}

/**
 * @brief  Treat Serial commands.
 *
 * @param  pRxBuffer      Pointer on received data from USART.
 * @param  iRxBufferSize  Number of received data.
 * @retval None
 */
void Serial_CMD_Interpreter_CmdExecute( uint8_t * pRxBuffer, uint16_t iRxBufferSize )
{
  /* USER CODE BEGIN Serial_CMD_Interpreter_CmdExecute_1 */

  /* USER CODE END Serial_CMD_Interpreter_CmdExecute_1 */
}

#endif /* (CFG_LOG_SUPPORTED != 0) */
[/#if]
[/#if]

[#if myHash["THREADX_STATUS"]?number == 1 ]
/**
 * @brief   Enter in LowPower Mode after a ThreadX call
 */
void ThreadXLowPowerUserEnter( void )
{
  /* USER CODE BEGIN ThreadXLowPowerUserEnter_1 */

  /* USER CODE END ThreadXLowPowerUserEnter_1 */

#if ( CFG_LPM_LEVEL != 0 )
  uint32_t lowPowerTimeBeforeSleep, lowPowerTimeAfterSleep, lowPowerTimeDiff, timeDiff;

  LL_PWR_ClearFlag_STOP();

#if ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1))
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
[#else]
#if (CFG_LPM_STOP2_SUPPORTED == 1)
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STOP2_MODE ) )
#else /* (CFG_LPM_STOP2_SUPPORTED == 1) */
#if (CFG_LPM_STANDBY_SUPPORTED == 1)
  if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STANDBY_MODE ) )
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) */
#endif /* (CFG_LPM_STOP2_SUPPORTED == 1) */
[/#if]
  {
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
    APP_SYS_BLE_EnterDeepSleep();
[#else]
    APP_SYS_LPM_EnterLowPowerMode();
[/#if]
  }
#endif /* ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1)) */

  LL_RCC_ClearResetFlags();

#if defined(STM32WBAXX_SI_CUT1_0)
  /* Wait until HSE is ready */
#if (CFG_SCM_SUPPORTED == 1)
  /* SCM HSE BEGIN */
  SCM_HSE_WaitUntilReady();
  /* SCM HSE END */
#else
  while (LL_RCC_HSE_IsReady() == 0);
#endif /* CFG_SCM_SUPPORTED */

  UTILS_ENTER_LIMITED_CRITICAL_SECTION(RCC_INTR_PRIO << 4U);

  scm_hserdy_isr();
  UTILS_EXIT_LIMITED_CRITICAL_SECTION();
#endif /* STM32WBAXX_SI_CUT1_0 */

  HAL_SuspendTick();

  /* Read the current time from RTC, maintainned in standby */
  lowPowerTimeBeforeSleep = getCurrentTime();

  /* Disable SysTick Interrupt */
  SysTick->CTRL &= ~SysTick_CTRL_TICKINT_Msk;
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_EnterLowPower();
[#else]
  UTIL_LPM_Enter(0);
[/#if]

  lowPowerTimeAfterSleep = getCurrentTime();
  /* Compute time spent in low power state and report precision loss */
  lowPowerTimeDiff = (lowPowerTimeAfterSleep - lowPowerTimeBeforeSleep) + lowPowerTimeDiffRemaining;
  /* Store precision loss during RTC time conversion to report it for next OS tick. */
  timeDiff = TIMER_IF_Convert_Tick2ms(lowPowerTimeDiff);
  lowPowerTimeDiffRemaining = lowPowerTimeDiff - TIMER_IF_Convert_ms2Tick(timeDiff);
  /* Report precision loss */
  timeDiff += timeDiffRemaining;
  /* Store precision loss during OS tick time conversion to report it for next OS tick. */
  timeDiffRemaining = timeDiff % (1000/TX_TIMER_TICKS_PER_SECOND);
  
  tx_time_increment(timeDiff / (1000/TX_TIMER_TICKS_PER_SECOND));
#endif /* CFG_LPM_LEVEL */

  /* USER CODE BEGIN ThreadXLowPowerUserEnter_2 */

  /* USER CODE END ThreadXLowPowerUserEnter_2 */
  return;
}

/**
 * @brief   Exit of LowPower Mode after a ThreadX call
 */
void ThreadXLowPowerUserExit( void )
{
  /* USER CODE BEGIN ThreadXLowPowerUserExit_1 */

  /* USER CODE END ThreadXLowPowerUserExit_1 */

#if ( CFG_LPM_LEVEL != 0 )
  HAL_ResumeTick();

  /* Enable SysTick Interrupt */
  SysTick->CTRL |= SysTick_CTRL_TICKINT_Msk;
  LL_AHB5_GRP1_EnableClock( LL_AHB5_GRP1_PERIPH_RADIO );
  (void)ll_sys_dp_slp_exit();
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
  UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[#else]
  UTIL_LPM_SetMaxMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_MAX_MODE);
[/#if]
[/#if]
#endif /* CFG_LPM_LEVEL */

  /* USER CODE BEGIN ThreadXLowPowerUserExit_2 */

  /* USER CODE END ThreadXLowPowerUserExit_2 */
  return;
}

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
/* Implement weak function to setup a timer that will trig OS ticks */
void vPortSetupTimerInterrupt( void )
{
  UTIL_TIMER_Create(&TimerOsTick_Id,
                    portTICK_PERIOD_MS,
                    UTIL_TIMER_PERIODIC,
                    &TimerOsTickCb, 0);

  UTIL_TIMER_StartWithPeriod(&TimerOsTick_Id, portTICK_PERIOD_MS);
  /* USER CODE BEGIN vPortSetupTimerInterrupt */

  /* USER CODE END vPortSetupTimerInterrupt */
  return;
}
#if ( CFG_LPM_LEVEL != 0)
void vPortSuppressTicksAndSleep( uint32_t xExpectedIdleTime )
{
  uint32_t lowPowerTimeBeforeSleep, lowPowerTimeAfterSleep, lowPowerTimeDiff, timeDiff;
  eSleepModeStatus eSleepStatus;

  /* Stop the timer that is generating the OS tick interrupt. */
  UTIL_TIMER_Stop(&TimerOsTick_Id);


  /* Make sure the SysTick reload value does not overflow the counter. */
  if( xExpectedIdleTime > maximumPossibleSuppressedTicks )
  {
    xExpectedIdleTime = maximumPossibleSuppressedTicks;
  }

  /* Enter a critical section but don't use the taskENTER_CRITICAL()
   * method as that will mask interrupts that should exit sleep mode. */
  __asm volatile ( "cpsid i" ::: "memory" );
  __asm volatile ( "dsb" );
  __asm volatile ( "isb" );

  eSleepStatus = eTaskConfirmSleepModeStatus();

  /* If a context switch is pending or a task is waiting for the scheduler
   * to be unsuspended then abandon the low power entry. */
  if( eSleepStatus == eAbortSleep )
  {
    /* Restart the timer that is generating the OS tick interrupt. */
    UTIL_TIMER_StartWithPeriod(&TimerOsTick_Id, portTICK_PERIOD_MS);

    /* Re-enable interrupts - see comments above the cpsid instruction above. */
    __asm volatile ( "cpsie i" ::: "memory" );
  }
  else
  {
    if( eSleepStatus != eNoTasksWaitingTimeout )
    {
      /* Configure an interrupt to bring the microcontroller out of its low
         power state at the time the kernel next needs to execute. The
         interrupt must be generated from a source that remains operational
         when the microcontroller is in a low power state. */
      UTIL_TIMER_StartWithPeriod(&TimerOSwakeup_Id, (xExpectedIdleTime - 1) * portTICK_PERIOD_MS);
    }

    /* Read the current time from RTC, maintainned in standby */
    lowPowerTimeBeforeSleep = getCurrentTime();

    /* Enter the low power state. */

    LL_PWR_ClearFlag_STOP();
#if ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1))
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
    if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMode() == UTIL_LPM_OFFMODE ) )
[#else]
#if (CFG_LPM_STOP2_SUPPORTED == 1)
    if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STOP2_MODE ) )
#else /* (CFG_LPM_STOP2_SUPPORTED == 1) */
#if (CFG_LPM_STANDBY_SUPPORTED == 1)
    if ( ( system_startup_done != FALSE ) && ( UTIL_LPM_GetMaxMode() >= UTIL_LPM_STANDBY_MODE ) )
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) */
#endif /* (CFG_LPM_STOP2_SUPPORTED == 1) */
[/#if]
    {
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
      APP_SYS_BLE_EnterDeepSleep();
[#else]
      APP_SYS_LPM_EnterLowPowerMode();
[/#if]
    }
#endif /* ((CFG_LPM_STANDBY_SUPPORTED == 1) || (CFG_LPM_STOP2_SUPPORTED == 1)) */
    LL_RCC_ClearResetFlags();

    HAL_SuspendTick();
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
    UTIL_LPM_EnterLowPower(); /* WFI instruction call is inside this API */
[#else]
    UTIL_LPM_Enter(0); /* WFI instruction call is inside this API */
[/#if]
    HAL_ResumeTick();

    /* Stop the timer that may wakeup us as wakeup source can be another one */
    UTIL_TIMER_Stop(&TimerOSwakeup_Id);

    /* Determine how long the microcontroller was actually in a low power
     state for, which will be less than xExpectedIdleTime if the
     microcontroller was brought out of low power mode by an interrupt
     other than that configured by the vSetWakeTimeInterrupt() call.
     Note that the scheduler is suspended before
     portSUPPRESS_TICKS_AND_SLEEP() is called, and resumed when
     portSUPPRESS_TICKS_AND_SLEEP() returns.  Therefore no other tasks will
     execute until this function completes. */
    lowPowerTimeAfterSleep = getCurrentTime();

    /* Compute time spent in low power state and report precision loss */
    lowPowerTimeDiff = (lowPowerTimeAfterSleep - lowPowerTimeBeforeSleep) + lowPowerTimeDiffRemaining;
    /* Store precision loss during RTC time conversion to report it for next OS tick. */
    timeDiff = TIMER_IF_Convert_Tick2ms(lowPowerTimeDiff);
    lowPowerTimeDiffRemaining = lowPowerTimeDiff - TIMER_IF_Convert_ms2Tick(timeDiff);
    /* Report precision loss */
    timeDiff += timeDiffRemaining;
    /* Store precision loss during OS tick time conversion to report it for next OS tick. */
    timeDiffRemaining = timeDiff % portTICK_PERIOD_MS;

    /* Correct the kernel tick count to account for the time spent in its low power state. */
    vTaskStepTick( timeDiff / portTICK_PERIOD_MS );

    /* Re-enable interrupts to allow the interrupt that brought the MCU
     * out of sleep mode to execute immediately.  See comments above
     * the cpsid instruction above. */
    __asm volatile ( "cpsie i" ::: "memory" );
    __asm volatile ( "dsb" );
    __asm volatile ( "isb" );

    /* Put the radio in active state */
    if( system_startup_done != FALSE )
    {
      LL_AHB5_GRP1_EnableClock(LL_AHB5_GRP1_PERIPH_RADIO);
      (void)ll_sys_dp_slp_exit();
    }
[#if (myHash["BLE"] == "Enabled") || (myHash["BLE_MODE_SKELETON"] == "Enabled") || (myHash["BLE_MODE_HOST_SKELETON"] == "Enabled")]
[#if (myHash["CFG_LPM_ENHANCED"]?number == 0)]
    UTIL_LPM_SetOffMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_ENABLE);
[#else]
    UTIL_LPM_SetMaxMode(1U << CFG_LPM_LL_DEEPSLEEP, UTIL_LPM_MAX_MODE);
[/#if]
[/#if]

    /* Restart the timer that is generating the OS tick interrupt. */
    UTIL_TIMER_StartWithPeriod(&TimerOsTick_Id, portTICK_PERIOD_MS);
  }
  return;
}
#else
void vPortSuppressTicksAndSleep( uint32_t xExpectedIdleTime )
{
  return;
}
#endif /* ( CFG_LPM_LEVEL != 0) */

[/#if]
[#if (myHash["ZIGBEE"] == "Enabled") || (myHash["ZIGBEE_SKELETON"] == "Enabled") || (myHash["THREAD"] == "Enabled") || (myHash["THREAD_SKELETON"] == "Enabled")]
/**
 * @brief Function Assert AEABI in case of not described on 'libc' libraries.
 */
__WEAK void __aeabi_assert(const char * szExpression, const char * szFile, int iLine)
{
  Error_Handler();
  __builtin_unreachable();
}

[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if (myHash["ZIGBEE"] == "Disabled") ]
CRCCTRL_Cmd_Status_t CRCCTRL_MutexTake(void)
{
  osStatus_t os_status;
  CRCCTRL_Cmd_Status_t crc_status;
  /* USER CODE BEGIN CRCCTRL_MutexTake_0 */

  /* USER CODE END CRCCTRL_MutexTake_0 */
  if (xTaskGetSchedulerState() == taskSCHEDULER_RUNNING)
  {
    os_status = osMutexAcquire(crcCtrlMutex, osWaitForever);
  }
  else
  {
    /* If the scheduler is not running, we can assume that the mutex is available */
    os_status = osOK;
  }

  if(os_status != osOK)
  {
    crc_status = CRCCTRL_NOK;
  }
  else
  {
    crc_status = CRCCTRL_OK;
  }
  /* USER CODE BEGIN CRCCTRL_MutexTake_1 */

  /* USER CODE END CRCCTRL_MutexTake_1 */
  return crc_status;
}

CRCCTRL_Cmd_Status_t CRCCTRL_MutexRelease(void)
{
  osStatus_t os_status;
  CRCCTRL_Cmd_Status_t crc_status;
  /* USER CODE BEGIN CRCCTRL_MutexRelease_0 */

  /* USER CODE END CRCCTRL_MutexRelease_0 */
  if (xTaskGetSchedulerState() == taskSCHEDULER_RUNNING)
  {
    os_status = osMutexRelease(crcCtrlMutex);
  }
  else
  {
    /* If the scheduler is not running, we can assume that the mutex is available */
    os_status = osOK;
  }

  if(os_status != osOK)
  {
    crc_status = CRCCTRL_NOK;
  }
  else
  {
    crc_status = CRCCTRL_OK;
  }
  /* USER CODE BEGIN CRCCTRL_MutexRelease_1 */

  /* USER CODE END CRCCTRL_MutexRelease_1 */
  return crc_status;
}

[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
ADCCTRL_Cmd_Status_t ADCCTRL_MutexTake(void)
{
  osStatus_t os_status;
  ADCCTRL_Cmd_Status_t adc_status;
  /* USER CODE BEGIN ADCCTRL_MutexTake_0 */

  /* USER CODE END ADCCTRL_MutexTake_0 */
  if (xTaskGetSchedulerState() == taskSCHEDULER_RUNNING)
  {
    os_status = osMutexAcquire(adcCtrlMutex, osWaitForever);
  }
  else
  {
    /* If the scheduler is not running, we can assume that the mutex is available */
    os_status = osOK;
  }

  if(os_status != osOK)
  {
    adc_status = ADCCTRL_NOK;
  }
  else
  {
    adc_status = ADCCTRL_OK;
  }
  /* USER CODE BEGIN ADCCTRL_MutexTake_1 */

  /* USER CODE END ADCCTRL_MutexTake_1 */
  return adc_status;
}

ADCCTRL_Cmd_Status_t ADCCTRL_MutexRelease(void)
{
  osStatus_t os_status;
  ADCCTRL_Cmd_Status_t adc_status;
  /* USER CODE BEGIN ADCCTRL_MutexRelease_0 */

  /* USER CODE END ADCCTRL_MutexRelease_0 */
  if (xTaskGetSchedulerState() == taskSCHEDULER_RUNNING)
  {
    os_status = osMutexRelease(adcCtrlMutex);
  }
  else
  {
    /* If the scheduler is not running, we can assume that the mutex is available */
    os_status = osOK;
  }

  if(os_status != osOK)
  {
    adc_status = ADCCTRL_NOK;
  }
  else
  {
    adc_status = ADCCTRL_OK;
  }
  /* USER CODE BEGIN ADCCTRL_MutexRelease_1 */

  /* USER CODE END ADCCTRL_MutexRelease_1 */
  return adc_status;
}
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]

#if (HAL_TICK_RTC == 1)
/* Overwrite HAL Tick functions to not use sysTick but RTC */
HAL_StatusTypeDef HAL_InitTick(uint32_t TickPriority)
{
  if(TimerHalTick_Id.Callback == NULL)
  {
    /* Create an RTC based timer to trigger HAL tick increment */
    UTIL_TIMER_Create(&TimerHalTick_Id,
                      HAL_TICK_FREQ_100HZ,
                      UTIL_TIMER_PERIODIC,
                      &TimerHalTickCb, 0);
    uwTickFreq = HAL_TICK_FREQ_100HZ;
  }
  return HAL_OK;
}

void HAL_SuspendTick(void)
{
  UTIL_TIMER_Stop(&TimerHalTick_Id);
  return;
}

void HAL_ResumeTick(void)
{
  UTIL_TIMER_Start(&TimerHalTick_Id);
  return;
}

static void HAL_StartTick(void)
{
  UTIL_TIMER_StartWithPeriod(&TimerHalTick_Id, HAL_TICK_FREQ_100HZ);
  return;
}
#endif /* HAL_TICK_RTC */


[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if (myHash["ZIGBEE"] == "Disabled") ]
CRCCTRL_Cmd_Status_t CRCCTRL_MutexTake(void)
{
  UINT TXstatus;
  CRCCTRL_Cmd_Status_t crc_status;
  /* USER CODE BEGIN CRCCTRL_MutexTake_0 */

  /* USER CODE END CRCCTRL_MutexTake_0 */
  if(TX_THREAD_GET_SYSTEM_STATE() == TX_INITIALIZE_IS_FINISHED)
  {
    TXstatus = tx_mutex_get(&crcCtrlMutex, TX_WAIT_FOREVER);
  }
  else
  {
    TXstatus = TX_SUCCESS;
  }

  if(TXstatus != TX_SUCCESS)
  {
    crc_status = CRCCTRL_NOK;
  }
  else
  {
    crc_status = CRCCTRL_OK;
  }
  /* USER CODE BEGIN CRCCTRL_MutexTake_1 */

  /* USER CODE END CRCCTRL_MutexTake_1 */
  return crc_status;
}

CRCCTRL_Cmd_Status_t CRCCTRL_MutexRelease(void)
{
  UINT TXstatus;
  CRCCTRL_Cmd_Status_t crc_status;
  /* USER CODE BEGIN CRCCTRL_MutexRelease_0 */

  /* USER CODE END CRCCTRL_MutexRelease_0 */
  if(TX_THREAD_GET_SYSTEM_STATE() == TX_INITIALIZE_IS_FINISHED)
  {
    TXstatus = tx_mutex_put(&crcCtrlMutex);
  }
  else
  {
    TXstatus = TX_SUCCESS;
  }

  if(TXstatus != TX_SUCCESS)
  {
    crc_status = CRCCTRL_NOK;
  }
  else
  {
    crc_status = CRCCTRL_OK;
  }
  /* USER CODE BEGIN CRCCTRL_MutexRelease_1 */

  /* USER CODE END CRCCTRL_MutexRelease_1 */
  return crc_status;
}

[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
ADCCTRL_Cmd_Status_t ADCCTRL_MutexTake(void)
{
  UINT TXstatus;
  ADCCTRL_Cmd_Status_t adc_status;
  /* USER CODE BEGIN ADCCTRL_MutexTake_0 */

  /* USER CODE END ADCCTRL_MutexTake_0 */
  if(TX_THREAD_GET_SYSTEM_STATE() == TX_INITIALIZE_IS_FINISHED)
  {
    TXstatus = tx_mutex_get(&adcCtrlMutex, TX_WAIT_FOREVER);
  }
  else
  {
    TXstatus = TX_SUCCESS;
  }

  if(TXstatus != TX_SUCCESS)
  {
    adc_status = ADCCTRL_NOK;
  }
  else
  {
    adc_status = ADCCTRL_OK;
  }
  /* USER CODE BEGIN ADCCTRL_MutexTake_1 */

  /* USER CODE END ADCCTRL_MutexTake_1 */
  return adc_status;
}

ADCCTRL_Cmd_Status_t ADCCTRL_MutexRelease(void)
{
  UINT TXstatus;
  ADCCTRL_Cmd_Status_t adc_status;
  /* USER CODE BEGIN ADCCTRL_MutexRelease_0 */

  /* USER CODE END ADCCTRL_MutexRelease_0 */
  if(TX_THREAD_GET_SYSTEM_STATE() == TX_INITIALIZE_IS_FINISHED)
  {
    TXstatus = tx_mutex_put(&adcCtrlMutex);
  }
  else
  {
    TXstatus = TX_SUCCESS;
  }

  if(TXstatus != TX_SUCCESS)
  {
    adc_status = ADCCTRL_NOK;
  }
  else
  {
    adc_status = ADCCTRL_OK;
  }
  /* USER CODE BEGIN ADCCTRL_MutexRelease_1 */

  /* USER CODE END ADCCTRL_MutexRelease_1 */
  return adc_status;
}
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

[/#if]
[/#if]
/* USER CODE BEGIN FD_WRAP_FUNCTIONS */

/* USER CODE END FD_WRAP_FUNCTIONS */
