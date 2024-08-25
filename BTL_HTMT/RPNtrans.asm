    .ORIG X3000         ;START
                        ;CLEAR
    AND R0,R0,#0        ;INPUT
    AND R1,R1,#0        ;USE TO CALCULATE
    AND R2,R2,#0        ;USE TO CALCULATE
    AND R3,R3,#0        ;COUNTER FOR SIGNSTRING
    AND R4,R4,#0        ;ADDRESS OF RPN_STRING
    AND R5,R5,#0        ;ADDRESS OF SIGN_STRING
    AND R6,R6,#0        ;ADDRESS OF START_STRING
                        
    LD  R6,START_STRING  ;LOAD START STRING ADDRESS
    LD  R5,RPN_STRING    ;LOAD RPN STRING ADDRESS
    LD  R4,SIGN_STRING   ;LOAD SIGN STRING ADDRESS
    ADD R3,R3,#0        ;NUMBER OF THE TOP CHAR OF SIGN STACK
    
    LEA R0,MESG1        ;LOAD TEXT MESG1: "ENTER STRING:"
    PUTS                ;DISPLAY THE TEXT
    ;
    INPUT               ;*LABEL* --> ENTER THE FUNCTION
    AND R0,R0,#0        ;CLEAR R0
    ADD R6,R6,#1        ;INCREASE ADDRESS OF START STRING BY 1
    GETC                ;GET THE CHARATER 
    OUT                 ;DISPLAY THE CHARACTER
    ADD R1,R0,X-0A      ;CHECK IF INPUT IS "ENTER"?
    BRnp STORING_STS    ;IF NO THEN CONTINUE GETTING NEW CHARS

                        ;AFTER FINISH THE FUNCTION, PRINT OUT THE RPN
    AND R0,R0,#0        ;PRINT OUT RPN STRING
    LEA R0,MESG2        ;LOAD TEXT MESG1: "RPN FUNCTION: "
    PUTS                ;DISPLAY THE TEXT
            
    AND R0,R0,#0        ;CLEAR        
    AND	R2,R2,#0        ;CLEAR
    LD  R2,RPN_STRING    ;LOAD TOP OF RPN STRING 
    ;
    PRINT_RPN           ;*LABEL* --> DISPLAY RPN FUNCTION
    ADD	R2,R2,#1        ;INCREASE THE ADDRESS UP TO 1
    LDR R0,R2,#0        ;LOAD THE CHARACTER TO R0
    OUT                 ;DISPLAY THE CHARACTER
    
                        ;SAVE IN PN STRING
    AND R1,R1,#0
    LD  R1, PN_STRING   ;LOAD PN STRING ADDRESS
    STR R0,R1,#0        ;STORE THE CHAR IN PN STRING 
    ADD R1,R1,#1        ;ADDRESS + 1      
    ST  R1, PN_STRING   ;STORE BACK IN 
    AND R0,R0,#0
    LDI R0,TEMP2        ;LOAD VALUE OF TEMP2 (TOTAL CHARS OF PN STRING)
    ADD R0,R0,#1        ;TOTAL CHARS +1
    STI R0,TEMP2        ;SAVE IT BACK TO TEMP2

    AND R1,R1,#0        ;CLEAR
    LDI R1,TEMP         ;LOAD 'TEMP' INTO R1
    ADD R1,R1,#-1       ;AS WE PRINT OUT 1 CHARACTER, TOTAL CHARS IN STRING REDUCE BY 1
    STI R1,TEMP         ;SAVE TEMP
    ADD	R1,R1,#-0       ;CHECK IF THE NO. OF CHAR IS 0?
    BRp PRINT_RPN       ;IF >0 --> NOT EMPTY

    AND R2,R2,#0        ;CLEAR    
    AND R0,R0,#0        ;CLEAR
    ;
    PRINT_SIGN          ;*LABEL* --> PRINT OUT ALL THE SIGNS LEFT IN SIGN STRING
    LDR R0,R4,#0        ;LOAD ADDRESS OF SIGN STRING INTO R0 
    OUT                 ;DISPLAY SIGN
    
                        ;SAVE TO PN STRING
    AND R1,R1,#0
    LD  R1, PN_STRING   ;LOAD PN STRING ADDRESS
    STR R0,R1,#0        ;STORE THE CHAR IN PN STRING 
    ADD R1,R1,#1        ;ADDRESS + 1      
    ST  R1, PN_STRING   ;STORE BACK IN 
    AND R0,R0,#0
    LDI R0,TEMP2        ;LOAD VALUE OF TEMP2 (TOTAL CHARS OF PN STRING)
    ADD R0,R0,#1        ;TOTAL CHARS +1
    STI R0,TEMP2        ;SAVE IT BACK TO TEMP2

    ADD R4,R4,#-1       ;ADDRESS BY 1
    ADD R3,R3,#-1       ;NUMBER OF THE TOP CHAR OF SIGN STACK REDUCE BY 1
    BRnp PRINT_SIGN     ;IF STRING IS NOT EMPTY THEN REPEAT

                        ;PRINT OUT PN FUNCTION
    AND R0,R0,#0
    AND R1,R1,#0
    LEA R0,MESG3        ;LOAD MESG3 : "PN FUNCTION"
    PUTS                ;DISPLAY TEXT
    AND R2,R2,#0
    LD  R2,PN_STRING    ;LOAD ADDRESS OF PN STRING
    LDI R1,TEMP2        ;LOAD VALUE OF TEMP2 (TOTAL CHARS OF PN STRING)
    ;
    PRINT_PN            ;*LABEL*
    LDR R0,R2,#0        ;LOAD CHAR INTO R0
    OUT                 ;DISPLAY
    ADD R2,R2,#-1       ;TOP STRING -1
    ADD R1,R1,#-1       ;TOTAL CHARS -1
    BRzp PRINT_PN       ;IF NOT EMPTY THEN CONTINUE
    HALT    
;////////////////////////////////////////////////////////////////////////////////////////
                        
    STORING_STS         ;*LABEL* --> STORE CHARS AND CHECK ON THOSE CHARS
    STR R0,R6,X0        ;STORE CHARACTER IN START_STRING
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-8       ;-40 OPEN BRACKET '('
    BRz CHECK_SIGN1   
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-9       ;-41 CLOSE BRACKET ')'
    BRz CHECK_SIGN1 
    
                        ;CHECK IF THE CHAR IS >= 0
    AND R1,R1,#0        ;CLEAR 
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16      ;-48 (number 0)
    
    BRn CHECK_SIGN1     ;SIGN 1 INCLUDES + - * /
                        ;CHECK IF THE CHAR IS <= 9
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-9       ;-57 (number 9)
    BRnz STORING_RS     ;IF CHAR IS 30<=X<=39--> CHAR IS NUMBER --> STORE IN RPN
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-6       ;-86 (V --> square root)
    BRz CHECK_SIGN1
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-14      ;-94 (^ --> power)
    BRz CHECK_SIGN1
    
    AND R1,R1,#0        ;CLEAR 
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16  
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-1       ;-97 (letter a)
    BRn INPUT           ;if less than 97 then move on to next input
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-10      ;-122 (letter z)
    BRnz STORING_RS     ;IF CHAR IS 30<=X<=39--> CHAR IS NUMBER --> STORE IN RPN
    
    BRnzp INPUT         ;ELSE THEN IGNORE AND GET NEXT CHAR
    HALT
    ;
    STORING_RS          ;*LABEL* --> STORE REVERSE PN
    ADD R5,R5,X1        ;INCREASE ADDRESS OF RPN STRING BY 1
    
    LDI R1,TEMP         ;LOAD TEMP
    ADD R1,R1,#1        ;TOTAL CHARS IN RPN INCREASE BY 1
    STI R1,TEMP         ;STORE TEMP
    
    STR R0,R5,X0        ;SAVE THE CURRENT CHAR INTO RPN STRING
    BRnzp INPUT         ;COME BACK TO GET THE NEXT CHARACTER
    HALT
    ;
    CHECK_SIGN1         ;*LABEL* --> CHECK IF THE CURRENT SIGN IS THE FIRST SIGN?
    AND R1,R1,#0        ;CLEAR
    ADD R1,R3,#-0       ;COUNTER (R3) = 0?
    BRz SAVE_SIGN       ;IF TRUE THEN SAVE SIGN
    AND R1,R1,#0        ;CLEAR
    ;
    CHECK_SIGN2         ;*LABEL* -->IF FALSE THEN CHECK FOR CASES
    LDR R2,R4,#0        ;LOAD TOP SIGN OF SIGN STRING
    
    AND R1,R1,#0        ;CLEAR
    ADD R1,R2,#-16
    ADD R1,R1,#-16
    ADD R1,R1,#-8       ;-40 --> '('
    BRz SAVE_SIGN       
    
    NOT R2,R2       
    ADD R2,R2,#1        ;-R2
    ADD R1,R0,R2        ;CURRENT SIGN (R0)- TOP SIGN OF STACK (R2)= DIFFERENCE (R1) (KHOANG CACH GIUA 2 DAU VOI NHAU TRONG ASCII)
    BRz POP_SIGN        ;IF R1 = 0 --> SAME SIGN 

                        ;CHECK FOR SPECIFIC CASES
    AND R2,R2,#0
    ADD R2,R1,#-2       ;/ VS - AND - VS +
    BRz SPEC_CASE       ;CHECK FOR SPECIAL CASE
    AND R2,R2,#0
    ADD R2,R1,#5        ;x VS /
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#2        ;+ VS - AND - VS /
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#-1       ;+ VS x
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#4        ;+ VS /
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#-3       ;- VS x
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#-5       ;/ VS x
    BRz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#15
    ADD R2,R2,#15
    ADD R2,R2,#15
    ADD R2,R2,#2        ; (47) --> ^
    BRnz POP_SIGN
    AND R2,R2,#0
    ADD R2,R1,#15
    ADD R2,R2,#15
    ADD R2,R2,#9        ; (39) --> V
    BRnz POP_SIGN
    BRnzp SAVE_SIGN
    HALT
    ;
    SAVE_SIGN           ;*LABEL* 
    ADD R4,R4,#1        ;ADDRESS OF SIGN STRING
    ADD R3,R3,#1        ;COUNTER + 1
    STR R0,R4,#0        ;STORE THE SIGN INTO THE ADDRESS

                        ;CHECK IF THE CURRENT CHARACTER IS ')'
    AND R1,R1,#0
    ADD R1,R0,#-16
    ADD	R1,R1,#-16
    ADD	R1,R1,#-9       ;-41 CB ')'
    BRz POP_SIGN2
    
    BRnzp INPUT
    HALT
    ;
    POP_SIGN            ;*LABEL*
    LDR R2,R4,#0        ;TOP SIGN OF SIGN STRING
    ADD R5,R5,#1        ;TOP RPN + 1
    STR R2,R5,#0        ;SAVE TO RPN STRING
    ADD R4,R4,#-1       ;TOP SIGN STRING -1
    ADD R3,R3,#-1       ;SIGN COUNT -1
    AND R1,R1,#0
    LDI R1,TEMP         
    ADD R1,R1,#1        ;TOTAL CHARS +1
    STI R1,TEMP
    BRnzp CHECK_SIGN1   ;COME BACK TO CHECK
    HALT
    ;
    POP_SIGN2           ;*LABEL* --> USE WHEN THERE ARE BRACKETS
    AND R1,R1,#0
    LDR R2,R4,#0        ;TOP SIGN OF SIGN STRING
    
                        ;CHECK FOR BRACKETS
    ADD R1,R2,#-16
    ADD R1,R1,#-16
    ADD R1,R1,#-8       ;-40 --> '('
    BRz BRACKETS
    ;
    AND R1,R1,#0
    ADD R1,R2,#-16
    ADD R1,R1,#-16
    ADD R1,R1,#-9       ;-41 --> ')'
    BRz BRACKETS
    
                        ;IF THIS IS NOT BRACKETS THEN...   
    ADD R5,R5,#1        ;TOP RPN + 1
    STR R2,R5,#0        ;SAVE TO RPN STRING
    ADD R4,R4,#-1       ;TOP SIGN STRING -1
    ADD R3,R3,#-1       ;SIGN COUNT -1
    AND R1,R1,#0
    LDI R1,TEMP
    ADD R1,R1,#1        ;TOTAL CHARS +1
    STI R1,TEMP
    BRnzp CHECK_SIGN1
    HALT
    ;
    BRACKETS            ;*LABEL* --> NOT DISPLAY BRACKETS
    ADD R4,R4,#-1       ;TOP SIGN STRING -1
    ADD R3,R3,#-1       ;SIGN COUNT -1
    
    AND R1,R1,#0
    ADD R1,R2,#-16
    ADD R1,R1,#-16
    ADD R1,R1,#-8       ;-40 --> '('
    BRz INPUT           ;IF THIS IS '(' THEN MOVE ON TO GET NEW CHAR
    
    BRnzp POP_SIGN2
    HALT
    ;
    SPEC_CASE           ;*LABEL* --> SPECIAL CASE: / VS - AND - VS +
    AND R2,R2,#0        
    ADD R2,R0,#-16
    ADD R2,R2,#-16
    ADD	R2,R2,#-13      ;IF THE CURRENT SIGN = 45 (-)
    BRz POP_SIGN
    BRnzp SAVE_SIGN
    HALT
;////////////////////////////////////////////////////////////////////////////////////////
;DECLARE
    START_STRING    .FILL       X3FFF   ;STS    --> R6
    RPN_STRING      .FILL       X5FFF   ;RS     --> R5
    SIGN_STRING     .FILL       X4FFF   ;SIS    --> R4
    PN_STRING       .FILL       X8000   ;POLISH NOTATION
    TEMP            .FILL       X7000   ;NUMBER OF CHARS IN RPN STRING
    TEMP2	        .FILL       X6000   ;NUMBER OF CHARS IN PN STRING
    MESG1           .STRINGZ    "ENTER STRING:  "
    MESG2           .STRINGZ    "RPN FUNCTION: "
    MESG3           .STRINGZ    "   PN FUNCTION: "
    .END
