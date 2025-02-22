;
; Curso de Assembly para PIC Aula 003
;
; MCU: PIC16F84A	Clock:4MHz
;
; Autor: Cientista Diego Eduardo S. Santos	Data: 22/02/2025
;

  list		p=16f84a					;microcontrolador utilizado PIC16F84A
	
	
; --- Arquivos incluídos no projeto ---
  #include <p16f84a.inc>				;inclui o arquivo do PIC16F84A (pode usar aspas ou maior menor)
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog time, com power up time, sem proteção do código
  	__config _XT_OSC & _WDT_OFF & _PWRPE_ON & _CP_OFF ;Definido as configurações de inicialização 
  	
  	
; --- Paginação de memoria ---
;					bite clear/set file    qual registrador    qual bite
  #define		bank0		bcf STATUS, RP0 ;Cria um mnemônico para o banco 0 de memória
  #define		bank1		bsf STATUS, RP0 ;Cria um mnemônico para o banco 1 de memória