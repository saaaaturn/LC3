;tinh tong cac so trong mang
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
            LD R6,START
		    ADD	R5,R5,#0
CALCULATING
            ADD R6,R6,#1	;BAT DAU TAI O NHO 3001

            LDR R2,R6,X0
            ADD R1,R1,R2
            ADD R5,R5,#1
            ADD R3,R5,#-10  ;SO LAN DEM = 10
            BRnz CALCULATING
CLEAR2
	        AND R0,R0,#0    
            AND R2,R2,#0    
            AND R3,R3,#0
            AND R4,R4,#0    
            AND R5,R5,#0    
            AND R6,R6,#0 
		
ASSIGN_NUM	ADD	R5,R1,#0

CHECK_NUM	ADD	R4,R4,#1
            ADD	R5,R5,#-10
            BRzp	CHECK_NUM
            ADD	R6,R4,#0
            ADD	R6,R6,#-1
            BRz	UNITS

DOZENS		AND	R0,R0,#0
            ADD	R0,R4,#-1
            ADD	R0,R0,#15
            ADD	R0,R0,#15
            ADD	R0,R0,#15
            ADD	R0,R0,#3
            OUT

UNITS		AND	R0,R0,#0
            ADD	R0,R5,#10
            ADD	R0,R0,#15
            ADD	R0,R0,#15
            ADD	R0,R0,#15
            ADD	R0,R0,#3
            OUT

HALT

    ASCII   .FILL   X0030
    START   .FILL   X3000
    .END