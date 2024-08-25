;list các số có trong mảng
    .ORIG   X3050
    CLEAR
            AND R0,R0,#0    ;OUT 
            AND R1,R1,#0    ;SUM
            AND R2,R2,#0    ;X
            AND R3,R3,#0
            AND R4,R4,#0    ;so lan lap lai =11, tu 3000 toi 3010
            AND R5,R5,#0    ;COUNTER
            AND R6,R6,#0    ;START
SETTING_COUNTER
		LD	R1,ASCII
            ADD R4,R4,#-10
            LD R6,START
		ADD	R5,R5,#0
CALCULATING
            LDR R2,R6,X0
            ADD R6,R6,#1
            
            ADD R0,R2,#0
            ADD R0,R0,R1
            OUT
            
            ADD R5,R5,#1
            ADD R3,R5,R4
            BRnz CALCULATING
HALT

    ASCII   .FILL   X0030
    START   .FILL   X4000
    .END