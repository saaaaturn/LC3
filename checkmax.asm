; Register usage:
; R0: maximum value
; R1: input1
; R2: input2
; R3: input3
.ORIG X3000
START
    ; Load inputs into registers
    LD R1, INPUT1
    LD R2, INPUT2
    LD R3, INPUT3

    ; Compare input1 and input2
    NOT R1, R1
    NOT R2, R2
    ADD R1, R1, R2
    BRn MAX_INPUT2

    ; input1 > input2, compare input1 and input3
    NOT R1, R1
    NOT R3, R3
    ADD R1, R1, R3
    BRn MAX_INPUT3

    ; input1 > input2 > input3, R0 = input1
    LD R0, INPUT1
    HALT

MAX_INPUT2
    ; input2 > input1, compare input2 and input3
    NOT R2, R2
    NOT R3, R3
    ADD R2, R2, R3
    BRn MAX_INPUT3

    ; input2 > input1 > input3, R0 = input2
    LD R0, INPUT2
    HALT

MAX_INPUT3
    ; input3 > input1 > input2, R0 = input3
    LD R0, INPUT3
    HALT

INPUT1 .FILL 5
INPUT2 .FILL 10
INPUT3 .FILL 7
.END