       IDENTIFICATION DIVISION.
        PROGRAM-ID. MantenimentRegistres-C-Viatges.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
           COPY S-FCATVI.CPY.

       DATA DIVISION.
         FILE SECTION.
           COPY FD-CATVI.CPY.

        WORKING-STORAGE SECTION.

        77 EstatCatalegViatges  PIC XX VALUE "00".
        77 Estat-Shell          PIC 9.
        77 Errorlevel           PIC 999.
        77 Parametres           PIC X(50).
        77 Programa             PIC X(50).
        77 Sortir               PIC XX VALUE "NO".
        77 Segur                PIC X VALUE "N".
        77 Tecla                PIC X.
        77 ED-CodiViatge        PIC ZZZZ9.
        77 ED-Titol             PIC X(37).
        77 ED-Continent         PIC X(20).
        77 ED-Majorista         PIC X(20).
        77 ED-Paisos            PIC X(30).
        77 ED-MediTransport     PIC XX.
        77 ED-RegimAllotjament  PIC XX.
        77 ED-TipusAllotjament  PIC XXX.
        77 ED-SuplementTempAlta PIC ZZZZ9.
        77 ED-MesIniTempAlta    PIC Z9.
        77 ED-MesFiTempAlta     PIC Z9.
        77 ED-DatesSortida      PIC X(31).
        77 ED-DuracioViatge     PIC ZZ9.
        77 ED-PlacesDisponibles PIC ZZZ9.
        77 ED-PreuPersona       PIC ZZZZZ9.
        77 ED-PathFotografia    PIC X(46).
        77 NumOpcions      PIC 9.
        77 Opc             PIC 9.
        77 OpcEscollida    PIC 9.
        77 Sortir          PIC XX VALUE "NO".

        01 Taula.
          02 Opcions OCCURS 5 PIC X(12).

        01 Taula2.
          02 Ajudes OCCURS 5 PIC X(60).

        SCREEN SECTION.
        01 R-CatalegViatges BACKGROUND IS WHITE FOREGROUND IS RED
            AUTO.
          02 LINE 6 COL 22 PIC ZZZZ9 USING ED-CodiViatge UNDERLINE
               JUST RIGHT.
          02 LINE 6 COL 35 PIC X(37) USING ED-Titol UNDERLINE
               JUST RIGHT.
          02 LINE 8 COL 20 PIC X(20) USING ED-Continent UNDERLINE
               JUST RIGHT.
          02 LINE 8 COL 52 PIC X(20) USING ED-Majorista UNDERLINE
               JUST RIGHT.
          02 LINE 10 COL 17 PIC X(30) USING ED-Paisos UNDERLINE
               JUST RIGHT.
          02 LINE 10 COL 64 PIC XX USING ED-MediTransport UNDERLINE
               JUST RIGHT.
          02 LINE 12 COL 30 PIC XX USING ED-RegimAllotjament UNDERLINE
               JUST RIGHT.
          02 LINE 12 COL 62 PIC XXX USING ED-TipusAllotjament UNDERLINE
               JUST RIGHT.
          02 LINE 14 COL 28 PIC ZZZZ9 USING ED-SuplementTempAlta
               UNDERLINE BLANK WHEN ZERO JUST RIGHT.
          02 LINE 14 COL 49 PIC Z9 USING ED-MesIniTempAlta UNDERLINE
               BLANK WHEN ZERO JUST RIGHT.
          02 LINE 14 COL 65 PIC Z9 USING ED-MesFiTempAlta UNDERLINE
               BLANK WHEN ZERO JUST RIGHT.
          02 LINE 16 COL 23 PIC X(31) USING ED-DatesSortida UNDERLINE
               JUST RIGHT.
          02 LINE 16 COL 64 PIC ZZ9 USING ED-DuracioViatge UNDERLINE
               BLANK WHEN ZERO JUST RIGHT.
          02 LINE 18 COL 29 PIC ZZZ9 USING ED-PlacesDisponibles
               UNDERLINE BLANK WHEN ZERO JUST RIGHT.
          02 LINE 18 COL 55 PIC ZZZZZ9 USING ED-PreuPersona UNDERLINE
               BLANK WHEN ZERO JUST RIGHT.
          02 LINE 20 COL 26 PIC X(46) USING ED-PathFotografia UNDERLINE
               JUST RIGHT.

        PROCEDURE DIVISION.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 CatalegViatges.
         END DECLARATIVES.
        SEGUNDA SECTION.

        PRINCIPAL.
           OPEN I-O CatalegViatges.
           IF EstatCatalegViatges NOT EQUAL "00"
             OPEN OUTPUT CatalegViatges
             CLOSE CatalegViatges
             OPEN I-O CatalegViatges
           END-IF.
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           DISPLAY "Introdueixi el Codi del Viatge: " LINE 11
           POSITION 10  CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           ACCEPT ED-CodiViatge LINE 11 POSITION 42 CONTROL
            "FCOLOR=GREY, BCOLOR=WHITE, PROMPT, UPPER" NO BEEP.
           MOVE ED-CodiViatge TO CodiViatge.
           READ CatalegViatges.
           PERFORM VisualitzarViatge.
           PERFORM Sortir.

        VisualitzarViatge.
           MOVE CodiViatge TO ED-CodiViatge.
           MOVE Titol TO ED-Titol.
           MOVE Continent TO ED-Continent.
           MOVE Majorista TO ED-Majorista.
           MOVE Paisos TO ED-Paisos.
           MOVE MediTransport TO ED-MediTransport.
           MOVE RegimAllotjament TO ED-RegimAllotjament.
           MOVE TipusAllotjament TO ED-TipusAllotjament.
           MOVE SuplementTempAlta TO ED-SuplementTempAlta.
           MOVE MesIniTempAlta TO ED-MesIniTempAlta.
           MOVE MesFiTempAlta TO ED-MesFiTempAlta.
           MOVE DatesSortida TO ED-DatesSortida.
           MOVE DuracioViatge TO ED-DuracioViatge.
           MOVE PlacesDisponibles TO ED-PlacesDisponibles.
           MOVE PreuPersona TO ED-PreuPersona.
           MOVE PathFotografia TO ED-PathFotografia.
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 2 4 21 74" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\VISVIAT.SCR 2 4 21 74" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           DISPLAY R-CatalegViatges.
           IF PathFotografia NOT EQUAL "           "
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 0 0 25 80" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "CSHOW\CSHOW.EXE" TO Programa
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa PathFotografia
             CANCEL "COBDOS\COBDOS.EXE"
             ACCEPT Tecla NO BEEP
             MOVE "&MODE CO80" TO Programa
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "&MODE CO80" TO Programa
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 0 0 25 80" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\VISVIAT.SCR 2 4 21 74" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY R-CatalegViatges
           END-IF.
           ACCEPT R-CatalegViatges.
           IF ED-CodiViatge NOT EQUAL "    0"
             MOVE ED-CodiViatge TO CodiViatge
             MOVE ED-Titol TO Titol
             MOVE ED-Continent TO Continent
             MOVE ED-Majorista TO Majorista
             MOVE ED-Paisos TO Paisos
             PERFORM ValidarMediTransport
             MOVE ED-MediTransport TO MediTransport
             PERFORM ValidarRegimAllotjament
             MOVE ED-RegimAllotjament TO RegimAllotjament
             PERFORM ValidarTipusAllotjament
             MOVE ED-TipusAllotjament TO TipusAllotjament
             MOVE ED-SuplementTempAlta TO SuplementTempAlta
             MOVE ED-MesIniTempAlta TO MesIniTempAlta
             MOVE ED-MesFiTempAlta TO MesFiTempAlta
             MOVE ED-DatesSortida TO DatesSortida
             MOVE ED-DuracioViatge TO DuracioViatge
             MOVE ED-PlacesDisponibles TO PlacesDisponibles
             MOVE ED-PreuPersona TO PreuPersona
             MOVE ED-PathFotografia TO PathFotografia
             WRITE RegistreCatalegViatges INVALID KEY
               REWRITE RegistreCatalegViatges.
           IF ED-CodiViatge = "    0"
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
             DISPLAY " Desitja realment borrar el registre (S/N) ? "
               LINE 11 POSITION 17 CONTROL "FCOLOR=RED, BCOLOR=WHITE"
               BEEP
             MOVE "N" TO Segur
             ACCEPT Segur LINE 11 POSITION 62
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             IF Segur = "S" OR Segur = "s" PERFORM BorrarViatge
           END-IF.

        BorrarViatge.
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
             Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
             Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".
           DISPLAY "Viatge NO BORRAT" BEEP LINE 11
           POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           ACCEPT Tecla NO BEEP.
           DELETE CatalegViatges RECORD.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
             Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".

        ValidarMediTransport.
           IF ED-MediTransport NOT EQUAL "VA" AND ED-MediTransport
           NOT EQUAL "AV" AND ED-MediTransport NOT EQUAL "AU" AND
           ED-MediTransport NOT EQUAL "TR" THEN
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! MEDI TRANSPORT NO RECONEGUT" BEEP
               LINE 11 POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE 4 TO Numopcions
             MOVE 0 TO OpcEscollida
             MOVE 1 TO Opc
             MOVE "VA." TO Opcions(1)
             MOVE "AV." TO Opcions(2)
             MOVE "AU." TO Opcions(3)
             MOVE "TR." TO Opcions(4)
             MOVE "Transport en VAIXELL." TO Ajudes (1)
             MOVE "Transport en AVIO." TO Ajudes(2)
             MOVE "Transport en AUTOCAR." TO Ajudes(3)
             MOVE "Transport en TREN." TO Ajudes(4)
             PERFORM ProcesMediTransport
           END-IF.

        ProcesMediTransport.
           CALL "GESTECLA.COB"
             USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
           CANCEL "GESTECLA.COB"
           PERFORM EvaluarMediTransport.

        EvaluarMediTransport.
           EVALUATE OpcEscollida
             WHEN 1 MOVE "VA" TO  ED-MediTransport
             WHEN 2 MOVE "AV" TO  ED-MediTransport
             WHEN 3 MOVE "AU" TO  ED-MediTransport
             WHEN 4 MOVE "TR" TO  ED-MediTransport
           END-EVALUATE.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".

        ValidarRegimAllotjament.
           IF ED-RegimAllotjament NOT EQUAL "PC" AND ED-RegimAllotjament
           NOT EQUAL "MP" AND ED-RegimAllotjament NOT EQUAL "AD" THEN
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! REGIM ALLOTJAMENT NO RECONEGUT" BEEP
               LINE 11 POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE 3 TO Numopcions
             MOVE 0 TO OpcEscollida
             MOVE 1 TO Opc
             MOVE "PC." TO Opcions(1)
             MOVE "MP." TO Opcions(2)
             MOVE "AD." TO Opcions(3)
             MOVE "PENSIO COMPLERTA." TO Ajudes (1)
             MOVE "MITJA PENSIO." TO Ajudes(2)
             MOVE "ALLOTJAMENT I DESDEJUNY." TO Ajudes(3)
             PERFORM ProcesRegimAllotjament
           END-IF.

        ProcesRegimAllotjament.
           CALL "GESTECLA.COB"
             USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
           CANCEL "GESTECLA.COB"
           PERFORM EvaluarRegimAllotjament.

        EvaluarRegimAllotjament.
           EVALUATE OpcEscollida
             WHEN 1 MOVE "PC" TO  ED-RegimAllotjament
             WHEN 2 MOVE "MP" TO  ED-RegimAllotjament
             WHEN 3 MOVE "AD" TO  ED-RegimAllotjament
           END-EVALUATE.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".

        ValidarTipusAllotjament.
           IF ED-TipusAllotjament NOT EQUAL "HOT" AND
           ED-TipusAllotjament NOT EQUAL "APH" AND ED-TipusAllotjament
           NOT EQUAL "APT" AND ED-TipusAllotjament NOT EQUAL "CPG" THEN
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             DISPLAY "ERROR!!! TIPUS ALLOTJAMENT NO RECONEGUT" BEEP
               LINE 11 POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
             ACCEPT Tecla NO BEEP
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "DEFAULT2.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE 4 TO Numopcions
             MOVE 0 TO OpcEscollida
             MOVE 1 TO Opc
             MOVE "HOT." TO Opcions(1)
             MOVE "APT." TO Opcions(2)
             MOVE "APH." TO Opcions(3)
             MOVE "CPG." TO Opcions(4)
             MOVE "Allotjament en HOTEL." TO Ajudes (1)
             MOVE "Allotjament en APARTAMENT." TO Ajudes(2)
             MOVE "Allotjament en APARTHOTEL." TO Ajudes(3)
             MOVE "Allotjament en CAMPING." TO Ajudes(4)
             PERFORM ProcesTipusAllotjament
           END-IF.

        ProcesTipusAllotjament.
           CALL "GESTECLA.COB"
             USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
           CANCEL "GESTECLA.COB"
           PERFORM EvaluarTipusAllotjament.

        EvaluarTipusAllotjament.
           EVALUATE OpcEscollida
             WHEN 1 MOVE "HOT" TO  ED-TipusAllotjament
             WHEN 2 MOVE "APT" TO  ED-TipusAllotjament
             WHEN 3 MOVE "APH" TO  ED-TipusAllotjament
             WHEN 4 MOVE "CPG" TO  ED-TipusAllotjament
           END-EVALUATE.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 5 0 19 80" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".

        Sortir.
           EXIT PROGRAM.

