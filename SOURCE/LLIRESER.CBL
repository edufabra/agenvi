       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulLlistatsReserves.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
            COPY S-FRESER.CPY.
       DATA DIVISION.
        FILE SECTION.
          COPY FD-RESER.CPY.

        WORKING-STORAGE SECTION.
         77 EstatFitxerReserves      PIC XX VALUE "00".
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
                 FitxerReserves.
         END DECLARATIVES.
        SEGUNDA SECTION.

        Principal.
           OPEN I-O FitxerReserves.
           IF EstatFitxerReserves NOT EQUAL "00"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! Fitxer Reserves NO existeix" BEEP LINE 11
             POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             PERFORM Sortir
           END-IF.
           MOVE "NO" TO FiFitxer.
           MOVE 6 TO Fila.
           MOVE 5 TO Columna.
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
           DISPLAY "DNI" LINE 4 POSITION 8
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "CODI V." LINE 4 POSITION 17
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "DIA SORTIDA" LINE 4 POSITION 25
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "PLACES" LINE 4 POSITION 38
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "PREU TOTAL" LINE 4 POSITION 47
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           PERFORM Llistar UNTIL FiFitxer = "SI".
           ACCEPT Tecla NO BEEP.
           PERFORM Sortir.

        Llistar.
           READ FitxerReserves NEXT RECORD, AT END MOVE
             "SI" TO FiFitxer.
           IF FiFitxer NOT EQUAL "SI"
             DISPLAY DniReserva LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 12 TO Columna
             DISPLAY CodiViatgeReservat LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 8 TO Columna
             DISPLAY DiaSortida LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 14 TO Columna
             DISPLAY PlacesReservades LINE Fila Position Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 9 TO Columna
             DISPLAY PreuTotalReserva LINE Fila Position Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
           END-IF.
           MOVE 5 TO Columna.
           ADD 1 TO Fila.
           IF Fila = 17
             ACCEPT Tecla NO BEEP
             MOVE 6 TO Fila
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\LLISTATS.SCR 0 1 20 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "DNI" LINE 4 POSITION 8
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "CODI V." LINE 4 POSITION 17
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "DIA SORTIDA" LINE 4 POSITION 25
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "PLACES" LINE 4 POSITION 38
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "PREU TOTAL" LINE 4 POSITION 47
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
           END-IF.

        Sortir.
           EXIT PROGRAM.
