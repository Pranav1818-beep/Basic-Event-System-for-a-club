.model small
.stack 100h
.data

        msgWELC db 10,10, 13, "Welcome to REXXS registration system"
                db 10, 13, "1.  Workshop (1)"
                db 10, 13, "2.  Competition (2)"
                db 10, 13, "3.  Other (3)"
                db 10, 13, "4.  Finish (4)"
                db 10, 13, "Enter your choice: $"

        msgWKSP db 10, 10, 10, 13, "WORKSHOP"
                db 10, 13, "1.  Introduction to binary exploitation (1) 10RM"
                db 10, 13, "2.  Penetration testing (2) 15RM"
                db 10, 13, "3.  Reverse Engineering (3) 15RM"
                db 10, 13, "4.  Hack the Box (4) 15RM"
                db 10, 13, "5.  Cryptography (5) 15RM"
                db 10, 13, "6.  Introduction to Python (6) FREE"
                db 10, 13, "7.  Exit (7)"
                db 10, 13, "Enter the choice: $"

        msgCOMP db 10, 10, 10, 13, "COMPETITION" , 0Ah
                db "1.  Battle of Hacker CTF (1) 30RM", 0ah
                db "2.  Cybersecurity Paper Competition (2) FREE", 0ah
                db "3.  Competitive Programming (3) 10RM", 0ah
                db "4.  Exit (4)", 0ah
                db "Enter your choice: $"

        msgOTHR db 10, 10, 10, 13, "OTHER", 0Ah
                db "1.  Cybersecurity Essentials Talk (1) FREE", 0ah
                db "2.  Cybersecurity Awareness Talk (2) FREE", 0ah
                db "3.  Passwordless Authentication Seminar (3) FREE", 0ah
                db "4.  Exit (4)", 0ah
                db "Enter your choice: $"
        
        msgCart db 10, 10, 13, "Total Price: $"

        Price   dw 1000 dup(0)

.code
        main proc
                ;data initialization 
                mov ax, @data
                mov ds, ax

        MAINMENU:
                ;print main menu
                LEA dx, msgWELC
                mov ah, 09h
                int 21h

                ;read user input
                mov ah, 01h
                int 21h

                ;comparison
                cmp al, '1'
                je WKSP   
                cmp al, '2'
                je COMP
                cmp al, '3'
                je OTHR
                cmp al, '4'
                je FINISH

        FINISH: ;FINISH PROGRAM

                lea dx, msgCart ; print Total Price:
                mov ah, 09h
                int 21h        

                mov ax, Price
                aam
                add ax, 3030h

                mov dh, al      ; retaining value for printing use

                mov dl, ah      ; print first digit (Ten's digit)
                mov ah, 02h
                int 21h

                mov dl, dh      ; print second digit (One's digit)
                mov ah, 02h
                int 21h

                mov ah, 4ch
                int 21h
        EXIT_:
                ;to go back to main menu
                jmp MAINMENU

        WKSP: ;Case for Workshop
                
                LEA dx, msgWKSP ;Print Workshop Menu
                mov ah, 09h
                int 21h

                mov ah, 01h     ;get user input
                int 21h

                ;jmp comparison depending on the choice
                cmp al, '1'
                je TEN_RM
                cmp al, '2'
                je FIFTEEN_RM
                cmp al, '3'
                je FIFTEEN_RM
                cmp al, '4'
                je FIFTEEN_RM
                cmp al, '5'
                je FIFTEEN_RM
                cmp al, '6'
                je FREE_RM
                cmp al, '7'
                je FREE_RM

        COMP:   ;Case for Competition
				mov bx, 0 ;clears the bx register for memory use (no idea why, but it works)
                LEA dx, msgCOMP ; Print Competition Menu
                mov ah, 09h
                int 21h

                mov ah, 01h     ; get user input
                int 21h

                cmp al, '1'
                je THIRTY_RM
                cmp al, '2'
                je FREE_RM
                cmp al, '3'
                je TEN_RM
                cmp al, '4'
                je FREE_RM
				
				

        OTHR:   ;case for Other Option

                LEA dx, msgOTHR
                mov ah, 09h
                int 21h

                mov ah, 01h
                int 21h

                ;comparison
                cmp al, '1'
                je FREE_RM
                cmp al, '2'
                je FREE_RM
                cmp al, '3'
                je FREE_RM
                cmp al, '4'
                je FREE_RM


			
        TEN_RM:
                mov bx, 10      ;+10RM
                jmp TOTAL_
        FIFTEEN_RM:
                add bx, 15      ;+15RM
                jmp TOTAL_
        THIRTY_RM:                
                add bx, 30      ;+30RM
                jmp TOTAL_
        FREE_RM:
                xor bx, bx      ;+0RM   
                jmp TOTAL_ 

        TOTAL_: ;print the total value
                add Price, bx   ; updating Total Price value

                lea dx, msgCart ; print Total Price:
                mov ah, 09h
                int 21h
                
                mov ax, Price
                aam
                add ax, 3030h

                mov dh, al      ; retaining value for printing use

                mov dl, ah      ; print first digit (Ten's digit)
                mov ah, 02h
                int 21h

                mov dl, dh      ; print second digit (One's digit)
                mov ah, 02h
                int 21h

                jmp EXIT_

        Total2Digit:

                cmp Price, '99'
                jle Total2Digit ;failed experiment

        ; for clearing screen
        clear_screen proc
                mov  ah, 0
                mov  al, 3
                int  10H
                ret
        clear_screen endp

        main endp
        end main
