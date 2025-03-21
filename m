     1                                  ;; kernel.asm
     2                                  ;; version 0.0.1
     3                                  
     4                                  bits 32		;nasm directive
     5                                  section .text
     6                                  	;multiboot spec
     7                                  	align 4
     8 00000000 02B0AD1B                	dd 0x1BADB002			;magic
     9 00000004 00000000                	dd 0x00				;flags
    10 00000008 FE4F52E4                	dd - (0x1BADB002 + 0x00)	;checksum. m+f+c should be zero
    11                                  
    12                                  global start
    13                                  extern k_main	;k_main is defined in the kernel.c file
    14                                  global load_idt
    15                                  
    16                                  load_idt:
    17 0000000C 0F0118                      lidt [eax]  ; Carga la IDT desde el puntero en EAX
    18 0000000F C3                          ret
    19                                  
    20                                  start:
    21 00000010 FA                      	cli  ; stop interrupts
    22                                  
    23 00000011 E8(00000000)            	call k_main
    24                                  
    25 00000016 F4                      	hlt ; halt the CPU
