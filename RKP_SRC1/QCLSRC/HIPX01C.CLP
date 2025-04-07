/*   Program Title : Retrive Error Message                           */
/*   Program Name  : HIPX01C                                         */
/*   Functions     : Retrive error message description               */
/*                   from HIPERR file.                               */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*   Received External Areas :                                       */
/*                                                                   */
/*     Data Areas    - None                                          */
/*     Data Queues   - None                                          */
/*     User Switches - None                                          */
/*     Parameters    - &P_ERRNO                                      */
/*-------------------------------------------------------------------*/
/*   Passed External Data  :                                         */
/*                                                                   */
/*     Data Areas    - None                                          */
/*     Data Queues   - None                                          */
/*     User switches - None                                          */
/*     Parameters    - &P_ERRDES                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*   External Programs  :                                            */
/*                                                                   */
/*     Program  -                                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*   Display Files :  None                                           */
/*                                                                   */
/*     File Name     -                                               */
/*     Record format -                                               */
/*                                                                   */
/*-------------------------------------------------------------------*/
/*   Revision History :                                              */
/*   R001  JSL 20051018  TCS Project                                 */
/*********************************************************************/
/*  Program Start                                                    */

             PGM        PARM(&P_ERRNO &P_ERRDES)

/*  Variables Declaration                                            */
             DCL        VAR(&P_ERRNO)  TYPE(*CHAR) LEN(7)
             DCL        VAR(&P_ERRDES) TYPE(*CHAR) LEN(250)

/*  Standard Error Handler Declaration                               */

             DCL        VAR(&WK_DBID) TYPE(*CHAR) LEN(1)
             DCL        VAR(&WK_PASS) TYPE(*CHAR) LEN(1) VALUE('Y')
             DCL        VAR(&WK_SENDER) TYPE(*CHAR) LEN(720)
             DCL        VAR(&WK_MSGID) TYPE(*CHAR) LEN(7)
             DCL        VAR(&WK_TIME) TYPE(*CHAR) LEN(8)
             DCL        VAR(&WK_ERRMSG) TYPE(*CHAR) LEN(250)
             DCL        VAR(&WK_MSGDTA) TYPE(*CHAR) LEN(250)
             DCL        VAR(&WK_PGNM) TYPE(*CHAR) LEN(10)
             DCL        VAR(&WK_MSGF) TYPE(*CHAR) LEN(10) +
                          VALUE('HIPERR')
             DCL        VAR(&WK_MSGFL) TYPE(*CHAR) LEN(10)
             DCL        VAR(&WK_MSGFLIB) TYPE(*CHAR) LEN(10)

             MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR))

             RTVMSG     MSGID(&P_ERRNO) MSGF(HIPERR) MSG(&P_ERRDES)


             GOTO       CMDLBL(EXIT)

/*  Error Handler Segment                                            */

 ERROR:      IF         COND(&WK_PASS *NE 'Y') THEN(DO)
             DMPCLPGM
             MONMSG     MSGID(CPF0000)
             SNDPGMMSG  MSGID(CPF9999) MSGF(QCPFMSG) MSGTYPE(*ESCAPE)
             ENDDO

             CHGVAR     VAR(&WK_PASS) VALUE('N')

/*  Get time                                                         */

             RTVSYSVAL  SYSVAL(QTIME) RTNVAR(&WK_TIME)

/*  Trap escape message                                              */

             RCVMSG     MSGTYPE(*LAST) MSG(&WK_ERRMSG) +
                          MSGDTA(&WK_MSGDTA) MSGID(&WK_MSGID) +
                          SENDER(&WK_SENDER) MSGF(&WK_MSGFL) +
                          SNDMSGFLIB(&WK_MSGFLIB)

/*  Construct program name                                           */

             CHGVAR     VAR(&WK_PGNM) VALUE(%SST(&WK_SENDER 56 10))

/*  Information message to operator                                  */

             SNDPGMMSG  MSGID(OPT1815) MSGF(QCPFMSGF) +
                          MSGDTA(&WK_PGNM *CAT &WK_DBID *BCAT +
                          &WK_ERRMSG) TOMSGQ(*SYSOPR) MSGTYPE(*INFO)

/*  Escape message                                                   */

             SNDPGMMSG  MSGID(&WK_MSGID) MSGF(&WK_MSGFL) +
                          MSGDTA(&WK_MSGDTA) TOMSGQ(*TOPGMQ) +
                          MSGTYPE(*ESCAPE)

/*  End of Program                                                   */

 EXIT:       RETURN
             ENDPGM


