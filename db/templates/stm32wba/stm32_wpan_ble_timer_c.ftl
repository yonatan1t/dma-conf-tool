[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    ble_timer.c
  * @author  MCD Application Team
  * @brief   This module implements the timer core functions
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

/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "app_common.h"
#include "log_module.h"
#include "blestack.h"
#include "host_stack_if.h"
#include "stm32_timer.h"
#include "bleplat.h"
#include "stm_list.h"
#include "ble_timer.h"
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
#include "advanced_memory_manager.h"
[/#if]
#include "app_conf.h"
#include "ll_sys.h"
#include "stm32_rtos.h"

/* Private typedef -----------------------------------------------------------*/
typedef struct
{
  tListNode           node;         /* Actual node in the list */
  uint16_t            id;           /* Id of the timer */
  UTIL_TIMER_Object_t timerObject;  /* Timer Server object */
}BLE_TIMER_t;

/* Private defines -----------------------------------------------------------*/

/* Private variables ---------------------------------------------------------*/
static tListNode BLE_TIMER_RunningList;
static tListNode BLE_TIMER_ExpiredList;

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
/* FreeRTOS objects declaration */

static osThreadId_t     BleTimerTaskHandle;
static osSemaphoreId_t  BleTimerSemaphore;

const osThreadAttr_t BleTimerTask_attributes = {
  .name         = "BLE Timer Task",
  .priority     = TASK_PRIO_BLE_TIMER,
  .stack_size   = TASK_STACK_SIZE_BLE_TIMER,
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE,
  .stack_mem    = TASK_DEFAULT_STACK_MEM
};

const osSemaphoreAttr_t BleTimerSemaphore_attributes = {
  .name         = "BLE Timer Semaphore",
  .attr_bits    = TASK_DEFAULT_ATTR_BITS,
  .cb_mem       = TASK_DEFAULT_CB_MEM,
  .cb_size      = TASK_DEFAULT_CB_SIZE
};

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
/* ThreadX objects declaration */

static TX_THREAD        BleTimerTaskHandle;
static TX_SEMAPHORE     BleTimerSemaphore;

[/#if]
[/#if]
/* Private functions prototype------------------------------------------------*/
static void BLE_TIMER_Callback(void* arg);
static BLE_TIMER_t* BLE_TIMER_GetFromList(tListNode * listHead, uint16_t id);
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BLE_TIMER_Task_Entry(void* argument);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
static void BLE_TIMER_Task_Entry(ULONG lArgument);
[/#if]
[/#if]

void BLE_TIMER_Init(void)
{
  /* This function initializes the timer Queue */
  LST_init_head(&BLE_TIMER_RunningList);
  LST_init_head(&BLE_TIMER_ExpiredList);

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  /* Register BLE Timer task */
  UTIL_SEQ_RegTask(1U << CFG_TASK_BLE_TIMER_BCKGND, UTIL_SEQ_RFU, BLE_TIMER_Background);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
  /* Create BLE Timer FreeRTOS objects */

  BleTimerTaskHandle = osThreadNew(BLE_TIMER_Task_Entry, NULL, &BleTimerTask_attributes);

  BleTimerSemaphore = osSemaphoreNew(1U, 0U, &BleTimerSemaphore_attributes);

  if((BleTimerTaskHandle == NULL) || (BleTimerSemaphore == NULL) )
  {
    LOG_ERROR_APP( "BLE Timer FreeRTOS objects creation FAILED");
    Error_Handler();
  }
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
  UINT TXstatus;
  CHAR *pStack;

  /* Create BLE Timer ThreadX objects */

  TXstatus = tx_byte_allocate(pBytePool, (void **)&pStack, TASK_STACK_SIZE_BLE_TIMER, TX_NO_WAIT);

  if( TXstatus == TX_SUCCESS )
  {
    TXstatus = tx_thread_create(&BleTimerTaskHandle, "BLE Timer Task", BLE_TIMER_Task_Entry, 0,
                                 pStack, TASK_STACK_SIZE_BLE_TIMER,
                                 TASK_PRIO_BLE_TIMER, TASK_PREEMP_BLE_TIMER,
                                 TX_NO_TIME_SLICE, TX_AUTO_START);

    TXstatus |= tx_semaphore_create(&BleTimerSemaphore, "BLE Timer Semaphore", 0);
  }

  if( TXstatus != TX_SUCCESS )
  {
    LOG_ERROR_APP( "BLE Timer ThreadX objects creation FAILED, status: %d", TXstatus);
    Error_Handler();
  }
[/#if]
[/#if]
}

uint8_t BLE_TIMER_Start(uint16_t id, uint32_t timeout)
{
  BLE_TIMER_t *timer = NULL;

  /* If the timer's id already exists, stop it */
  BLE_TIMER_Stop(id);

  /* Create a new timer instance and add it to the list */
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
  if(AMM_ERROR_OK != AMM_Alloc (CFG_AMM_VIRTUAL_BLE_TIMERS,
                                DIVC(sizeof(BLE_TIMER_t), sizeof(uint32_t)),
                                (uint32_t **)&timer,
                                NULL))
[#else]
  timer = (BLE_TIMER_t *)malloc(sizeof(BLE_TIMER_t));
  if(timer == NULL)
[/#if]
  {
    return BLE_STATUS_INSUFFICIENT_RESOURCES;
  }

  if(UTIL_TIMER_Create(&timer->timerObject, timeout, UTIL_TIMER_ONESHOT, &BLE_TIMER_Callback, timer) != UTIL_TIMER_OK)
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    (void)AMM_Free((uint32_t *)timer);
[#else]
    free(timer);
[/#if]
    return BLE_STATUS_FAILED;
  }

  if(UTIL_TIMER_Start(&timer->timerObject) != UTIL_TIMER_OK)
  {
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    (void)AMM_Free((uint32_t *)timer);
[#else]
    free(timer);
[/#if]
    return BLE_STATUS_FAILED;
  }

  timer->id = id;
  LST_insert_tail(&BLE_TIMER_RunningList, (tListNode *)timer);

  return BLE_STATUS_SUCCESS;
}

void BLE_TIMER_Stop(uint16_t id)
{
  BLE_TIMER_t* timer;

  /* Search for the id in the running timers list */
  timer = BLE_TIMER_GetFromList(&BLE_TIMER_RunningList, id);
  /* If not found, try elapsed timers list */
  if (NULL == timer)
  {
    timer = BLE_TIMER_GetFromList(&BLE_TIMER_ExpiredList, id);
  }

  /* If the timer's id exists, stop it */
  if(NULL != timer)
  {
    UTIL_TIMER_Stop(&timer->timerObject);
    LST_remove_node((tListNode *)timer);

[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    (void)AMM_Free((uint32_t *)timer);
[#else]
    free(timer);
[/#if]
  }
}

void BLE_TIMER_Background(void)
{
  BLE_TIMER_t* timer;

  if (TRUE != LST_is_empty(&BLE_TIMER_ExpiredList))
  {
    /* Get first timer from (sorted) expired list and remove it from this list */
    LST_remove_head(&BLE_TIMER_ExpiredList, (tListNode **)&timer);
    BLEPLATCB_TimerExpiry(timer->id);
    BleStackCB_Process();
[#if (myHash["CFG_MM_TYPE"]?number == 2)]
    (void)AMM_Free((uint32_t *)timer);
[#else]
    free(timer);
[/#if]

    if (TRUE != LST_is_empty(&BLE_TIMER_ExpiredList))
    {
      /* At least one other timer expired and has not been processed,
         so trigger task again */
[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
      UTIL_SEQ_SetTask( 1U << CFG_TASK_BLE_TIMER_BCKGND, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
      tx_semaphore_ceiling_put(&BleTimerSemaphore, 1);
[#else]
      tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_BLEtimer, TX_OR);
[/#if]
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
      osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_BLEtimer);
[#else]
      osSemaphoreRelease(BleTimerSemaphore);
[/#if]
[/#if]
    }
  }
}

[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] != "SINGLE_TASK" ]
static void BLE_TIMER_Task_Entry(void* argument)
{
  UNUSED(argument);

  for(;;)
  {
    osSemaphoreAcquire(BleTimerSemaphore, osWaitForever);
    BLE_TIMER_Background();
    osThreadYield();
  }
}

[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
static void BLE_TIMER_Task_Entry(ULONG lArgument)
{
  UNUSED(lArgument);

  for(;;)
  {
    tx_semaphore_get(&BleTimerSemaphore, TX_WAIT_FOREVER);
    BLE_TIMER_Background();
    tx_thread_relinquish();
  }
}

[/#if]
[/#if]
static void BLE_TIMER_Callback(void* arg)
{
  /* Remove timer from running list */
  LST_remove_node((tListNode *)arg);
  /* Add it to expired list */
  LST_insert_tail(&BLE_TIMER_ExpiredList, (tListNode *)arg);

[#if myHash["SEQUENCER_STATUS"]?number == 1 ]
  UTIL_SEQ_SetTask( 1U << CFG_TASK_BLE_TIMER_BCKGND, CFG_SEQ_PRIO_0);
[/#if]
[#if myHash["FREERTOS_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "SINGLE_TASK" ]
  osThreadFlagsSet(WpanTaskHandle, 1U << CFG_RTOS_FLAG_BLEtimer);
[#else]
  osSemaphoreRelease(BleTimerSemaphore);
[/#if]
[/#if]
[#if myHash["THREADX_STATUS"]?number == 1 ]
[#if myHash["WPAN_RTOS_MODEL"] == "MULTI_TASK" ]
  tx_semaphore_ceiling_put(&BleTimerSemaphore, 1);
[#else]
  tx_event_flags_set(&WpanEventFlag, 1U << CFG_RTOS_FLAG_BLEtimer, TX_OR);
[/#if]
[/#if]
}

static BLE_TIMER_t* BLE_TIMER_GetFromList(tListNode * listHead, uint16_t id)
{
  BLE_TIMER_t* currentNode;

  LST_get_next_node(listHead, (tListNode **)&currentNode);
  while((tListNode *)currentNode != listHead)
  {
    if(currentNode->id == id)
    {
      return currentNode;
    }
    LST_get_next_node((tListNode *)currentNode, (tListNode **)&currentNode);
  }
  return NULL;
}