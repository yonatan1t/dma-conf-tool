[#ftl]
[#assign TABres = dts_get_tabs(pDtLevel)]
[#assign TABnode = TABres.TABN]
[#assign TABres = dts_get_tabs(pDtLevel+1)]
[#assign TABsubnode = TABres.TABN]
[#assign TABsubprop = TABres.TABP]
#n
${TABnode}&hpdma1 {
	status = "okay";
#n
	/* USER CODE BEGIN hpdma1 */
	/* USER CODE END hpdma1 */
};
#n
&hpdma2 {
	status = "okay";
#n
	/* USER CODE BEGIN hpdma2 */
    /* USER CODE END hpdma2 */
};
#n
&hpdma3 {
	status = "okay";
#n
    /* USER CODE BEGIN hpdma3 */
    /* USER CODE END hpdma3 */
};
#n