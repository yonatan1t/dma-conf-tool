[#ftl]
[#assign SauInitAllRegion = {}][#-- Hash to register all SAU regions --]
[#--
    "0": {  "REGION" : "value",
            "START" : "value",
            "END" : "value",
            "NSC" : "value"},
    "1": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "2": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "3": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "4": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "5": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "6": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""},
    "7": {  "REGION" : "",
            "START" : "",
            "END" : "",
            "NSC" : ""}
}--] 
[#-- 

--]
[#list IPdatas as ipvar]
   [#list ipvar.configModelList as configModel]
       [#list configModel.refConfigFiles as refconfig]
            [#list refconfig.arguments as argument]
                [#if argument.value??]
                    [#assign index=argument.name[3]]
                    [#assign key=argument.name?replace("INIT_START_DYNAMIC", "INIT_START")?replace("End_Address", "INIT_END")[10..]]
                    [#assign val=argument.value]
                    [#assign element = {key:val}]
                    [#if SauInitAllRegion[index?string]??][#assign hashRegion=SauInitAllRegion[index?string]][#else][#assign hashRegion={}][/#if]
                    [#assign hashRegion = hashRegion + element]
                    [#assign SauInitAllRegion = SauInitAllRegion + {index:hashRegion}]
                [/#if]
            [/#list]
        [/#list]
    [/#list]
[/#list]
[#-- uncomment to display the table value --]
[#--list SauInitAllRegion?keys as regionNb]
    [#list SauInitAllRegion[regionNb]?keys as param]
        ${regionNb} ${param} :${SauInitAllRegion[regionNb][param]}
    [/#list]
[/#list--]

/*
//-------- <<< Use Configuration Wizard in Context Menu >>> -----------------
*/
/* USER CODE BEGIN 0 */
[#if FamilyName=="STM32N6"]
#if defined(__ICCARM__)
#pragma section="Veneer$$CMSE"
#elif defined(__CC_ARM)
extern uint32_t _sNSCVeneer;
extern uint32_t _eNSCVeneer;
#elif defined(__ARMCC_VERSION)
extern uint32_t Veneer$$CMSE$$Base;
extern uint32_t Veneer$$CMSE$$Limit;
#elif defined(__GNUC__)
extern uint32_t _sNSCVeneer;
extern uint32_t _eNSCVeneer;
#endif
[/#if]
/*
// <e>Initialize Security Attribution Unit (SAU) CTRL register
*/
#define SAU_INIT_CTRL          1

/*
//   <q> Enable SAU
//   <i> Value for SAU->CTRL register bit ENABLE
*/
#define SAU_INIT_CTRL_ENABLE   1

/*
//   <o> When SAU is disabled
//     <0=> All Memory is Secure
//     <1=> All Memory is Non-Secure
//   <i> Value for SAU->CTRL register bit ALLNS
//   <i> When all Memory is Non-Secure (ALLNS is 1), IDAU can override memory map configuration.
*/
#define SAU_INIT_CTRL_ALLNS    0

/*
// </e>
*/

/*
// <h>Initialize Security Attribution Unit (SAU) Address Regions
// <i>SAU configuration specifies regions to be one of:
// <i> - Secure and Non-Secure Callable
// <i> - Non-Secure
// <i>Note: All memory regions not configured by SAU are Secure
*/
#define SAU_REGIONS_MAX   8                 /* Max. number of SAU regions */

/*
//   <e>Initialize SAU Region 0
//   <i> Setup SAU Region 0 memory attributes
*/
#define SAU_INIT_REGION0    ${SauInitAllRegion["0"]["REGION"]}
[#if SauInitAllRegion["0"]["Mode"]?? && SauInitAllRegion["0"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 0 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 0 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 0 */

#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START0     ${SauInitAllRegion["0"]["START"]}      /* start address of SAU region 0 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END0       [#if SauInitAllRegion["0"]["END"]?starts_with("0x")]0x${SauInitAllRegion["0"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["0"]["END"]}[/#if]      /* end address of SAU region 0 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC0       ${SauInitAllRegion["0"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 1
//   <i> Setup SAU Region 1 memory attributes
*/
#define SAU_INIT_REGION1    ${SauInitAllRegion["1"]["REGION"]}

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
[#if SauInitAllRegion["1"]["Mode"]?? && SauInitAllRegion["1"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 1 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 1 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 1 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START1     ${SauInitAllRegion["1"]["START"]}      /* start address of SAU region 1 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END1       [#if SauInitAllRegion["1"]["END"]?starts_with("0x")]0x${SauInitAllRegion["1"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["1"]["END"]}[/#if]      /* end address of SAU region 1 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC1       ${SauInitAllRegion["1"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 2
//   <i> Setup SAU Region 2 memory attributes
*/
#define SAU_INIT_REGION2    ${SauInitAllRegion["2"]["REGION"]}
[#if SauInitAllRegion["2"]["Mode"]?? && SauInitAllRegion["2"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 2 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 2 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 2 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START2     ${SauInitAllRegion["2"]["START"]}      /* start address of SAU region 2 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END2       [#if SauInitAllRegion["2"]["END"]?starts_with("0x")]0x${SauInitAllRegion["2"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["2"]["END"]}[/#if]      /* end address of SAU region 2 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC2       ${SauInitAllRegion["2"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 3
//   <i> Setup SAU Region 3 memory attributes
*/
#define SAU_INIT_REGION3    ${SauInitAllRegion["3"]["REGION"]}
[#if SauInitAllRegion["3"]["Mode"]?? && SauInitAllRegion["3"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 3 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 3 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 3 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START3     ${SauInitAllRegion["3"]["START"]}      /* start address of SAU region 3 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END3       [#if SauInitAllRegion["3"]["END"]?starts_with("0x")]0x${SauInitAllRegion["3"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["3"]["END"]}[/#if]      /* end address of SAU region 3 */
[/#if]

/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC3       ${SauInitAllRegion["3"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 4
//   <i> Setup SAU Region 4 memory attributes
*/
#define SAU_INIT_REGION4    ${SauInitAllRegion["4"]["REGION"]}
[#if SauInitAllRegion["4"]["Mode"]?? && SauInitAllRegion["4"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 4 */
#elif defined(__ARMCC_VERSION)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 4 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 4 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START4     ${SauInitAllRegion["4"]["START"]}      /* start address of SAU region 4 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END4       [#if SauInitAllRegion["4"]["END"]?starts_with("0x")]0x${SauInitAllRegion["4"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["4"]["END"]}[/#if]      /* end address of SAU region 4 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC4       ${SauInitAllRegion["4"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 5
//   <i> Setup SAU Region 5 memory attributes
*/
#define SAU_INIT_REGION5    ${SauInitAllRegion["5"]["REGION"]}
[#if SauInitAllRegion["5"]["Mode"]?? && SauInitAllRegion["5"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 5 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 5 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 5 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START5     ${SauInitAllRegion["5"]["START"]}      /* start address of SAU region 5 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END5       [#if SauInitAllRegion["5"]["END"]?starts_with("0x")]0x${SauInitAllRegion["5"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["5"]["END"]}[/#if]      /* end address of SAU region 5 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC5       ${SauInitAllRegion["5"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 6
//   <i> Setup SAU Region 6 memory attributes
*/
#define SAU_INIT_REGION6    ${SauInitAllRegion["6"]["REGION"]}
[#if SauInitAllRegion["6"]["Mode"]?? && SauInitAllRegion["6"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 6 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 6 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 6 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START6     ${SauInitAllRegion["6"]["START"]}      /* start address of SAU region 6 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END6       [#if SauInitAllRegion["6"]["END"]?starts_with("0x")]0x${SauInitAllRegion["6"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["6"]["END"]}[/#if]      /* end address of SAU region 6 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC6       ${SauInitAllRegion["6"]["NSC"]}
/*
//   </e>
*/

/*
//   <e>Initialize SAU Region 7
//   <i> Setup SAU Region 7 memory attributes
*/
#define SAU_INIT_REGION7    ${SauInitAllRegion["7"]["REGION"]}
[#if SauInitAllRegion["7"]["Mode"]?? && SauInitAllRegion["7"]["Mode"]="1"]
#if defined(__ICCARM__)
/* if EWARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     ((uint32_t) __sfb("Veneer$$CMSE"))     /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7      ((uint32_t) __sfe("Veneer$$CMSE"))      /* end address of SAU region 7 */
#elif defined(__ARMCC_VERSION)
/* if MDK-ARM is used, get the veneer address from the section symbol */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     ((uint32_t) &Veneer$$CMSE$$Base)      /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7       ((uint32_t) &Veneer$$CMSE$$Limit)      /* end address of SAU region 7 */
#elif defined(__GNUC__)
/* if GCC is used, get the veneer start and end symbols from the linker script */
/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     ((uint32_t) &_sNSCVeneer)     /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7       ((uint32_t) &_eNSCVeneer)      /* end address of SAU region 7 */
#endif
[#else]

/*
//     <o>Start Address <0-0xFFFFFFE0>
*/
#define SAU_INIT_START7     ${SauInitAllRegion["7"]["START"]}      /* start address of SAU region 7 */

/*
//     <o>End Address <0x1F-0xFFFFFFFF>
*/
#define SAU_INIT_END7       [#if SauInitAllRegion["7"]["END"]?starts_with("0x")]0x${SauInitAllRegion["7"]["END"]?replace("0x", "")?left_pad(8, "0")?upper_case}[#else]${SauInitAllRegion["7"]["END"]}[/#if]      /* end address of SAU region 7 */
[/#if]
/*
//     <o>Region is
//         <0=>Non-Secure
//         <1=>Secure, Non-Secure Callable
*/
#define SAU_INIT_NSC7       ${SauInitAllRegion["7"]["NSC"]}
/*
//   </e>
*/

/*
// </h>
*/
