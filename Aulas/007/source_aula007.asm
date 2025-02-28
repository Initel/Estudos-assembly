;
; Aciona um LED ligado em RB1, a partir de um botão ligado em RB0
;
; OBS:
;
; LED ligado no modo current sourcing:
;
; '0' - apaga
; '1' - acende
;
; Botão ligado com resistor de pull-up:
;
; '0' - botão acionado
; '1' - botão liberado
;
; Curso de Assembly para PIC Aula 007
;
; MCU: PIC16F84A	Clock:4MHz
;
; Autor: Cientista Diego Eduardo S. Santos	Data: 23/02/2025
;

  list		p=16f84a					;microcontrolador utilizado PIC16F84A
	
	
; --- Arquivos incluídos no projeto ---
  #include <p16f84a.inc>				;inclui o arquivo do PIC16F84A (pode usar aspas ou maior menor)
  
  
; --- FUSE Bits ---
; Cristal oscilador externo 4MHz, sem watchdog time, com power up time, sem proteção do código
  	__config _XT_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF ;Definido as configurações de inicialização 
  	
  	
; --- Paginação de memoria ---
;					bite clear/set file    qual registrador    qual bite
  #define		bank0		bcf STATUS, RP0 ;Cria um mnemônico para o banco 0 de memória
  #define		bank1		bsf STATUS, RP0 ;Cria um mnemônico para o banco 1 de memória


; --- Entradas ---
  #define		botao1		PORTB,RB0		;botão 1 ligado em RB0


; --- Saidas ---
  #define		led1		PORTB,RB1

  
; --- Vetor de RESET ---
				org			H'0000'			;Origem no endereço 0000h de memória
				goto		inicio			;Desvia do vetor de interrupção	
				
; -- Vetor de Interrrupção ---
				org			H'0004'			;Todas as interrupções apontam para este endereço
				retfie						;Retorna de interrupção


; --- Programa Principal ---				
inicio:
				bank1						;Seleciona o banco 1 de memória
				movlw		H'FF'			;W = B'11111111'
				movwf		TRISA			;TRISA = H'FF' (todos os bits são entrada)
				movlw		H'FD'			;W = B'11111101'
				movwf		TRISB			;TRISB = H'7F' (apenas o RB1 como saida)
				bank0						;seleciona o banco 0 de memória (padrão do RESET)
				movlw		H'FF'			; W = B'11111111'
				movwf		PORTB			;rB7 (configurado como saida) inicia em HIGH
				
loop:
				btfsc		botao1			;verifica se o botao foi pressionado
				goto 		apaga_led1		;Não, desvia para label apaga
				bsf			led1			;Sim, liga led1
				goto		loop			;Vilta para label loop
				
				
apaga_led1:
				bcf			led1			;apaga led1
				goto		loop			;volta para a label loop
				
				
				end							;Final do programa