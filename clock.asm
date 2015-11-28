include 'emu8086.inc'
#make_com#
org 100h
            LEA si,msgh         ;MINUTO
            call print_string
            
            LEA DI,hora1
            mov dx,02H
            call get_string
            LEA DI,hora2
            mov dx,02H
            call get_string
            sub hora1,30h
            sub hora2,30h
            MOV Bl,hora2
            MOV BH,hora1
            MOV hora,bx
                            
            PUTC 0AH
            PUTC 0DH
            
            LEA si,msgm         ;MINUTO
            call print_string
            
            LEA DI,minuto1
            mov dx,02H
            call get_string
            LEA DI,minuto2
            mov dx,02H
            call get_string
            sub minuto1,30h
            sub minuto2,30h
                            
            PUTC 0AH
            PUTC 0DH
            
            LEA si,msgs         ;SEGUNDO
            call print_string
            
            LEA DI,segundo1
            mov dx,02H
            call get_string
            LEA DI,segundo2
            mov dx,02H
            call get_string
            sub segundo1,30h
            sub segundo2,30h
                            
            PUTC 0AH
            PUTC 0DH   
            
      start:GOTOXY 0,3            ;imprime  a hora
            MOV     BX,hora
            MOV     hora2,BL
            MOV     hora1,BH
            mov     Dl,hora1
            call    imprimir
            mov     Dl,hora2
            call    imprimir
            PUTC    3AH        
            
            mov     DX,minuto1    ;imprime o minuto
            call    imprimir
            mov     DX,minuto2
            call    imprimir      
            PUTC    3AH        
            
            mov     DX,segundo1   ;imprime o segundo
            call    imprimir
            mov     DX,segundo2
            call    imprimir
            
            
            cmp     segundo2,09H
            jz      incs
            MOV     CX, 0FH     ;delay de 1segundo
            MOV     DX, 4240H
            MOV     AH, 86H
            INT     15H
            add     segundo2,01h   
            jmp     start
            
       incs:MOV     segundo2,00H
            add     segundo1,01H
            CMP     segundo1,06H
            JZ      incm2
            JMP     start
            
      incm2:MOV     segundo1,00H
            add     minuto2,01h 
            CMP     minuto2,0AH
            JZ      incm1
            JMP     start
      
      incm1:MOV     minuto2,00H
            add     minuto1,01H
            CMP     minuto1,06H
            JZ      finish
            JMP     start
            
     finish:MOV     minuto1,00H
            ADD     hora,01H
            CMP     hora,24H
            JZ      reset
            JMP     start;
            
      reset:MOV     hora,00H;
            jmp     start
            
ret  
msgh     db "Digite a hora: ",0 
msgm     db "Digite o(s) minuto(s): ",0   
msgs     db "Digite o(s) segundo(s): ",0
hora     DW 00H;   
hora1    DB 00H
hora2    DB 00H
minuto1  DW 00H;
minuto2  DW 00H;
segundo1 DW 00H;
segundo2 DW 00H;

    DEFINE_PRINT_STRING
    DEFINE_GET_STRING  

imprimir PROC
            add     DX,0030H
            mov     AH,02H
            int 21H   
            ret 
imprimir endp            
    
END