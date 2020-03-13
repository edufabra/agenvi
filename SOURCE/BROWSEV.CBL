       IDENTIFICATION DIVISION.
        PROGRAM-ID. VisualitzaRegistres-C-Viatges.
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
        77 Codekey              PIC 99.
        77 Tecla                PIC X.
        77 Segur                PIC X VALUE "N".
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

        LINKAGE SECTION.
        77 Codi                 PIC 9(5).

        SCREEN SECTION.
        01 R-CatalegViatges BACKGROUND IS WHITE FOREGROUND IS RED
            AUTO.
          02 LINE 6 COL 22 PIC ZZZZ9 USING ED-CodiViatge UNDERLINE.
          02 LINE 6 COL 35 PIC X(37) USING ED-Titol UNDERLINE.
          02 LINE 8 COL 20 PIC X(20) USING ED-Continent UNDERLINE.
          02 LINE 8 COL 52 PIC X(20) USING ED-Majorista UNDERLINE.
          02 LINE 10 COL 17 PIC X(30) USING ED-Paisos UNDERLINE.
          02 LINE 10 COL 64 PIC XX USING ED-MediTransport UNDERLINE.
          02 LINE 12 COL 30 PIC XX USING ED-RegimAllotjament UNDERLINE.
          02 LINE 12 COL 62 PIC XXX USING ED-TipusAllotjament UNDERLINE.
          02 LINE 14 COL 28 PIC ZZZZ9 USING ED-SuplementTempAlta
               UNDERLINE.
          02 LINE 14 COL 49 PIC Z9 USING ED-MesIniTempAlta UNDERLINE.
          02 LINE 14 COL 65 PIC Z9 USING ED-MesFiTempAlta UNDERLINE.
          02 LINE 16 COL 23 PIC X(31) USING ED-DatesSortida UNDERLINE.
          02 LINE 16 COL 64 PIC ZZ9 USING ED-DuracioViatge UNDERLINE.
          02 LINE 18 COL 29 PIC ZZZ9 USING ED-PlacesDisponibles
               UNDERLINE.
          02 LINE 18 COL 55 PIC ZZZZZ9 USING ED-PreuPersona UNDERLINE.
          02 LINE 20 COL 26 PIC X(46) USING ED-PathFotografia UNDERLINE.

        PROCEDURE DIVISION USING Codi.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 CatalegViatges.
         END DECLARATIVES.
        SEGUNDA SECTION.

        PRINCIPAL.
           OPEN I-O CatalegViatges.
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
           PERFORM Visualitzar.
           PERFORM Proces.
           PERFORM Sortir.

        Proces.
           PERFORM UNTIL ((Codekey = 27) OR (Codekey = 13))
               ACCEPT Tecla LINE 23 POSITION 60 NO BEEP
                     ON EXCEPTION Codekey PERFORM Evaluar
               END-ACCEPT
               IF Codekey = 13 OR Codekey = 27 PERFORM Decidir END-IF
           END-PERFORM.

        Evaluar.
           EVALUATE CODEKEY
             WHEN 13 PERFORM Decidir
             WHEN 53 PERFORM Pujar
             WHEN 52 PERFORM Baixar
      *      WHEN 27 MOVE 0 TO OPES
           END-EVALUATE.

        Baixar.
           START CatalegViatges KEY IS > CodiViatge.
           PERFORM Visualitzar.

        Pujar.
           START CatalegViatges KEY IS < CodiViatge.
           PERFORM Visualitzar.

        Decidir.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 2 4 21 74" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".
           PERFORM Sortir.

        Visualitzar.
           READ CatalegViatges NEXT RECORD.
           MOVE CodiViatge TO ED-CodiViatge.
           MOVE CodiViatge TO Codi.
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

        Sortir.
           EXIT PROGRAM.
