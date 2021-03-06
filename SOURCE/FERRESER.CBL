       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulFerReserves.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
            COPY S-FRESER.CPY.
            COPY S-FCLIEN.CPY.
            COPY S-FCATVI.CPY.
       DATA DIVISION.
        FILE SECTION.
          COPY FD-RESER.CPY.
          COPY FD-CLIEN.CPY.
          COPY FD-CATVI.CPY.

        WORKING-STORAGE SECTION.
         77 EstatFitxerClients       PIC XX VALUE "00".
         77 EstatFitxerReserves      PIC XX VALUE "00".
         77 EstatCatalegViatges      PIC XX VALUE "00".
         77 Tecla                    PIC X.
         77 Codi                     PIC 9(5).
         77 Programa                 PIC X(50).
         77 Parametres               PIC X(50).
         77 Estat-Shell              PIC 9.
         77 Errorlevel               PIC 999.
         77 Correcte                 PIC XX VALUE "NO".
         77 HabIndividual            PIC XX VALUE "NO".
         77 Comptador1               PIC 99 VALUE 0.
         77 Dia                      PIC 99.
         77 MesNumeric               PIC 99.
         77 Comptador                PIC 99 VALUE 0.
         77 Mes                      PIC X(3).
         77 TotalSuplement           PIC 9(7) VALUE 0.
         77 TotalReserva             PIC 9(7) VALUE 0.

         01 TaulaM.
           02 FILLER PIC X(3) VALUE "GEN".
           02 FILLER PIC X(3) VALUE "FEB".
           02 FILLER PIC X(3) VALUE "MAR".
           02 FILLER PIC X(3) VALUE "ABR".
           02 FILLER PIC X(3) VALUE "MAI".
           02 FILLER PIC X(3) VALUE "JUN".
           02 FILLER PIC X(3) VALUE "JUL".
           02 FILLER PIC X(3) VALUE "AGO".
           02 FILLER PIC X(3) VALUE "SET".
           02 FILLER PIC X(3) VALUE "OCT".
           02 FILLER PIC X(3) VALUE "NOV".
           02 FILLER PIC X(3) VALUE "DES".

         01 TaulaMesos REDEFINES TaulaM.
           02 Mesos OCCURS 12 TIMES PIC X(3).

       SCREEN SECTION.
       01 BORRADO BLANK SCREEN.

       01 NORMAL.
           02 VALUE " "
               FOREGROUND WHITE BACKGROUND BLACK.

       PROCEDURE DIVISION.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 FitxerClients, FitxerReserves, CatalegViatges.
         END DECLARATIVES.
        SEGUNDA SECTION.

        Formalitzar.
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
           OPEN I-O FitxerReserves.
           IF EstatFitxerReserves NOT EQUAL "00"
             OPEN OUTPUT FitxerReserves
             CLOSE FitxerReserves
             OPEN I-O FitxerReserves
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
           MOVE "DEFAULT.SCR 2 0 23 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\RESERV.SCR 2 0 23 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "NO" TO Correcte.
           PERFORM ControlarClient UNTIL Correcte = "SI".
           ACCEPT CodiViatge LINE 12 POSITION 69 CONTROL "PROMPT, UPPER"
             NO BEEP.
           READ CatalegViatges.
           MOVE 0 TO Codi.
           IF EstatCatalegViatges = "23"
             CALL "BROWSEV.COB" USING Codi
             CANCEL "BROWSEV.COB"
           END-IF.
           PERFORM RealitzarReserva.
           PERFORM Sortir.

        ControlarClient.
           ACCEPT Dni LINE 12 POSITION 25 NO BEEP
             CONTROL "FCOLOR=GREY, BCOLOR=WHITE, UPPER, PROMPT"
           READ FitxerClients.
           IF EstatFitxerClients = "23"
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! CLIENT NO DONAT D'ALTA" BEEP LINE 11
               POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "NO" TO Correcte
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
           END-IF.
           IF EstatFitxerClients NOT EQUAL "23" MOVE "SI" TO Correcte.

        RealitzarReserva.
           MOVE Dni TO DniReserva.
           IF CodiViatge = 0
             MOVE Codi TO CodiViatge
           END-IF.
           IF Codi = 0
             MOVE CodiViatge TO Codi
           END-IF.
           MOVE Codi TO CodiViatgeReservat.
           DISPLAY Codi LINE 12 POSITION 69
             CONTROL "FCOLOR=GREY BCOLOR=WHITE".
           READ CatalegViatges.
           IF PlacesDisponibles = 0
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! NO HI HA PLACES DISPONIBLES" BEEP
               LINE 11 POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             PERFORM Sortir
           END-IF.
           MOVE "NO" TO Correcte.
           PERFORM ComprobarDiaSortida UNTIL Correcte = "SI".
           MOVE "NO" TO Correcte.
           PERFORM ComprobarPlaces UNTIL Correcte = "SI".
           DISPLAY HabIndividual LINE 16 POSITION 32
             CONTROL "FCOLOR=GREY BCOLOR=WHITE".
           MOVE "NO" TO Correcte.
           PERFORM ComprobarIndividual UNTIL Correcte = "SI".
           IF HabIndividual = "SI" OR HabIndividual = "si"
             PERFORM EscriureSuplementHI.
           PERFORM IdentificarTempAlta.
           COMPUTE TotalReserva = TotalSuplement + (PreuPersona *
             PlacesReservades).
           DISPLAY TotalReserva LINE 20 POSITION 27
             CONTROL "FCOLOR=GREY BCOLOR=WHITE".
           MOVE TotalReserva TO PreuTotalReserva.
           WRITE Reserva.
           ACCEPT Tecla NO BEEP.

        IdentificarTempAlta.
           PERFORM AdivinarMes VARYING Comptador FROM 1 BY 1 UNTIL
             Comptador = 12.
           IF MesNumeric = MesIniTempAlta OR
              MesNumeric > MesFiTempAlta  AND
              MesNumeric = MesFiTempAlta  OR
              MesNumeric < MesFiTempAlta  PERFORM EscriureSuplement.

        AdivinarMes.
           IF Mesos (Comptador) = Mes THEN MOVE Comptador TO MesNumeric.

        EscriureSuplementHI.
           IF HabIndividual = "SI" OR HabIndividual = "si"
             DISPLAY " Hab. Individual = 25000" LINE 18 POSITION 10
               CONTROL "FCOLOR=GREY BCOLOR=WHITE"
             COMPUTE TotalSuplement = PlacesReservades * 25000
           END-IF.

        EscriureSuplement.
           DISPLAY " Temporada Alta = " LINE 18 POSITION 35
             CONTROL "FCOLOR=GREY BCOLOR=WHITE".
           DISPLAY SuplementTempAlta LINE 18 POSITION 53
             CONTROL "FCOLOR=GREY BCOLOR=WHITE".
           COMPUTE TotalSuplement = TotalSuplement + (PlacesReservades
             * SuplementTempAlta).

        ComprobarDiaSortida.
           MOVE 0 TO Comptador.
           ACCEPT DiaSortida LINE 14 POSITION 23
             CONTROL "FCOLOR=GREY, BCOLOR=WHITE, UPPER" NO BEEP.
           UNSTRING DiaSortida DELIMITED BY SPACE INTO DIA MES.
           INSPECT DatesSortida TALLYING Comptador FOR ALL Dia.
           IF Comptador = 0
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! DATA DE SORTIDA NO RECONEGUDA" BEEP
               LINE 9 POSITION 15 CONTROL "FCOLOR=GREY, BCOLOR=BLUE"
             DISPLAY DatesSortida LINE 11 POSITION 10 CONTROL
               "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "NO" TO Correcte
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
           END-IF.
           MOVE 0 TO Comptador1.
           INSPECT DatesSortida TALLYING Comptador1 FOR ALL Mes.
           IF Comptador1 = 0 AND Comptador > 0
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 13 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! DATA DE SORTIDA NO RECONEGUDA" BEEP
               LINE 9 POSITION 15 CONTROL "FCOLOR=GREY, BCOLOR=BLUE"
             DISPLAY "Dates de Sortida: " LINE 11 POSITION 10 CONTROL
               "FCOLOR=GREY, BCOLOR=WHITE"
             DISPLAY DatesSortida LINE 11 POSITION 29 CONTROL
               "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "NO" TO Correcte
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "NO" TO Correcte
           END-IF.
           IF Comptador > 0 AND Comptador1 > 0 MOVE "SI" TO Correcte.

        ComprobarIndividual.
           ACCEPT HabIndividual LINE 16 POSITION 32
             CONTROL "FCOLOR=GREY BCOLOR=WHITE" NO BEEP.
           IF HabIndividual = "SI" OR HabIndividual = "NO" OR
              HabIndividual = "si" OR HabIndividual = "no"
             MOVE "SI" TO Correcte
           END-IF.

        ComprobarPlaces.
           ACCEPT PlacesReservades LINE 14 POSITION 66
             CONTROL "FCOLOR=GREY BCOLOR=WHITE" NO BEEP.
           IF PlacesReservades > PlacesDisponibles AND PlacesReservades
           = 0
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! NOMBRE DE PLACES NO DISPONIBLE" BEEP
               LINE 9 POSITION 15 CONTROL "FCOLOR=GREY, BCOLOR=BLUE"
             DISPLAY "Places Disponibles: " LINE 11 POSITION 10 CONTROL
               "FCOLOR=GREY, BCOLOR=WHITE"
             DISPLAY PlacesDisponibles LINE 11 POSITION 31 CONTROL
               "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "NO" TO Correcte
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
           END-IF.
           IF PlacesReservades < PlacesDisponibles AND PlacesReservades
           NOT EQUAL 0
             COMPUTE PlacesDisponibles = PlacesDisponibles -
               PlacesReservades
             REWRITE RegistreCatalegViatges
             MOVE "SI" TO Correcte
           END-IF.

        Sortir.
           CLOSE FitxerClients.
           CLOSE CatalegViatges.
           Close FitxerReserves.
           EXIT PROGRAM.
