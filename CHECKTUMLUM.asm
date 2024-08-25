.ORIG   X3300
CLEAR
            AND R0,R0,#0    ;DIFFERENCE
            AND R1,R1,#0    ;MINUEND SO BI TRU
            AND R2,R2,#0    ;SUBTRAHEND SO TRU
            AND R3,R3,#0    ;TEMP (put lientruoc or liensau in here)
            AND R4,R4,#0    ;
            AND R5,R5,#0    ;COUNTER
            AND R6,R6,#0    ;START
SETTING
            LD  R6,START
            ADD R6,R6,#1	;BAT DAU TAI O NHO 3000

            LDI R1,SUSPECT    ;LOAD GIA TRI CUA O NHO 3010 VAO R1

            LD  R5,TRUOC
            LDR R3,R5,X0
            LDR R4,R5,X1
            

CHECK                                 ;BAT DAU VONG LAP
            STI R5,COUNTER
            AND R0,R0,#0
            AND R1,R1,#0
            AND R2,R2,#0
            AND R4,R4,#0
            AND R5,R5,#0    ;DIFFERENCE
            ADD R6,R6,#1	;o nho 3001
            
            LDR R2,R6,X0      
            ;STI R2,TEMP1
            ;LDI R0,TEMP1 ;DAY RA R2
            ADD R0,R2,#0
            NOT R0,R0
            ADD R0,R0,#1    ;-R2
            
            ADD R5,R1,R0    ;CHECK  -------------------------------
            BRn SAU  ;R1<R0 NÊN R0 O SAU R1

    LIEN_TRUOC
            AND R5,R5,#0
		    AND R0,R0,#0
            AND R1,R1,#0
            
            ADD R1,R2,#0
            LDI R0,LIEN_TRUOC
            NOT R0,R0
            ADD R0,R0,#1
            ADD R5,R1,R0
            

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
            AND R5,R5,#0
            LDI R5,COUNTER
            ADD R5,R5,#1
            AND R0,R0,#0
            ADD R0,R5,#-15	;ket thuc o o nho 3000+15=300F
            BRn CHECK
            
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
HALT

    DOWN_LINE   .FILL  X0D
    MAX_MES     .STRINGZ    "MAXIMUM VALUE: "
    MIN_MES     .STRINGZ    ";	MINIMUM VALUE: "
    START       .FILL   X2FFF

    SUSPECT             .FILL   X3010
    TRUOC         	 .FILL   X3011
    SAU            	.FILL   X3012
    TEMP                .FILL   X3013
    COUNTER             .FILL   X3014
    .END    
