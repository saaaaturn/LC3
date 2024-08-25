.ORIG x3000         ; Start of the program

; Main program
LEA R0, Prompt1     ; Load the address of the first prompt
PUTS                ; Display the first prompt
GETC                ; Get the first number
OUT                 ; Echo the character
LD R4, ASCII_ZERO   ; Load ASCII value of '0'
NOT R4, R4          ; Invert R4
ADD R4, R4, #1      ; Two's complement to subtract ASCII '0'
ADD R2, R0, R4      ; R2 = R0 - '0' (Convert ASCII to integer)

LEA R0, Prompt2     ; Load the address of the second prompt
PUTS                ; Display the second prompt
GETC                ; Get the second number
OUT                 ; Echo the character
ADD R3, R0, R4      ; R3 = R0 - '0' (Convert ASCII to integer)

JSR AddSub          ; Jump to subroutine for addition

LEA R0, ResultPrompt; Load the result prompt
PUTS                ; Display result prompt
ADD R0, R1, #15     ; Convert sum back to ASCII
ADD R0, R0, #15     ; Convert sum back to ASCII
ADD R0, R0, #15     ; Convert sum back to ASCII
ADD R0, R0, #3     ; Convert sum back to ASCII
OUT                 ; Display the result
HALT                ; End of the program

; Subroutine to add two numbers
AddSub
ADD R1, R2, R3   ; R1 = R2 + R3
RET             ; Return from subroutine

; Data / Strings
Prompt1: .STRINGZ "\nInput the first number (0-9): "
Prompt2: .STRINGZ "\nInput the second number (0-9): "
ResultPrompt: .STRINGZ "\nResult: "
ASCII_ZERO: .FILL x0030 ; ASCII value for '0'

.end                ; End of the program

