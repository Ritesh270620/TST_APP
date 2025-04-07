       IDENTIFICATION DIVISION.
       PROGRAM-ID. RITESH.

       DATA DIVISION.
         01 CNT PIC 9(2) VALUE 0.
         01 STR PIC X(20).
         01 JDX PIC 9(2).
       PROCEDURE DIVISION.
           ACCEPT STR.
           PERFORM COUNTER.
           DISPLAY CNT.
           STOP RUN.
        COUNTER.
           PERFORM VARYING JDX FROM 1 BY 1 UNTIL JDX > 10
             IF STR(JDX:1) NOT = SPACE
                COMPUTE CNT = CNT + 1
             END-IF
           END-PERFORM.
