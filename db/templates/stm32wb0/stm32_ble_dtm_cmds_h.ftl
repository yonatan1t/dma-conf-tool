[#ftl]
/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    dtm_cmds.h
  * @author  GPM WBL Application Team
  * @brief   DTM specific commands to be implemented on DTM context (not present on BLE stack)
  ******************************************************************************
[@common.optinclude name=mxTmpFolder+"/license.tmp"/][#--include License text --]
  ******************************************************************************
  */
/* USER CODE END Header */

#ifndef DTM_CMDS_H
#define DTM_CMDS_H

void DTM_CMDS_TxEnd(void);

void DTM_CMDS_TxTestStopRequest(void);

void DTM_CMDS_TxTestStop(void);


#endif /* DTM_CMDS_H */
