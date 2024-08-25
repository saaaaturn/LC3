;check prime co trong mang
    .ORIG   X3000
    CLEAR
            AND R0,R0,#0    ;OUT 
            AND R1,R1,#0    ;ASCII
            AND R2,R2,#0    ;X
            AND R3,R3,#0
            AND R4,R4,#0    ;so lan lap lai
            AND R5,R5,#0    ;COUNTER
            AND R6,R6,#0    ;START
	SETTING_COUNTER
            LD R6,START
			ADD	R5,R5,#0	;R5 TUYET DOI KO DUOC THAY DOI VI DAY LA BO DEM
			
	MOVE_ON
			STI R5,BO_DEM
            LDR R1,R6,X0    ; lAY -GIA TRI- TU O NHO--------->R1
            ADD R6,R6,#1	;R6 KO DUOC DOI DO DAY LA VI TRI O NHO
			;;CHECKING PRIME NUMBER OR NOT
				;CLEAR	

		AND	R2,R2,#0	;SO CHIA
		AND	R3,R3,#0	;DIFFERENCE
		AND	R4,R4,#0

	;CHECK DIVISION
		ADD	R2,R1,#0	;Gan gia tri o R1 vao R2
	;CHECK_OVER_1
		ADD	R3,R2,#-1	;R2 -1 de xem if R1 lon hon 1 hay ko
		BRnz	CHECK_TO_MOVE_ON
	AGAIN
		AND	R5,R5,#0
		AND	R4,R4,#0
		AND	R3,R3,#0
		ADD	R3,R1,#0

		ADD	R2,R2,#-1	;R2 - 1 = so dang truoc R1
		ADD	R5,R2,#-1	;R2 giam dan', khi chi con 1, 1-1=0 thì chắc chắn đây là PRIME
		BRz	PRIME
		ADD	R4,R2,#0
		NOT	R4,R4
		ADD	R4,R4,#1	;-R2

	DIVISION
		ADD	R3,R3,R4	;check if chia hết hay ko
		BRz	CHECK_TO_MOVE_ON	;=0 tức là chia hết
		BRp	DIVISION	;còn chia tiếp được
		BRn	AGAIN		;chia k hết nên lặp lại AGAIN để chia cho số nhỏ hơn
	PRIME	
		AND	R0,R0,#0
		ADD	R0,R1,#0
		ADD	R0,R0,#15
		ADD	R0,R0,#15
		ADD	R0,R0,#15
		ADD	R0,R0,#3
		OUT

	CHECK_TO_MOVE_ON
		AND	R5,R5,#0
		LDI	R5,BO_DEM
        ADD R5,R5,#1
		AND	R3,R3,#0
        ADD R3,R5,#-10
        BRnz MOVE_ON
		HALT
START   .FILL   X4000
BO_DEM	.FILL	X5000
.END