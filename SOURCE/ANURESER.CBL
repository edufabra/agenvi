       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulAnulaReserves.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
            COPY S-FRESER.CPY.
            COPY S-FCATVI.CPY.
       DATA DIVISION.
        FILE SECTION.
          COPY FD-RESER.CPY.
          COPY FD-CATVI.CPY.

        WORKING-STORAGE SECTION.
         77 EstatFitxerReserves      PIC XX VALUE "00".
         77 EstatCatalegViatges      PIC XX VALUE "00".
         77 Tecla                    PIC X.
         77 Programa                 PIC X(50).
         77 Parametres               PIC X(50).
         77 Estat-Shell              PIC 9.
         77 Errorlevel               PIC 999.
         77 Segur                    PIC X VALUE "N".

       SCREEN SECTION.
       01 BORRADO BLANK SCREEN.

       01 NORMAL.
           02 VALUE " "
               FOREGROUND WHITE BACKGROUND BLACK.

       PROCEDURE DIVISION.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 FitxerReserves, CatalegViatges.
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
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 4 5 17 73" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
               Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\ANULRES.SCR 4 5 17 73" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
               Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".
           ACCEPT DniReserva LINE 9 POSITION 45 NO BEEP
             CONTROL "FCOLOR=GREY, BCOLOR=WHITE, UPPER, PROMPT".
           ACCEPT CodiViatgeReservat LINE 11 POSITION 52 NO BEEP
             CONTROL "FCOLOR=GREY, BCOLOR=WHITE, UPPER, PROMPT".
           READ FitxerReserves.
           IF EstatFitxerReserves = "23"
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! Reserva NO existeix" BEEP LINE 11
             POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
           END-IF.
           IF EstatFitxerReserves NOT EQUAL "23"
             ACCEPT Segur LINE 13 POSITION 51 NO BEEP
               CONTROL "FCOLOR=GREY, BCOLOR=WHITE, UPPER, PROMPT"
             PERFORM Anul-larReserva
             END-IF.

        Anul-larReserva.
           IF Segur = "s" or Segur = "S"
             MOVE CodiViatgeReservat TO CodiViatge
             READ CatalegViatges
             COMPUTE PlacesDisponibles = PlacesDisponibles +
               PlacesReservades
             REWRITE RegistreCatalegViatges
             DELETE FitxerReserves RECORD
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
               Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
               Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "Reserva ANNUL-LADA Satisfactoriament" BEEP
             LINE 11 POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             PERFORM Sortir
           END-IF.

        Sortir.
           EXIT PROGRAM.
