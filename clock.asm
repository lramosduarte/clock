include 'emu8086.inc'
#make_com#
org 100h

            LEA si,msgh         ;HORA
            call print_string
            
            LEA DI,hora1
            mov dx,02H
            call get_string
            LEA DI,hora2
            mov dx,02H
            call get_string
            sub hora1,30H
            sub hora2,30H
                           
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
            
      start:;cmp     segundo,09H
            ;jz      inctime
            mov     bx,segundo2
            MOV     CX, 0FH     ;delay de 1segundo
            MOV     DX, 4240H
            MOV     AH, 86H
            INT     15H
            add     segundo2,01h
            
            jmp start
            
    ;inctime:bx

ret 
msgh     db "Digite a(s) hora(s): ",0
msgm     db "Digite o(s) minuto(s): ",0
msgs     db "Digite o(s) segundo(s): ",0
hora1    DW 00H;
hora2    DW 00H;
minuto1  DW 00H;
minuto2  DW 00H;
segundo1 DW 00H;
segundo2 DW 00H;

    DEFINE_PRINT_STRING
    DEFINE_GET_STRING  


    
END