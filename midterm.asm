;tìm số liền trước và liền sau của ô nhớ x3010
      .ORIG X3100
      ;CLEAR
            AND   R0,R0,#0    ;HIEU
            AND   R1,R1,#0    ;SO BI TRU
            AND   R2,R2,#0    ;SO TRU
            AND   R3,R3,#0
            AND   R4,R4,#0
            AND   R5,R5,#0    ;COUNTER
            AND   R6,R6,#0    ;O NHO
      ;SETTING
            LD    R6,START    ;BAT DAU O 2FFF
            ;LDI   R1,SUSPECT  ;LOAD GIA TRI SUSPECT VAO R1
            ;ADD   R1,R1,#-1  ;LIEEN TRUOC
            ;STI   R1,TRUOC    ;LOAD VAO LIEN TRUOC
	      LDI	R2,SUSPECT	;LOAD GIA TRI SUSPECT VAO R2
            ADD   R2,R2,#15   ;LIEN SAU
            STI   R2,SAU      ;LOAD VAO LIEN SAU 
      START_CHECKING          ;VAO VONG LAP
            ADD   R6,R6,#1    ;BAT DAU TAI X3000
            AND   R0,R0,#0    ;CLEAR SAU VONG LAP TRUOC
            AND   R1,R1,#0    ;_________________________
            AND   R2,R2,#0    ;_________________________
            AND   R4,R4,#0    ;_________________________
            LDI   R1,SUSPECT  ;LOAD GIA TRI SUSPECT VAO R1
            LDR   R2,R6,X0    ;LOAD GIA TRI O NHO VAO R2
            NOT   R2,R2
            ADD   R2,R2,#1    ;R2 THANH -R2
            ;***************
            ADD   R0,R1,R2    ;R0=R1+(-R2)
            ;***************
            BRz   CHECK_COUNTER;AS R1=R2 SO THERE'S NO CHANGE
            BRn   CHECK_LS    ;IF R1<R2-->R2 IS BEHIND R1
      ;CHECK_LT               ;AS THE FLOW'S GOING ON, NOW WE'RE CONSIDERING R1>R2.
            AND   R0,R0,#0    ;CLEAR R0
            AND   R1,R1,#0    ;CLEAR R1
            LDI   R1,TRUOC    ;LOAD SO LIEN TRUOC VAO R1

            ADD   R0,R1,R2    ;LIEN TRUOC - R2
            BRz   CHECK_COUNTER;NOTHING CHANGE
            BRp   CHECK_COUNTER;AS R1>R2 SO R2 MUST BE FARER FROM SUSPECT THAN THE CURRENT LT(R1)
            ;CHANGE LT
            NOT   R2,R2
            ADD   R2,R2,#1    ;CHANGE (-R2) BACK TO R2
            STI    R2,TRUOC
            BRnzp CHECK_COUNTER;CHECK COUNTER DE THUC HIEN LAI LOOP
      CHECK_LS
            AND   R0,R0,#0    ;CLEAR R0
            AND   R1,R1,#0    ;CLEAR R1
            LDI   R1,SAU      ;LOAD SO LIEN SAU VAO R1

            ADD   R0,R1,R2    ;LIEN SAU - R2
            BRz   CHECK_COUNTER;NOTHING CHANGE
            BRn   CHECK_COUNTER;AS R1<R2 SO R2 MUST BE FARER FROM SUSPECT THAN THE CURRENT LS(R1)
            ;CHANGE LS
            NOT   R2,R2
            ADD   R2,R2,#1    ;CHANGE (-R2) BACK TO R2
            STI   R2,SAU
            BRnzp CHECK_COUNTER;CHECK COUNTER DE THUC HIEN LAI LOOP   
      CHECK_COUNTER
            ADD   R5,R5,#1
            ADD   R4,R5,#-16
            BRn   START_CHECKING
            HALT
      START       .FILL X2FFF
      SUSPECT     .FILL X3010
      TRUOC       .FILL X3011
      SAU         .FILL X3012
      .END
