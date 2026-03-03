[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    bleplat.c
  * @author  MCD Application Team
  * @brief   This file implements the platform functions for BLE stack library.
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

#include "app_common.h"
#include "bleplat.h"
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
[#if (myHash["BLE_MODE_SKELETON"] != "Enabled")]
#include "app_ble.h"
[/#if]
#include "baes.h"
#include "bpka.h"
[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
#include "ble_timer.h"
[/#if]
#include "blestack.h"
#include "host_stack_if.h"
[#else]
#include "stm32wbaxx_ll_rng.h"
#include "stm32wbaxx_ll_bus.h"
[/#if]

#include "ble_wrap.c"

/*****************************************************************************/

void BLEPLAT_Init( void )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_Reset( );
  BPKA_Reset( );
[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
  BLE_TIMER_Init();
[/#if]
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_NvmStore( const uint64_t* ptr,
                              uint16_t size )
{
  UNUSED(ptr);
  UNUSED(size);

[#if myHash["BLE_MODE_TRANSPARENT_UART"] != "Enabled"]
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
[#if (myHash["USE_SNVMA_NVM"]?number != 0)]
  APP_BLE_HostNvmStore();
[/#if]
[/#if]
[/#if]
  return;
}

/*****************************************************************************/

void BLEPLAT_RngGet( uint8_t n,
                     uint32_t* val )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  /* Read 32-bit random values from HW driver */
  HW_RNG_Get( n, val );
[#else]
  LL_AHB2_GRP1_EnableClock( LL_AHB2_GRP1_PERIPH_RNG );
  LL_RNG_Enable( RNG );
  while ( n-- )
  {
    *val++=LL_RNG_ReadRandData32( RNG );
  }
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesEcbEncrypt( const uint8_t* key,
                            const uint8_t* input,
                            uint8_t* output )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_EcbCrypt( key, input, output, 1 );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesCmacSetKey( const uint8_t* key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_CmacSetKey( key );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_AesCmacCompute( const uint8_t* input,
                             uint32_t input_length,
                             uint8_t* output_tag )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BAES_CmacCompute( input, input_length, output_tag );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_AesCcmCrypt( uint8_t mode,
                         const uint8_t* key,
                         uint8_t iv_length,
                         const uint8_t* iv,
                         uint16_t add_length,
                         const uint8_t* add,
                         uint32_t input_length,
                         const uint8_t* input,
                         uint8_t tag_length,
                         uint8_t* tag,
                         uint8_t* output )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BAES_CcmCrypt( mode, key, iv_length, iv, add_length, add,
                        input_length, input, tag_length, tag, output );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaStartP256Key( const uint32_t* local_private_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_StartP256Key( local_private_key );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_PkaReadP256Key( uint32_t* local_public_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BPKA_ReadP256Key( local_public_key );
[#else]
  return;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaStartDhKey( const uint32_t* local_private_key,
                           const uint32_t* remote_public_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_StartDhKey( local_private_key, remote_public_key );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

int BLEPLAT_PkaReadDhKey( uint32_t* dh_key )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BPKA_ReadDhKey( dh_key );
[#else]
  return 0;
[/#if]
}

[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
/*****************************************************************************/

void BPKACB_Complete( void )
{
  BLEPLATCB_PkaComplete( );

  BleStackCB_Process( );
}

[/#if]
[#if (myHash["BLE_OPTIONS_LL_ONLY"] != "BLE_OPTIONS_LL_ONLY")]
/*****************************************************************************/

uint8_t BLEPLAT_TimerStart( uint16_t id,
                            uint32_t timeout )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  return BLE_TIMER_Start( id, timeout );
[#else]
  return 0;
[/#if]
}

/*****************************************************************************/

void BLEPLAT_TimerStop( uint16_t id )
{
[#if (myHash["BLE_MODE_SIMPLEST_BLE"] != "Enabled")]
  BLE_TIMER_Stop( id );
[#else]
  return;
[/#if]
}
[/#if]
/*****************************************************************************/
