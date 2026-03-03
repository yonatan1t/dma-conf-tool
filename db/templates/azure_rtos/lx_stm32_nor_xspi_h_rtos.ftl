[#ftl]
[#compress]

[#assign xspi_init_driver = "1"]
[#assign xspi_erase_flash = "0"]
[#assign glue_api = "DMA_API"]
[#assign TRANSFER_NOTIFICATION_value = ""]
[#assign xspi_instance = 0]
[#assign xspi_comp = "custom_xspi"]
[#assign use_dma = 0]

[#if BspComponentDatas??]
[#list BspComponentDatas as SWIP]
[#if SWIP.ipName?contains("MX25LM51245G")]
	[#assign xspi_comp = "MX25LM51245G"]
[/#if]
[#if SWIP.ipName?contains("MX66UW1G45G")]
	[#assign xspi_comp = "MX66UW1G45G"]
[/#if]
[/#list]
[/#if]

[#list SWIPdatas as SWIP]
[#if SWIP.defines??]
  [#list SWIP.defines as definition]
    [#assign value = definition.value]
    [#assign name = definition.name]

    [#if name == "LX_DRIVER_CALLS_XSPI_INIT"]
      [#assign xspi_init_driver = value]
    [/#if]

    [#if name == "LX_DRIVER_ERASES_XSPI_AFTER_INIT"]
      [#assign xspi_erase_flash = value]
    [/#if]

    [#if name == "TRANSFER_NOTIFICATION_XSPI"]
      [#assign TRANSFER_NOTIFICATION_value = value]
    [/#if]

    [#if name == "LX_XSPI_INSTANCE"]
      [#assign xspi_instance = value]
    [/#if]    
    
    [#if name == "LX_STM32_XSPI_BASE_ADDRESS"]
      [#assign LX_STM32_XSPI_BASE_ADDRESS_value = value]
    [/#if]

    [#if name == "GLUE_FUNCTIONS_XSPI"]
      [#assign glue_api = value]
    [/#if]

    [#assign used_api = "XSPI"]

  [/#list]
[/#if]
[/#list]

[#if glue_api == "DMA_API"]
  [#assign use_dma = 1]
[/#if]
[/#compress]
/**************************************************************************/
/*                                                                        */
/*       Copyright (c) Microsoft Corporation. All rights reserved.        */
/*                                                                        */
/*       This software is licensed under the Microsoft Software License   */
/*       Terms for Microsoft Azure RTOS. Full text of the license can be  */
/*       found in the LICENSE file at https://aka.ms/AzureRTOS_EULA       */
/*       and in the root directory of this software.                      */
/*                                                                        */
/**************************************************************************/

#ifndef LX_STM32_XSPI_DRIVER_H
#define LX_STM32_XSPI_DRIVER_H

#ifdef __cplusplus
extern "C" {
#endif



/* Includes ------------------------------------------------------------------*/
#include "lx_api.h"
#include "${FamilyName?lower_case}xx_hal.h"
[#if xspi_comp != "custom_xspi"]
#include "${xspi_comp?lower_case}.h"
[/#if]

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

[#if glue_api == "DMA_API"]
  [#if TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore"]
/* The following semaphore is being to notify about RX/TX completion. It needs to be released in the transfer callbacks */
extern TX_SEMAPHORE ${used_api ?lower_case}_rx_semaphore;
extern TX_SEMAPHORE ${used_api ?lower_case}_tx_semaphore;
  [/#if]
[/#if]

/* Exported constants --------------------------------------------------------*/

/* the XSPI instance, default value set to 0 */
#define LX_STM32_XSPI_INSTANCE                           ${xspi_instance}
#define LX_STM32_XSPI_BASE_ADDRESS                       ${LX_STM32_XSPI_BASE_ADDRESS_value}

#define LX_STM32_XSPI_DEFAULT_TIMEOUT                    10 * TX_TIMER_TICKS_PER_SECOND

#define LX_STM32_DEFAULT_SECTOR_SIZE                     LX_STM32_XSPI_SECTOR_SIZE
[#if glue_api == "DMA_API"]
#define LX_STM32_XSPI_DMA_API                            ${use_dma}
[/#if]

/* when set to 1 LevelX is initializing the XSPI memory,
 * otherwise it is the up to the application to perform it.
 */
#define LX_STM32_XSPI_INIT                               ${xspi_init_driver}

/* allow the driver to fully erase the XSPI chip. This should be used carefully.
 * the call is blocking and takes a while. by default it is set to 0.
 */
#define LX_STM32_XSPI_ERASE                              ${xspi_erase_flash}

/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

#define LX_STM32_XSPI_CURRENT_TIME                              tx_time_get

/* Macro called after initializing the XSPI driver
 * e.g. create a semaphore used for transfer notification */
[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore" ]
 /* USER CODE BEGIN LX_STM32_XSPI_POST_INIT */

#define LX_STM32_XSPI_POST_INIT()

/* USER CODE END LX_STM32_XSPI_POST_INIT */
[#else]
/* USER CODE BEGIN LX_STM32_XSPI_POST_INIT */

#define  LX_STM32_XSPI_POST_INIT()

/* USER CODE END LX_STM32_XSPI_POST_INIT */
[/#if]

/* Macro called before performing read operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_XSPI_PRE_READ_TRANSFER */

#define LX_STM32_XSPI_PRE_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_XSPI_PRE_READ_TRANSFER */
[#else]
/* USER CODE BEGIN LX_STM32_XSPI_PRE_READ_TRANSFER */

#define LX_STM32_XSPI_PRE_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_XSPI_PRE_READ_TRANSFER */
[/#if]

/* Define how to notify about Read completion operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_XSPI_READ_CPLT_NOTIFY */

#define LX_STM32_XSPI_READ_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_XSPI_READ_CPLT_NOTIFY */
[#else]
/* USER CODE BEGIN LX_STM32_XSPI_READ_CPLT_NOTIFY */

#define LX_STM32_XSPI_READ_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_XSPI_READ_CPLT_NOTIFY */
[/#if]

/* Macro called after performing read operation */

/* USER CODE BEGIN LX_STM32_XSPI_POST_READ_TRANSFER */

#define LX_STM32_XSPI_POST_READ_TRANSFER(__status__)

/* USER CODE END LX_STM32_XSPI_POST_READ_TRANSFER */

/* Macro for read error handling */
/* USER CODE BEGIN LX_STM32_XSPI_READ_TRANSFER_ERROR */

#define LX_STM32_XSPI_READ_TRANSFER_ERROR(__status__)

/* USER CODE END LX_STM32_XSPI_READ_TRANSFER_ERROR */


/* Macro called before performing write operation */

/* USER CODE BEGIN LX_STM32_XSPI_PRE_WRITE_TRANSFER */

#define LX_STM32_XSPI_PRE_WRITE_TRANSFER(__status__)

/* USER CODE END LX_STM32_XSPI_PRE_WRITE_TRANSFER */

/* Define how to notify about write completion operation */

[#if glue_api == "DMA_API" && TRANSFER_NOTIFICATION_value == "ThreadX_Semaphore" ]
/* USER CODE BEGIN LX_STM32_XSPI_WRITE_CPLT_NOTIFY */

#define LX_STM32_XSPI_WRITE_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_XSPI_WRITE_CPLT_NOTIFY */
[#else]
/* USER CODE BEGIN LX_STM32_XSPI_WRITE_CPLT_NOTIFY */

#define LX_STM32_XSPI_WRITE_CPLT_NOTIFY(__status__)

/* USER CODE END LX_STM32_XSPI_WRITE_CPLT_NOTIFY */
[/#if]

/* Macro called after performing write operation */

/* USER CODE BEGIN LX_STM32_XSPI_POST_WRITE_TRANSFER */

#define LX_STM32_XSPI_POST_WRITE_TRANSFER(__status__)

/* USER CODE END LX_STM32_XSPI_POST_WRITE_TRANSFER */

/* Macro for write error handling */

/* USER CODE BEGIN LX_STM32_XSPI_WRITE_TRANSFER_ERROR */

#define LX_STM32_XSPI_WRITE_TRANSFER_ERROR(__status__)

/* USER CODE END LX_STM32_XSPI_WRITE_TRANSFER_ERROR */

/* Exported functions prototypes ---------------------------------------------*/
INT lx_stm32_xspi_lowlevel_init(UINT instance);
INT lx_stm32_xspi_lowlevel_deinit(UINT instance);

INT lx_stm32_xspi_get_status(UINT instance);
INT lx_stm32_xspi_get_info(UINT instance, ULONG *block_size, ULONG *total_blocks);

INT lx_stm32_xspi_read(UINT instance, ULONG *address, ULONG *buffer, ULONG words);
INT lx_stm32_xspi_write(UINT instance, ULONG *address, ULONG *buffer, ULONG words);

INT lx_stm32_xspi_erase(UINT instance, ULONG block, ULONG erase_count, UINT full_chip_erase);
INT lx_stm32_xspi_is_block_erased(UINT instance, ULONG block);

UINT lx_xspi_driver_system_error(UINT error_code);

UINT lx_stm32_xspi_initialize(LX_NOR_FLASH *nor_flash);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
/* USER CODE BEGIN PD */

/* USER CODE END PD */

[#if glue_api == "DMA_API"]
[#if xspi_comp == "MX25LM51245G" || xspi_comp == "MX66UW1G45G"]
#define LX_STM32_XSPI_DUMMY_CYCLES_READ_OCTAL     20
#define LX_STM32_XSPI_DUMMY_CYCLES_CR_CFG         ${xspi_comp}_CR2_DC_6_CYCLES

[#if xspi_comp == "MX25LM51245G"]
#define LX_STM32_XSPI_SECTOR_SIZE                 ${xspi_comp}_SECTOR_64K
[/#if]
[#if xspi_comp == "MX66UW1G45G"]
#define LX_STM32_XSPI_SECTOR_SIZE                 ${xspi_comp}_BLOCK_64K
[/#if]
#define LX_STM32_XSPI_FLASH_SIZE                  ${xspi_comp}_FLASH_SIZE
#define LX_STM32_XSPI_PAGE_SIZE                   ${xspi_comp}_PAGE_SIZE

#define LX_STM32_XSPI_BULK_ERASE_MAX_TIME         ${xspi_comp}_BULK_ERASE_MAX_TIME
#define LX_STM32_XSPI_SECTOR_ERASE_MAX_TIME       ${xspi_comp}_SECTOR_ERASE_MAX_TIME
#define LX_STM32_XSPI_WRITE_REG_MAX_TIME          ${xspi_comp}_WRITE_REG_MAX_TIME

#define LX_STM32_XSPI_OCTAL_BULK_ERASE_CMD        ${xspi_comp}_OCTA_BULK_ERASE_CMD
[#if xspi_comp == "MX25LM51245G"]
#define LX_STM32_XSPI_OCTAL_SECTOR_ERASE_CMD      ${xspi_comp}_OCTA_SECTOR_ERASE_64K_CMD
[/#if]
[#if xspi_comp == "MX66UW1G45G"]
#define LX_STM32_XSPI_OCTAL_SECTOR_ERASE_CMD      ${xspi_comp}_OCTA_BLOCK_ERASE_64K_CMD
[/#if]

#define LX_STM32_XSPI_WRITE_ENABLE_CMD            ${xspi_comp}_WRITE_ENABLE_CMD
#define LX_STM32_XSPI_WRITE_CFG_REG2_CMD          ${xspi_comp}_WRITE_CFG_REG2_CMD
#define LX_STM32_XSPI_OCTAL_WRITE_ENABLE_CMD      ${xspi_comp}_OCTA_WRITE_ENABLE_CMD
#define LX_STM32_XSPI_OCTAL_WRITE_CFG_REG2_CMD    ${xspi_comp}_OCTA_WRITE_CFG_REG2_CMD

#define LX_STM32_XSPI_READ_STATUS_REG_CMD         ${xspi_comp}_READ_STATUS_REG_CMD
#define LX_STM32_XSPI_READ_CFG_REG2_CMD           ${xspi_comp}_WRITE_CFG_REG2_CMD

#define LX_STM32_XSPI_OCTAL_READ_DTR_CMD          ${xspi_comp}_OCTA_READ_DTR_CMD
#define LX_STM32_XSPI_OCTAL_READ_CFG_REG2_CMD     ${xspi_comp}_OCTA_READ_CFG_REG2_CMD
#define LX_STM32_XSPI_OCTAL_READ_STATUS_REG_CMD   ${xspi_comp}_OCTA_READ_STATUS_REG_CMD


#define LX_STM32_XSPI_RESET_ENABLE_CMD            ${xspi_comp}_RESET_ENABLE_CMD
#define LX_STM32_XSPI_RESET_MEMORY_CMD            ${xspi_comp}_RESET_MEMORY_CMD

#define LX_STM32_XSPI_OCTAL_PAGE_PROG_CMD         ${xspi_comp}_OCTA_PAGE_PROG_CMD

#define LX_STM32_XSPI_CR2_REG3_ADDR               ${xspi_comp}_CR2_REG3_ADDR
#define LX_STM32_XSPI_CR2_REG1_ADDR               ${xspi_comp}_CR2_REG1_ADDR
#define LX_STM32_XSPI_SR_WEL                      ${xspi_comp}_SR_WEL
#define LX_STM32_XSPI_SR_WIP                      ${xspi_comp}_SR_WIP
#define LX_STM32_XSPI_CR2_SOPI                    ${xspi_comp}_CR2_SOPI
#define LX_STM32_XSPI_CR2_DOPI                    ${xspi_comp}_CR2_DOPI
[/#if]
[#if xspi_comp == "custom_xspi"]
/* USER CODE BEGIN CUSTOM_XSPI */
/* Define the command codes and flags below related to the NOR Flash memory used */
#error "[This error is thrown on purpose] : define the command codes and flags below related to the NOR Flash memory used"

#define LX_STM32_XSPI_DUMMY_CYCLES_READ_OCTAL     0xFF
#define LX_STM32_XSPI_DUMMY_CYCLES_CR_CFG         0xFF

#define LX_STM32_XSPI_SECTOR_SIZE                 0xFF
#define LX_STM32_XSPI_FLASH_SIZE                  0xFF
#define LX_STM32_XSPI_PAGE_SIZE                   0xFF

#define LX_STM32_XSPI_BULK_ERASE_MAX_TIME         0xFF
#define LX_STM32_XSPI_SECTOR_ERASE_MAX_TIME       0xFF
#define LX_STM32_XSPI_WRITE_REG_MAX_TIME          0xFF

#define LX_STM32_XSPI_OCTAL_BULK_ERASE_CMD        0xFF
#define LX_STM32_XSPI_OCTAL_SECTOR_ERASE_CMD      0xFF

#define LX_STM32_XSPI_WRITE_ENABLE_CMD            0xFF
#define LX_STM32_XSPI_WRITE_CFG_REG2_CMD          0xFF
#define LX_STM32_XSPI_OCTAL_WRITE_ENABLE_CMD      0xFF
#define LX_STM32_XSPI_OCTAL_WRITE_CFG_REG2_CMD    0xFF

#define LX_STM32_XSPI_READ_STATUS_REG_CMD         0xFF
#define LX_STM32_XSPI_READ_CFG_REG2_CMD           0xFF

#define LX_STM32_XSPI_OCTAL_READ_DTR_CMD          0xFF
#define LX_STM32_XSPI_OCTAL_READ_CFG_REG2_CMD     0xFF
#define LX_STM32_XSPI_OCTAL_READ_STATUS_REG_CMD   0xFF


#define LX_STM32_XSPI_RESET_ENABLE_CMD            0xFF
#define LX_STM32_XSPI_RESET_MEMORY_CMD            0xFF

#define LX_STM32_XSPI_OCTAL_PAGE_PROG_CMD         0xFF

#define LX_STM32_XSPI_CR2_REG3_ADDR               0xFF
#define LX_STM32_XSPI_CR2_REG1_ADDR               0xFF
#define LX_STM32_XSPI_SR_WEL                      0xFF
#define LX_STM32_XSPI_SR_WIP                      0xFF
#define LX_STM32_XSPI_CR2_SOPI                    0xFF
#define LX_STM32_XSPI_CR2_DOPI                    0xFF

/* USER CODE END CUSTOM_XSPI */
[/#if]
[/#if]

[#if glue_api != "DMA_API"]
[#if xspi_comp == "MX25LM51245G"]
#define LX_STM32_XSPI_SECTOR_SIZE                 ${xspi_comp}_SECTOR_64K
[#elseif xspi_comp == "MX66UW1G45G"]
#define LX_STM32_XSPI_SECTOR_SIZE                 ${xspi_comp}_BLOCK_64K
[#else]
#error "[This error is thrown on purpose] : define the correct XSPI Sector Size"
#define LX_STM32_XSPI_SECTOR_SIZE                 0xFFFF
[/#if]
[/#if]

/* USER CODE BEGIN 1 */

/* USER CODE END 1 */

#ifdef __cplusplus
}
#endif
#endif /* LX_STM32_XSPI_DRIVER_H */
