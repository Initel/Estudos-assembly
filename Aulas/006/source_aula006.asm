;
; Botao com Leb
;
; OBS:
;
; LED ligado no modo current sourcing:
;
; '0' - apaga
; '1' - acende
;
; Bot�o ligado com resistor de pull-up:
;
; '0' - bot�o acionado
; '1' - bot�o liberado
;
; Curso de Assembly para PIC Aula 006
;
; MCU: PIC16F84A	Clock:4MHz
;
; Autor: Cientista Diego Eduardo S. Santos	Data: 23/02/2025
;

  list		p=16f84a					;microcontrolador utilizado PIC16F84A
	
	
; --- Arquivos inclu�dos no projeto ---
  #include <p16f84a.inc>				;inclui o arquivo do PIC16F84A (pode usar aspas ou maior menor)
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog time, com power up time, sem prote��o do c�digo
  	__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF ;Definido as configura��es de inicializa��o 
  	
  	
; --- Pagina��o de memoria ---
;					bite clear/set file    qual registrador    qual bite
  #define		bank0		bcf STATUS, RP0 ;Cria um mnem�nico para o banco 0 de mem�ria
  #define		bank1		bsf STATUS, RP0 ;Cria um mnem�nico para o banco 1 de mem�ria


; --- Entradas ---
  #define		botao1		PORTB,RB0		;bot�o 1 ligado em RB0


; --- Saidas ---
  #define		led1		PORTB,RB7

  
; --- Vetor de RESET ---
				org			H'0000'			;Origem no endere�o 0000h de mem�ria
				goto		inicio			;Desvia do vetor de interrup��o	
				
; -- Vetor de Interrrup��o ---
				org			H'0004'			;Todas as interrup��es apontam para este endere�o
				retfie						;Retorna de interrup��o


; --- Programa Principal ---				
inicio:
				bank1						;Seleciona o banco 1 de mem�ria
				movlw		H'FF'			;W = B'11111111'
				movwf		TRISA			;TRISA = H'FF' (todos os bits s�o entrada)
				movlw		H'7F'			;W = B'01111111'
				movwf		TRISB			;TRISB = H'7F' (apenas o RRB7 como saida)
				bank0						;seleciona o banco 0 de mem�ria (padr�o do RESET)
				movlw		H'FF'			; W = B'11111111'
				movwf		PORTB			;rB7 (configurado como saida) inicia em HIGH
				
loop:
				btfsc		botao1			;verifica se o botao foi pressionado
				goto 		apaga_led1		;N�o, desvia para label apaga
				bsf			led1			;Sim, liga led1
				goto		loop			;Vilta para label loop
				
				
apaga_led1:
				bcf			led1			;apaga led1
				goto		loop			;volta para a label loop
				
				
				end							;Final do programa