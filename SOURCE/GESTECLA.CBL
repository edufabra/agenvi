       IDENTIFICATION DIVISION.
         PROGRAM-ID. GESTECLA.
         AUTHOR. EDUARD-FABRA-BORI.

       ENVIRONMENT DIVISION.
        CONFIGURATION SECTION.
         SOURCE-COMPUTER. IBM-PC.
         OBJECT-COMPUTER. IBM-PC.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       77 CODEKEY        PIC 99.
       77 I              PIC 99.
       77 J              PIC 99.
       77 C              PIC 99.
       77 Tecla          PIC X.
       77 Programa       PIC X(50).
       77 Parametres     PIC X(50).
       77 Estat-Shell    PIC 9.
       77 Errorlevel     PIC 999.

       LINKAGE SECTION.

       01 TABLA.
         02 OPCIONES OCCURS 5 PIC X(12).

       01 TABLA-2.
         02 AYUDAS OCCURS 5 PIC X(60).

       77 NUMOPCIONES    PIC 9.
       77 OPC            PIC 9.
       77 OPES           PIC 9.

       SCREEN SECTION.
       01 BORRADO BLANK SCREEN.

       01 NORMAL.
           02 VALUE " "
               FOREGROUND WHITE BACKGROUND BLACK.

       01 BORRAR.
          02 VALUE
       "                                                             "
             LINE 17 COL 6 FOREGROUND GREY BACKGROUND WHITE.

       PROCEDURE DIVISION USING TABLA, TABLA-2,
                     NUMOPCIONES, OPC, OPES.

       INICIO.
           DISPLAY NORMAL.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\MENU.SCR 5 0 18 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           PERFORM PROCESO.
           PERFORM UNTIL ((CODEKEY = 27) OR (CODEKEY = 13))
               ACCEPT TECLA LINE 23 POSITION 60 NO BEEP
                     ON EXCEPTION CODEKEY PERFORM EVALUAR
               END-ACCEPT
               IF CODEKEY = 13 PERFORM DECIDIR END-IF
           END-PERFORM.
           PERFORM SALIR.

       PROCESO.
           DISPLAY NORMAL.
           MOVE 1 TO I.
           PERFORM IMPRIMIR-OPCIONES VARYING I FROM 1 BY 1
                   UNTIL (I = NUMOPCIONES + 1).
           MOVE 1 TO J.
           COMPUTE J = 10 + OPC.
           DISPLAY OPCIONES (OPC) LINE J POSITION 35
              CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (OPC) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".

       IMPRIMIR-OPCIONES.
           COMPUTE J = 10 + I.
           DISPLAY OPCIONES (I) LINE J POSITION 35
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (I) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".

       EVALUAR.
               EVALUATE CODEKEY
                WHEN 13 PERFORM DECIDIR
                WHEN 53 PERFORM SUBE
                WHEN 52 PERFORM BAJA
                WHEN 27 MOVE 0 TO OPES
               END-EVALUATE.

       SUBE.
           MOVE 1 TO C.
           MOVE 1 TO J.
           MOVE OPC TO C.
           COMPUTE OPC = OPC + 1.
           IF OPC < 1 MOVE NUMOPCIONES TO OPC.
           IF OPC > NUMOPCIONES MOVE 1 TO OPC.
           COMPUTE J = 10 + C.
           DISPLAY OPCIONES (C) LINE J POSITION 35
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (C) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           MOVE 1 TO J.
           COMPUTE J = 10 + OPC.
           DISPLAY OPCIONES (OPC) LINE J POSITION 35
              CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (OPC) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".

       BAJA.
           MOVE 1 TO C.
           MOVE 1 TO J.
           MOVE OPC TO C.
           COMPUTE OPC = OPC - 1.
           IF OPC < 1 MOVE NUMOPCIONES TO OPC.
           IF OPC > NUMOPCIONES MOVE 1 TO OPC.
           COMPUTE J = 10 + C.
           DISPLAY OPCIONES (C) LINE J POSITION 35
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (C) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           MOVE 1 TO J.
           COMPUTE J = 10 + OPC.
           DISPLAY OPCIONES (OPC) LINE J POSITION 35
              CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY BORRAR.
           DISPLAY AYUDAS (OPC) LINE 17 POSITION 6
              CONTROL "FCOLOR=GREY, BCOLOR=WHITE".

       DECIDIR.
           MOVE OPC TO OPES.
           PERFORM SALIR.

       SALIR.
           DISPLAY NORMAL.
           EXIT PROGRAM.
