[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    peripheral_init.c
  * @author  MCD Application Team
  * @brief   tbd module
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
[#assign listIP = {}]
[#assign val = ""]
[#assign aesnb = 0]
[#assign i = 0]
[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName != "SystemClock_Config")
       && (void.functionName != "SystemPower_Config")
       && (void.functionName != "MX_RTC_Init")
       && (void.functionName != "APPE_Init")
       && (void.functionName != "MX_RF_Init")
       && (void.functionName != "MX_CORTEX_M33_Init")
       && (void.functionName != "MX_CORTEX_M33_NS_Init")
       && (void.functionName != "MX_HSEM_Init")
       && (void.functionName != "MX_ADC4_Init")
       && (void.functionName != "MX_CRC_Init")]
       [#assign val = void.functionName?remove_beginning('MX_')?remove_ending("_Init")]
            [#if val?contains("USART")]
                [#assign val = val?lower_case]
                [#assign val = val?remove_ending("_uart")]
                [#assign val = val?replace("usart","uart")]
            [/#if]
            [#if val?contains("LPUART1")]
                [#assign val = val?lower_case]
                [#assign val = val?remove_ending("_uart")]
            [/#if]
            [#if (val?contains("AES") || val?contains("SAES_AES")) && aesnb == 0]
                  [#assign val = "cryp"]
                  [#assign aesnb = aesnb+1]
            [/#if]
            [#if val!="AES" && val!="SAES_AES"]
              [#if  val?contains("GPDMA")]
                 [#assign listIP = {i: val} + listIP]
                 [#assign i = i+1]
              [#elseif val?contains("SAI1")]
                 [#assign listIP = {i: "sai"} + listIP]
                 [#assign i = i+1]
              [#else]
                 [#assign val = val?lower_case]
                 [#assign listIP = {i: val} + listIP]
                 [#assign i = i+1]
              [/#if]
            [/#if]
    [/#if]
    [/#if]
  [/#list]
[/#if]
[#assign IpInstance = ""]
[#assign InstanceLog = ""]
[#assign useInstance    = ""]
[#if BspIpDatas??]
[#list BspIpDatas as SWIP]
    [#if SWIP.variables??]
        [#list SWIP.variables as variables]
            [#if variables.name?contains("IpInstance")]
                [#assign IpInstance = variables.value]
            [/#if]
            [#if variables.value?contains("Serial Link for Logs")]
                [#assign InstanceLog  = IpInstance]
            [/#if]
	    [/#list]
	[/#if]
[/#list]
[/#if]
[#if InstanceLog?contains("USART1")]
[#assign useInstance    = "huart1"]
[/#if]
[#if InstanceLog?contains("USART2")]
[#assign useInstance    = "huart2"]
[/#if]
[#if InstanceLog?contains("USART3")]
[#assign useInstance    = "huart3"]
[/#if]
[#if InstanceLog?contains("LPUART1")]
[#assign useInstance    = "hlpuart1"]
[/#if]
/* Includes ------------------------------------------------------------------*/
#include "app_conf.h"
#include "peripheral_init.h"
[#if !HALCompliant??]
[#assign timnbr = 0]
[#assign gpionbr = 0]
[#assign i2cnbr = 0]
[#assign lptimnbr = 0]
[#assign spinbr = 0]
[#assign aesnbr = 0]
[#assign usartnbr = 0]
[#assign compnbr = 0]
[#list UsedIPs as pin]
 [#list listIP?keys as key]
  [#if pin?lower_case == listIP[key] || pin == listIP[key] || pin?lower_case?contains(listIP[key])]
    [#if !listIP[key]?contains("i2c") && !listIP[key]?contains("tim")
	&& !listIP[key]?contains("spi") && !listIP[key]?contains("lptim")
	&& !listIP[key]?contains("lpuart") && !listIP[key]?contains("uart")
	&& !listIP[key]?contains("comp")  && !listIP[key]?contains("GPDMA")]
#include "${listIP[key]}.h"
    [/#if]
	[#if listIP[key]?contains("i2c") && i2cnbr== 0]
#include "i2c.h"
[#assign i2cnbr = i2cnbr+1]
    [/#if]
	[#if listIP[key]?contains("tim") && timnbr== 0]
#include "tim.h"
[#assign timnbr = timnbr+1]
    [/#if]
	[#if listIP[key]?contains("spi") && spinbr== 0]
#include "spi.h"
[#assign spinbr = spinbr+1]
	[/#if]
	[#if listIP[key]?contains("lptim") && lptimnbr== 0]
#include "lptim.h"
[#assign lptimnbr = lptimnbr+1]
	[/#if]
	[#if listIP[key]?contains("comp") && compnbr== 0]
#include "comp.h"
	   [#assign compnbr = compnbr+1]
	[/#if]
	[#if listIP[key]?contains("GPDMA")]
#include "gpdma.h"
    [/#if]
[/#if]
    [#if (listIP[key]?contains("lpuart")|| listIP[key]?contains("uart")) && usartnbr== 0]
#include "usart.h"
[#assign usartnbr = usartnbr+1]
    [/#if]
    [#if listIP[key]?contains("tamp_rtc") && pin?lower_case?contains("tamp")]
#include "${pin?lower_case}.h"
	[/#if]
    [#if (pin?lower_case?contains("aes") || pin?lower_case?contains("saes")) && aesnbr== 0]
#include "aes.h"
[#assign aesnbr = aesnbr+1]
    [/#if]
    [#if listIP[key]?contains("gpio") && gpionbr== 0 ]
#include "gpio.h"
[#assign gpionbr = gpionbr+1]
    [/#if]
[/#list]
[/#list]
[#else]
#include "${main_h}"
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
#include "crc_ctrl.h"
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
#include "adc_ctrl.h"
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]
#if (CFG_LPM_WAKEUP_TIME_PROFILING == 1)
#include "stm32_lpm_if.h"
#endif /* CFG_LPM_WAKEUP_TIME_PROFILING */
/* Private includes -----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */
[#-- [#if NVICSystemInit??]
 /**
  * @brief  Configure the CPU NVIC peripheral at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_NVICPeripharalInit(void)
{
  [#list NVICSystemInit as initVector]
#t${""?right_pad(2)}HAL_NVIC_SetPriority(${initVector.vector}, ${initVector.preemptionPriority}, ${initVector.subPriority});
#t${""?right_pad(2)}HAL_NVIC_EnableIRQ(${initVector.vector});
  [/#list]
}
[/#if] --]

/* External variables --------------------------------------------------------*/
[#assign PreviousHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if (ipHandler.handler != "hrtc")
    ]
         [#list listIP?keys as key]
           [#if ipHandler.handler?contains(listIP[key])]
            [#if ipHandler.handler != PreviousHandler]
              [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc"))]
extern ${ipHandler.handlerType} ${ipHandler.handler};
              [/#if]
              [#assign PreviousHandler = ipHandler.handler]
            [/#if]
           [/#if]
         [/#list]
        [/#if]
    [/#list]
  [/#list]
[/#list]
[/#if]

/* USER CODE BEGIN EV */


/* USER CODE END EV */

/* Functions Definition ------------------------------------------------------*/

#if (CFG_LPM_STANDBY_SUPPORTED == 1)
/**
  * @brief  Configure the SoC peripherals at Standby mode exit.
  * @param  None
  * @retval None
  */
void MX_StandbyExit_PeripheralInit(void)
{
  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_1 */

#if (CFG_LPM_WAKEUP_TIME_PROFILING == 1)
#if (CFG_LPM_STANDBY_SUPPORTED == 1)
  /* Do not configure sysTick if currently used by wakeup time profiling mechanism */
  if(LPM_is_wakeup_time_profiling_done() != 0)
  {
    /* Select SysTick source clock */
    HAL_SYSTICK_CLKSourceConfig(${myHash["SYSTICK_SOURCE_CLOCK_SELECTION"]});

    /* Initialize SysTick */
    if (HAL_InitTick(TICK_INT_PRIORITY) != HAL_OK)
    {
      assert_param(0);
    }
  }
#endif /* CFG_LPM_STANDBY_SUPPORTED */
#else
  /* Select SysTick source clock */
  HAL_SYSTICK_CLKSourceConfig(${myHash["SYSTICK_SOURCE_CLOCK_SELECTION"]});

  /* Initialize SysTick */
  if (HAL_InitTick(TICK_INT_PRIORITY) != HAL_OK)
  {
    assert_param(0);
  }
#endif /* CFG_LPM_WAKEUP_TIME_PROFILING */

#if (CFG_DEBUGGER_LEVEL == 0)
  /* Setup GPIOA 13, 14, 15 in Analog no pull */
  __HAL_RCC_GPIOA_CLK_ENABLE();
  GPIOA->PUPDR &= ~0xFC000000;
  GPIOA->MODER |= 0xFC000000;
  __HAL_RCC_GPIOA_CLK_DISABLE();

  /* Setup GPIOB 3, 4 in Analog no pull */
  __HAL_RCC_GPIOB_CLK_ENABLE();
  GPIOB->PUPDR &= ~0x3C0;
  GPIOB->MODER |= 0x3C0;
  __HAL_RCC_GPIOB_CLK_DISABLE();
#endif /* CFG_DEBUGGER_LEVEL */

[#assign PreviousIpHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if (ipHandler.handler != "hrtc")]
          [#list listIP?keys as key]
            [#if ipHandler.handler?contains(listIP[key])]
              [#if ipHandler.handler != PreviousIpHandler]
                [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc") && (ipHandler.handler != "hrng"))]
                  [#if (ipHandler.handler == useInstance)]
#if (CFG_LOG_SUPPORTED == 1)
${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
#endif
			            [#else]
${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
			            [/#if]
                [/#if]
                [#assign PreviousIpHandler = ipHandler.handler]
              [/#if]
	          [/#if]
	        [/#list]
        [/#if]
      [/#list]
    [/#list]
  [/#list]
[/#if]

[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName != "SystemClock_Config")
      && (void.functionName != "SystemPower_Config")
      && (void.functionName != "MX_RTC_Init")
      && (void.functionName != "APPE_Init")
      && (void.functionName != "MX_RF_Init")
      && (void.functionName != "MX_CORTEX_M33_Init")
      && (void.functionName != "MX_CORTEX_M33_NS_Init")
      && (void.functionName != "MX_HSEM_Init")
      && (void.functionName != "MX_ADC4_Init")
      && (void.functionName != "MX_RNG_Init")
      && (void.functionName != "MX_CRC_Init")]
	   [#if (void.functionName == "MX_"+InstanceLog+"_UART_Init")]
#if (CFG_LOG_SUPPORTED == 1)
${""?right_pad(2)}${void.functionName}();
#endif
       [#else]
${""?right_pad(2)}${void.functionName}();
       [/#if]
    [/#if]
  [/#if]
  [/#list]
[/#if]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  CRCCTRL_Init();
[/#if]
[#if (myHash["USE_TEMPERATURE_BASED_RADIO_CALIBRATION"]?number == 1)]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */
[/#if]

  /* USER CODE BEGIN MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */

  /* USER CODE END MX_STANDBY_EXIT_PERIPHERAL_INIT_2 */
}
#endif /* (CFG_LPM_STANDBY_SUPPORTED == 1) */
[#if (myHash["HW_STOP2_SUPPORTED"]?number == 1)]

#if (CFG_LPM_STOP2_SUPPORTED == 1)
void MX_Stop2Exit_PeripheralInit(void)
{
  /* USER CODE BEGIN MX_STOP2_EXIT_PERIPHERAL_INIT_1 */
  /* USER CODE END MX_STOP2_EXIT_PERIPHERAL_INIT_1 */

[#assign PreviousIpHandler = ""]
[#if handlersList??]
  [#list handlersList as handler]
    [#list handler.entrySet() as entry]
      [#list entry.value as ipHandler]
        [#if (ipHandler.handler != "hrtc")
          && (ipHandler.handler != "handle_GPDMA1_Channel1")
          && (ipHandler.handler != "handle_GPDMA1_Channel0")
          && (ipHandler.handler != "huart1")
	        && (ipHandler.handler != "hramcfg_SRAM1")
        ]
          [#list listIP?keys as key]
            [#if ipHandler.handler?contains(listIP[key])]
              [#if ipHandler.handler != PreviousIpHandler]
                [#if ((ipHandler.handler != "hadc4") && (ipHandler.handler != "hcrc") && (ipHandler.handler != "hrng"))]
  ${""?right_pad(2)}memset(&${ipHandler.handler}, 0, sizeof(${ipHandler.handler}));
                [/#if]
                [#assign PreviousIpHandler = ipHandler.handler]
              [/#if]
            [/#if]
          [/#list]
        [/#if]
      [/#list]
    [/#list]
  [/#list]
[/#if]

[#if voidsList??]
  [#list voidsList as void]
  [#if void.functionName?? && void.genCode && !void.isStatic]
    [#if (void.functionName != "SystemClock_Config")
      && (void.functionName != "SystemPower_Config")
      && (void.functionName != "MX_RTC_Init")
      && (void.functionName != "APPE_Init")
      && (void.functionName != "MX_RF_Init")
      && (void.functionName != "MX_CORTEX_M33_Init")
      && (void.functionName != "MX_CORTEX_M33_NS_Init")
      && (void.functionName != "MX_GPDMA1_Init")
      && (void.functionName != "MX_USART1_UART_Init")
      && (void.functionName != "MX_USART2_UART_Init")
      && (void.functionName != "MX_HSEM_Init")
      && (void.functionName != "MX_ADC4_Init")
      && (void.functionName != "MX_RNG_Init")
      && (void.functionName != "MX_CRC_Init")
	  && (void.functionName != "MX_GPIO_Init")
	  && (void.functionName != "MX_RAMCFG_Init")
	  && (void.functionName != "MX_ICACHE_Init")
    ]
${""?right_pad(2)}${void.functionName}();
    [/#if]
  [/#if]
  [/#list]
[/#if]
#if (USE_TEMPERATURE_BASED_RADIO_CALIBRATION == 1)
  ADCCTRL_Init();
#endif /* USE_TEMPERATURE_BASED_RADIO_CALIBRATION */

  /* USER CODE BEGIN MX_STOP2_EXIT_PERIPHERAL_INIT_2 */
  /* USER CODE END MX_STOP2_EXIT_PERIPHERAL_INIT_2 */
}
#endif /* (CFG_LPM_STOP2_SUPPORTED == 1) */
[/#if]