       IDENTIFICATION DIVISION.
       PROGRAM-ID. RITESH1.

       DATA DIVISION.
        01 NAME PIC A(10).
        01 CLS PIC 9(2).
        01 GENDER PIC A(5).
       PROCEDURE DIVISION.
           ACCEPT NAME.
           ACCEPT CLS.
           ACCEPT GENDER.
           DISPLAY 'NAME = ' NAME.
           DISPLAY 'CLASS = ' CLS.
           DISPLAY 'GENDER = ' GENDER.
           STOP RUN.
