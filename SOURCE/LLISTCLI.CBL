       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulLlistatsClients.
         AUTHOR. Eduard-Fabra-Bori-/-Emilio-J.-Cendrero.

       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
           COPY S-FCLIEN.CPY.
       DATA DIVISION.
         FILE SECTION.
           COPY FD-CLIEN.CPY.

        WORKING-STORAGE SECTION.
         77 EstatFitxerClients       PIC XX VALUE "00".
         77 FiFitxer                 PIC XX VALUE "NO".
         77 Fila                     PIC 99.
         77 Columna                  PIC 99.
         77 Tecla                    PIC X.
         77 Programa                 PIC X(50).
         77 Parametres               PIC X(50).
         77 Estat-Shell              PIC 9.
         77 Errorlevel               PIC 999.

       SCREEN SECTION.
       01 BORRADO BLANK SCREEN.

       01 NORMAL.
           02 VALUE " "
               FOREGROUND WHITE BACKGROUND BLACK.

       PROCEDURE DIVISION.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 FitxerClients.
         END DECLARATIVES.
        SEGUNDA SECTION.

        Principal.
           OPEN I-O FitxerClients.
           IF EstatFitxerClients NOT EQUAL "00"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! Fitxer Clients NO existeix" BEEP LINE 11
             POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             PERFORM Sortir
           END-IF.
           MOVE "NO" TO FiFitxer.
           MOVE 6 TO Fila.
           MOVE 8 TO Columna.
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 0 1 20 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\LLISTATS.SCR 0 1 20 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           DISPLAY "DNI" LINE 4 POSITION 12
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "NOM DEL CLIENT" LINE 4 POSITION 21
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY " CONNOM 1 DEL CLIENT" LINE 4 POSITION 43
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           PERFORM Llistar UNTIL FiFitxer = "SI".
           ACCEPT Tecla NO BEEP.
           PERFORM Sortir.

        Llistar.
           READ FitxerClients NEXT RECORD, AT END MOVE "SI" TO FiFitxer.
           IF FiFitxer NOT EQUAL "SI"
             DISPLAY Dni LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 11 TO Columna
             DISPLAY Nom LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 22 TO Columna
             DISPLAY Cnom1 LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
           END-IF.
           MOVE 8 TO Columna.
           ADD 1 TO Fila.
           IF Fila = 17
             ACCEPT Tecla NO BEEP
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\LLISTATS.SCR 3 3 23 77" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE 6 TO Fila
             DISPLAY "DNI" LINE 4 POSITION 12
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "NOM DEL CLIENT" LINE 4 POSITION 21
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY " CONNOM 1 DEL CLIENT" LINE 4 POSITION 43
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
           END-IF.

        Sortir.
           EXIT PROGRAM.
