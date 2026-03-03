uint32_t currentDTCMSize = HAL_SYSCFG_GetTCMSize(${SYSCFG_DTCM_size});
uint32_t currentITCMSize = HAL_SYSCFG_GetTCMSize(${SYSCFG_ITCM_size});

// Check if current sizes differ from expected (MX) values
if ((currentDTCMSize != SYSCFG_DTCM_64K) || (currentITCMSize != SYSCFG_ITCM_64K))
{
    /* Increase DTCM and ITCM sizes registers */
    HAL_SYSCFG_SetTCMSize(expectedDTCMSize, expectedITCMSize);

    /* Change reset type to power-on reset; otherwise, TCM changes are not applied */
    HAL_SYSCFG_EnablePowerOnReset();

    // Trigger a system reset
    NVIC_SystemReset();
