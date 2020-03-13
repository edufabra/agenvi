       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulLlistatsCViatges.
         AUTHOR. Eduard-Fabra-Bori-/-Emilio-J.-Cendrero.

       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
           COPY S-FCATVI.CPY.
       DATA DIVISION.
         FILE SECTION.
           COPY FD-CATVI.CPY.

        WORKING-STORAGE SECTION.
         77 EstatCatalegViatges      PIC XX VALUE "00".
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
                 CatalegViatges.
         END DECLARATIVES.
        SEGUNDA SECTION.

        Principal.
           OPEN I-O CatalegViatges.
           IF EstatCatalegViatges NOT EQUAL "00"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! Fitxer Viatges NO existeix" BEEP LINE 11
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
           DISPLAY "CODI" LINE 4 POSITION 6
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "TITOL DEL VIATGE" LINE 4 POSITION 20
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           DISPLAY "MAJORISTA" LINE 4 POSITION 50
             CONTROL "FCOLOR=WHITE, BCOLOR=BLUE".
           PERFORM Llistar UNTIL FiFitxer = "SI".
           ACCEPT Tecla NO BEEP.
           PERFORM Sortir.

        Llistar.
           READ CatalegViatges NEXT RECORD,
              AT END MOVE "SI" TO FiFitxer.
           IF FiFitxer = "NO"
             DISPLAY CodiViatge LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 7 TO Columna
             DISPLAY Titol LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ADD 39 TO Columna
             DISPLAY Majorista LINE Fila POSITION Columna
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
           END-IF.
           MOVE 5 TO Columna.
           ADD 1 TO Fila.
           IF Fila = 17
             ACCEPT Tecla NO BEEP
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\LLISTATS.SCR 0 1 20 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE 6 TO Fila
             DISPLAY "CODI" LINE 4 POSITION 6
              CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "TITOL DEL VIATGE" LINE 4 POSITION 20
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
             DISPLAY "MAJORISTA" LINE 4 POSITION 50
               CONTROL "FCOLOR=WHITE, BCOLOR=BLUE"
           END-IF.

        Sortir.
           EXIT PROGRAM.

