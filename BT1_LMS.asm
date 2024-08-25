.ORIG X3000
;CLEAR
    AND R0,R0,#0
    AND R1,R1,#0
    AND R2,R2,#0
    AND R3,R3,#0
    AND R4,R4,#0
    AND R5,R5,#0
    AND R6,R6,#0
;INPUT FIRST NUMBER
    IN 
    ADD R1,R0,#0
	ADD	R1,R1,#-15
	ADD	R1,R1,#-15
	ADD	R1,R1,#-15
	ADD	R1,R1,#-3
	AND	R0,R0,#0
;INPUT SECOND NUMBER
    IN  
    ADD R2,R0,#0
    ADD	R2,R2,#-15
	ADD	R2,R2,#-15
	ADD	R2,R2,#-15
	ADD	R2,R2,#-3
	AND	R0,R0,#0
;INPUT THIRD NUMBER
    IN  
    ADD	R0,R0,#-15
	ADD	R0,R0,#-15
	ADD	R0,R0,#-15
	ADD	R0,R0,#-3
;COMPARING
;MAX-->R3, MIN-->R4
;SUPPOSE THAT R0 IS MAX, R1 IS MIN
    ADD R3,R0,#0
    ADD R4,R1,#0
;FIND -R1
    ADD R5,R1,#0    ;COPY VALUE OF R1 INTO R5
    NOT R5,R5
    ADD R5,R5,#1    ;-R5 = -R1
;COMPARE: R0 - R1
    ADD R6,R3,R5
;IF
    BRn CHANGING_MAX_R1    ;R0-R1<0 => R1 MAX R0 MIN
;CLEAR R5,R6
    AND R6,R6,#0
    AND R5,R5,#0
;FIND -R2
    ADD R5,R2,#0
    NOT R5,R5
    ADD R5,R5,#1
;COMPARE: R0 - R2
    ADD R6,R3,R5        ;R0-R2
;IF
    BRn CHANGING_MAX_R2
;HERE MAX STAYS REMAINED, LET'S CHECK MIN VALUE
    AND R6,R6,#0
    ADD R6,R1,R5
    BRp CHANGING_MIN
    HALT
;///////////////////////////////////////////////
CHANGING_MAX_R1
    AND R3,R3,#0
    NOT R5,R5
    ADD R5,R5,#1
    ADD R3,R5,#0
;COMPARE R1 AND R2
    AND R6,R6,#0
    AND R5,R5,#0
    ADD R5,R2,#0
    NOT R5,R5
    ADD R5,R5,#1
;COMPARE: R1 - R2
    ADD R6,R3,R5        ;R0-R2
    BRn CHANGING_MAX_R2
;CHECK MIN VALUE
    AND R6,R6,#0
    ADD R6,R0,R5
    BRp CHANGING_MIN
    HALT
;/////////////////////////////////
CHANGING_MAX_R2
    AND R3,R3,#0
    NOT R5,R5
    ADD R5,R5,#1
    ADD R3,R5,#0
;CHECK MIN
    AND R5,R5,#0
    AND R6,R6,#0
    ADD R5,R1,#0
    NOT R5,R5
    ADD R5,R5,#1
;COMPARE: R0 - R1
    ADD R6,R0,R5  
    BRn CHANGING_MIN
CHANGING_MIN
    AND R4,R4,#0
    NOT R5,R5
    ADD R5,R5,#1
    ADD R4,R5,#0    
    HALT
.END
    


