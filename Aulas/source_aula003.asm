;
; Curso de Assembly para PIC Aula 003
;
; MCU: PIC16F84A	Clock:4MHz
;
; Autor: Cientista Diego Eduardo S. Santos	Data: 22/02/2025
;

  list		p=16f84a					;microcontrolador utilizado PIC16F84A
	
	
; --- Arquivos inclu�dos no projeto ---
  #include <p16f84a.inc>				;inclui o arquivo do PIC16F84A (pode usar aspas ou maior menor)
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog time, com power up time, sem prote��o do c�digo
  	__config _XT_OSC & _WDT_OFF & _PWRPE_ON & _CP_OFF ;Definido as configura��es de inicializa��o 
  	
  	
; --- Pagina��o de memoria ---
;					bite clear/set file    qual registrador    qual bite
  #define		bank0		bcf STATUS, RP0 ;Cria um mnem�nico para o banco 0 de mem�ria
  #define		bank1		bsf STATUS, RP0 ;Cria um mnem�nico para o banco 1 de mem�ria