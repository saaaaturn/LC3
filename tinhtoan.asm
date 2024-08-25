.ORIG x3000
AND R0,R0,#0
AND R1,R1,#0
AND R2,R2,#0
AND R3,R3,#0
AND R4,R4,#0
AND R5,R5,#0
AND R6,R6,#0
;====================================================================;
			  ;MID;
;====================================================================;
MID	LD R3,N_STRING	; LOAD THE FIRST ADDRESS OF NEW STRING
	LD R4, PN_STRING; LOAD THE FIRST ADDRESS OF PN STRING
LOOP5	LDR R1,R4,#0
	ADD R2,R1,#-10
	BRZ SAVE_ENTER
	STR R1,R3,#0
	ADD R4,R4,#1
	ADD R3,R3,#1
	BR LOOP5
SAVE_ENTER STR R1,R3,#0
	   BR CAL    
;====================================================================;
			;DECLARE;
;====================================================================;
PN_STRING .FILL X8000   ;POLISH NOTATION
;====================================================================;
			;CALCULATING;
;====================================================================;
CAL	AND R6,R6,#0	; R6 FOR POINTER OF PN_STRING
	AND R1,R1,#0	; FREE TO USE
	AND R2,R2,#0	; FREE TO USE
	AND R3,R3,#0	; FREE TO USE
	AND R4,R4,#0	; R4 FOR POINTER OF TMP
	AND R5,R5,#0	; FREE TO USE

	LD R6,N_STRING	; R6: POINTER OF PN_STRING
	LD R4,TMP	; R4: POINTER OF TMP 

CA_LOOP	LDR R1,R6,#0 
	
	LD R3,POW		; CHECKING FOR '^'
	ADD R5,R1,R3
	BRZ BO_MU

	LD R3,MULTI		; CHECKING FOR '*'
	ADD R5,R1,R3
	BRZ BO_NHAN

	LD R3,DIV 		; CHECKING FOR '/'
	ADD R5,R1,R3
	BRZ BO_CHIA
	
	LD R3,PLUS		; CHECKING FOR '+'
	ADD R5,R1,R3
	BRZ BO_CONG

	LD R3,MINUS		; CHECKING FOR '-'
	ADD R5,R1,R3
	BRZ BO_TRU

	ADD R5,R1,#-10		; CHECKING FOR 'ENTER'
	BRZ DONE
	
	LD R3,NEASCII
	ADD R1,R1,R3
	STR R1,R4,#0		; STORE THE VALUE TO THE MEMORY OF TMP
	ADD R4,R4,#1		; INCREASE THE POINTER OF TMP BY 1
	ADD R6,R6,#1		; INCREASE THE POINTER OF PN_STRING BY 1

	BR CA_LOOP

BO_MU	LDR R2,R4,#-1		; SECOND NUMBER -1 
	LDR R1,R4,#-2		; FIRST NUMBER -2
	AND R0,R0,#0
	AND R3,R3,#0
	AND R5,R5,#0
	ADD R0,R2,#-1
	BRnz ZERO
POWER	ADD R3,R1,#0
MUL	ADD R5,R5,R1
	ADD R3,R3,#-1
	BRp MUL
	ADD R0,R0,#-1
	BRp POWER
	BRnz COMPLETE
ZERO	ADD R5,R5,#1
COMPLETE STR R5,R4,#-2
	 ADD R4,R4,#-1
	 ADD R6,R6,#1
	 BR CA_LOOP

BO_TRU	LDR R2,R4,#-1		; SECOND NUMBER -1 
	LDR R1,R4,#-2		; FIRST NUMBER -2
	NOT R2,R2
	ADD R2,R2,#1		; 2'S COMPLEMENT
	ADD R5,R1,R2		; COMPUTING
	STR R5,R4,#-2		; STORING NEW VALUE TO THE FIRST NUMBER MEMORY ADDRESS
	ADD R4,R4,#-1		; DECREASE THE POINTER OF TMP BY 1
	ADD R6,R6,#1		; INCREASE THE POINTER OF PN_STRING BY 1
	BR CA_LOOP

BO_CONG	LDR R2,R4,#-1		; SECOND NUMBER
	LDR R1,R4,#-2		; FIRST NUMBER
	ADD R5,R1,R2		; COMPUTING
	STR R5,R4,#-2		; STORING NEW VALUE TO THE FIRST NUMBER MEMORY ADDRESS
	ADD R4,R4,#-1		; DECREASE THE POINTER OF TMP BY 1
	ADD R6,R6,#1		; INCREASE THE POINTER OF PN_STRING BY 1
	BR CA_LOOP

BO_NHAN	LDR R2,R4,#-1		; SECOND NUMBER
	LDR R1,R4,#-2		; FIRST NUMBER
	AND R5,R5,#0
LOOP_M	ADD R5,R5,R2		; COMPUTING
	ADD R1,R1,#-1		; COUNTER FOR MULTIPLYING
	BRP LOOP_M		; IF THE COUNTER STILL POSITIVE/ZERO --> RETURN TO LOOP_M
	STR R5,R4,#-2		; STORING NEW VALUE TO THE FIRST NUMBER MEMORY ADDRESS
	ADD R4,R4,#-1		; DECREASE THE POINTER OF TMP BY 1
	ADD R6,R6,#1		; INCREASE THE POINTER OF PN_STRING BY 1
	BR CA_LOOP	

BO_CHIA	LDR R2,R4,#-1		; SECOND NUMBER
	LDR R1,R4,#-2		; FIRST NUMBER
	NOT R2,R2		; 2'S COMPLEMENT
	ADD R2,R2,#1
	AND R5,R5,#0
LOOP_D	ADD R5,R5,#1		; COUNTER FOR DEVIDING		
	ADD R1,R1,R2		; COMPUTING
	BRP LOOP_D		; IF THE COUNTER STILL POSITIVE/ZERO --> RETURN TO LOOP_M
	STR R5,R4,#-2		; STORING NEW VALUE TO THE FIRST NUMBER MEMORY ADDRESS
	ADD R4,R4,#-1		; DECREASE THE POINTER OF TMP BY 1
	ADD R6,R6,#1		; INCREASE THE POINTER OF PN_STRING BY 1
	BR CA_LOOP

DONE	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0		; CLEAR
	AND R4, R4, #0
	AND R5, R5, #0
	AND R6, R6, #0
	
	LD R3, ASCII
	LD R4, NECNGAN
	LD R5, NENGAN
	LD R6, NETRAM
	LDI R1,TMP
	BRP POS				; DUONG -> POS
	BRN NEG				; AM -> NEG
	BR NEXT
	
POS	LEA R0, MESG2			;
	PUTS			;  
	BR NEXT1			; xuat MESG2 -> NEXT1

NEG	LEA R0, MESG1			;
	PUTS			; nhom lenh xuat chuoi MESG1
	ADD R1, R1, #-1			; 
	NOT R1, R1			; lay bu 2 nguoc cua R1 de duoc gia tri tuyet doi (duong)
	BR NEXT1			; -> NEXT1

NEXT	LEA R0, MESG			;
	PUTS			; nhom lenh xuat chuoi MESG
	HALT				; ket thuc chuong trinh

NEXT1	AND R0, R0, #0			; xoa thanh ghi R0 de lam bien dem
	ADD R2, R1, R4			; hieu voi 10000 de kiem tra co hang chuc ngan khong
	BRN NEXT2			; am -> NEXT2
LO0P1	ADD R0, R0, #1			; chu so hang chuc ngan + them 1
	ADD R2, R2, R4			; hieu voi 10000 de dem co bao nhieu o hang chuc ngan
	BRN XUAT1			; am -> XUAT1
	BR LO0P1			; lap lai LOOP1
XUAT1	ADD R0, R3, R0			; dua R0 ve ma Ascii
	OUT			; xuat gia tri hang chuc ngan (R0)
	
	; nhom lenh them ky tu "0" cho hang ngan neu co ton tai hang chuc ngan
	LD R0, CNGAN			; 10000 -> R0
	ADD R2, R0, R2			; lay lai cac gia tri tu hang ngan
	AND R0, R0, #0			; xoa thanh ghi R0 de neu hang ngan = 0 -> xuat ra 0 (R0)
	ADD R2, R2, R5			; R2 - 1000 -> kiem tra hang ngan co = 0 khong
	BRN XUAT2			; am -> XUAT2 (xuat R0 = 0)
	BR LOOP2			; -> LOOP2 (neu hang ngan co ton tai)

NEXT2	LD R0, CNGAN			; 10000 -> R0
	ADD R2, R0, R2			; lay lai cac gia tri tu hang ngan
	AND R0, R0, #0			; xoa thanh ghi R0 de lam bien dem
	ADD R2, R2, R5			; hieu voi 1000 de kiem tra co hang chuc ngan khong
	BRN NEXT3			; am -> NEXT3
LOOP2	ADD R0, R0, #1			; chu so hang ngan + them 1
	ADD R2, R2, R5			; hieu voi 1000 de dem co bao nhieu o hang ngan
	BRN XUAT2			; am -> XUAT2 (di xuat bien dem R0)
	BR LOOP2			; lap lai LOOP2
XUAT2	ADD R0, R3, R0			; dua R0 ve ma Ascii
	OUT			; xuat hang ngan (R0)
	
	; nhom lenh them ky tu "0" cho hang tram neu co ton tai hang ngan va hang chuc ngan
	LD R0, NGAN			; 1000 -> R0
	ADD R2, R0, R2			; lay lai cac gia tri tu hang tram
	AND R0, R0, #0			; xoa thanh ghi R0 de neu hang tram = 0 -> xuat ra 0 (R0)
	ADD R2, R2, R6			; R2 - 100 -> kiem tra hang tram co = 0 khong
	BRN XUAT3			; am -> XUAT3 (xuat R0 = 0)
	BR LOOP3			; -> LOOP3 (neu hang ngan co ton tai)

NEXT3	LD R0, NGAN			; 
	ADD R2, R0, R2			;
	AND R0, R0, #0			;
	ADD R2, R2, R6			;
	BRN NEXT4			;
LOOP3	ADD R0, R0, #1			;
	ADD R2, R2, R6			;
	BRN XUAT3			;
	BR LOOP3
XUAT3	ADD R0, R3, R0			;
	OUT			; tuong tu nhu tren voi hang tram
	
	; nhom lenh them ky tu "0" cho hang tram neu co ton tai hang ngan, hang chuc ngan va hang tram
	LD R0, TRAM			; 
	ADD R2, R0, R2			;
	AND R0, R0, #0			; 
	ADD R2, R2, #-10		;
	BRN XUAT4			; tuong tu nhu tren
	BR LOOP4

NEXT4	LD R0, TRAM			; 
	ADD R2, R0, R2
	AND R0, R0, #0			;
	ADD R2, R2, #-10		;
	BRN NEXT5			
LOOP4	ADD R0, R0, #1			;
	ADD R2, R2, #-10		;
	BRN XUAT4			;
	BR LOOP4
XUAT4	ADD R0, R3, R0			;
	OUT			        ; tuong tu nhu tren

NEXT5	ADD R0, R2, #10			; R2 cong 10 -> hang don vi
	ADD R0, R0, R3			; R2 -> ma Ascii
	OUT				; xuat hang don vi

	HALT

;====================================================================;
			;ASCII CONSTANT;
;====================================================================;
N_STRING .FILL X4000
TMP     .FILL X5000
POW 	.FILL #-94		;ASCII OF '^'
MULTI 	.FILL #-42		;ASCII OF '*'
DIV 	.FILL #-47		;ASCII OF '/'
PLUS 	.FILL #-43		;ASCII OF '+'
MINUS 	.FILL #-45 		;ASCII OF '-'
NEASCII .FILL #-48
ASCII	.FILL X30
CNGAN	.FILL #10000			
NGAN	.FILL #1000			
TRAM	.FILL #100			
NECNGAN	.FILL #-10000			
NENGAN	.FILL #-1000			
NETRAM	.FILL #-100
MESG .STRINGZ "YOUR RESULT: 0"
MESG1 .STRINGZ "YOUR RESULT: -"
MESG2 .STRINGZ "YOUR RESULT: "		
;==================================================================;
    .END