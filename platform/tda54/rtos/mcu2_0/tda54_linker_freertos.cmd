
/* make sure below retain is there in your linker command file, it keeps the vector table in the final binary */
--retain="*(.vectors)"
/* This is the stack that is used by code running within main()
 * In case of NORTOS,
 * - This means all the code outside of ISR uses this stack
 * In case of FreeRTOS
 * - This means all the code until vTaskStartScheduler() is called in main()
 *   uses this stack.
 * - After vTaskStartScheduler() each task created in FreeRTOS has its own stack
 */
--stack_size=16384
/* This is the heap size for malloc() API in NORTOS and FreeRTOS
 * This is also the heap used by pvPortMalloc in FreeRTOS
 */
--heap_size=32768
--entry_point=_c_int00

SECTIONS
{
    /* This has the M55 entry point and vector table, this MUST be at 0x0 */
    .vectors:{} palign(8) > DDR_MCU2_0
    .text:   {} palign(8) > DDR_MCU2_0     /* This is where code resides */

    .bss:    {} palign(8) > DDR_MCU2_0     /* This is where uninitialized globals go */
    RUN_START(__BSS_START)
    RUN_END(__BSS_END)

    .data:   {} palign(8) > DDR_MCU2_0     /* This is where initialized globals and static go */
    .rodata: {} palign(8) > DDR_MCU2_0     /* This is where const's go */
    .sysmem: {} palign(8) > DDR_MCU2_0     /* This is where the malloc heap goes */
    .stack:  {} palign(8) > DDR_MCU2_0     /* This is where the main() stack goes */

    /* Sections needed for C++ projects */
    .ARM.exidx:     {} palign(8) > DDR_MCU2_0  /* Needed for C++ exception handling */
    .init_array:    {} palign(8) > DDR_MCU2_0  /* Contains function pointers called before main */
    .fini_array:    {} palign(8) > DDR_MCU2_0  /* Contains function pointers called after main */
}

MEMORY
{
    M55_VECS : ORIGIN = 0x24000000 , LENGTH = 0x200
    M55_IRAM : ORIGIN = 0x24000000 + 0x200 , LENGTH = 0xFFFF - 0x200
    M55_DRAM : ORIGIN = 0x24010000 , LENGTH = 0xFFFF
    DDR_MCU2_0 : ORIGIN = 0x80000000 , LENGTH = 0x20000000

}
