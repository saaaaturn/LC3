;check mảng và tìm min max trên toàn bộ mảng đó
.ORIG   X3000
CLEAR
            AND R0,R0,#0    ; 
            AND R1,R1,#0    ;MINUEND SO BI TRU
            AND R2,R2,#0    ;TEMP
            AND R3,R3,#0    ;SUBTRAHEND SO TRU
            AND R4,R4,#0    ;DIFFERENCE
            AND R5,R5,#0    ;COUNTER
            AND R6,R6,#0    ;START
SETTING_COUNTER
            LD R6,START
            ADD R6,R6,#1	;BAT DAU TAI O NHO 4001
		ADD	R5,R5,#0

            LDR R1,R6,X0    ;MAX
		LDR	R2,R6,X1    ;MIN

		;LDR	R3,R6,X2    

            STI  R1,MAX
            STI  R2,MIN

            ;STI  R3,MIN

CHECK_MAX_MIN
            AND R0,R0,#0
            AND R1,R1,#0
            AND R2,R2,#0
            AND R4,R4,#0
            ADD R6,R6,#1	;o nho 4002
            LDI  R1,MAX  ;DAY RA R1
            
            LDR R2,R6,X0      
            STI R2,TEMP1
            LDI R0,TEMP1 ;DAY RA R2
            
            NOT R0,R0
            ADD R0,R0,#1    ;-R0
            
            ADD R4,R1,R0    ;CHECK MAX (MAX - TEMP)-------------------------------
            BRn CHANGE_MAX  ;NEU R1<R2 THI DOI MAX = R2

		STI	R2,TEMP2

CHECK_MIN
            AND R4,R4,#0
            AND R0,R0,#0
            AND R1,R1,#0
	AND R2,R2,#0
            LDI R1,MIN
            LDI R2,TEMP2

		ADD   R0,R2,#0
            NOT R0,R0
            ADD R0,R0,#1

            ;R0 IS STILL TEMP
            ADD R4,R1,R0    ;CHECK MIN (MIN - TEMP2)--------------------------------
            BRp CHANGE_MIN  ;NEU R1>R0 THI DOI MIN = R0

CHECK_COUNTER
            ADD R5,R5,#1
            AND R0,R0,#0
            ADD R0,R5,#-3	;ket thuc o o nho 4001+3=4004
            BRn CHECK_MAX_MIN
            
;PRINT OUT MAX VALUE
            AND R0,R0,#0
            LEA R0,MAX_MES
            PUTS

            AND R0,R0,#0
            LDI  R0,MAX
            ADD R0,R0,#15
            ADD R0,R0,#15
            ADD R0,R0,#15
            ADD R0,R0,#3
            OUT

;PRINT OUT MIN VALUE
            AND R0,R0,#0
            LEA R0,MIN_MES
            PUTS

            AND R0,R0,#0
            LDI  R0,MIN
            ADD R0,R0,#15
            ADD R0,R0,#15
            ADD R0,R0,#15
            ADD R0,R0,#3
            OUT            

            HALT
CHANGE_MAX
            STI  R2,MAX
            STI  R1,TEMP2
            BRnzp   CHECK_MIN

CHANGE_MIN 
            STI  R2,MIN
            BRnzp   CHECK_COUNTER

    DOWN_LINE   .FILL  X0D
    MAX_MES     .STRINGZ    "MAXIMUM VALUE: "
    MIN_MES     .STRINGZ    ";	MINIMUM VALUE: "
    START       .FILL   X4000
    MAX         .FILL   X5000
    MIN           .FILL   X5001
    TEMP1         .FILL   X5002
    TEMP2         .FILL   X5003
    .END    
