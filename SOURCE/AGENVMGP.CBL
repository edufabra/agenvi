       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulGestioPassword.
         AUTHOR. Eduard-Fabra-Bori-/-Emilio-J-Cendrero.

       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.

         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
            COPY S-FPWORD.CPY.

       DATA DIVISION.
        FILE SECTION.
          COPY FD-PWORD.CPY.

         WORKING-STORAGE SECTION.

          77 EstatFitxerPassword PIC XX VALUE "00".
          77 Estat-Shell         PIC 9.
          77 Errorlevel          PIC 999.
          77 Parametres          PIC X(50).
          77 Programa            PIC X(50).
          77 NomComprobar        PIC X(15).
          77 PasswordComp        PIC X(5).
          77 Correcte            PIC XX VALUE "NO".
          77 Tecla               PIC X.

         LINKAGE SECTION.
          77 Parametre           PIC X(5).
          77 Acces               PIC XX.

         SCREEN SECTION.

          01 Pantalla AUTO REQUIRED SECURE BACKGROUND IS WHITE
               FOREGROUND IS GREY.
            02 LINE 10 COL 38 PIC X(7) USING NomComprobar.
            02 LINE 13 COL 38 PIC X(5) USING PasswordComp FULL.

       PROCEDURE DIVISION USING Parametre Acces.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 FitxerPassword.
         END DECLARATIVES.
        SEGUNDA SECTION.

          PRINCIPAL.
            OPEN I-O FitxerPassword.
            IF EstatFitxerPassword NOT EQUAL "00" THEN
              OPEN OUTPUT FitxerPassword
              CLOSE FitxerPassword
              OPEN I-O FitxerPassword
              PERFORM Entrar-Claus
              PERFORM Sortir
            END-IF.
            IF Parametre = "CL" THEN PERFORM Entrar-Claus.
            IF EstatFitxerPassword = 00 PERFORM Preguntar-Claus.
            STOP RUN.

          Preguntar-Claus.
            DISPLAY SPACES ERASE.
            MOVE "RESTAURA.EXE" TO Programa.
            MOVE "SCR\PPASSWRD.SCR 5 5 15 75" TO Parametres.
            CALL "COBDOS\COBDOS.EXE" USING
                    Estat-Shell Errorlevel Programa Parametres
            CANCEL "COBDOS\COBDOS.EXE".
            DISPLAY Pantalla.
            MOVE "NO" TO Correcte.
            PERFORM Comprobar-Claus UNTIL Correcte = "SI".
            IF NomUsuari = "EMPLEAT" THEN MOVE "SI" TO Acces
            ELSE IF NomUsuari NOT EQUAL "EMPLEAT" MOVE "NO" TO Acces.

          Comprobar-Claus.
            ACCEPT Pantalla.
            MOVE PasswordComp TO Password.
            READ FitxerPassword, NEXT RECORD.
            IF EstatFitxerPassword NOT EQUAL "23"
              IF NomComprobar = NomUsuari MOVE "SI" TO Correcte
            END-IF.
            IF EstatFitxerPassword = "23"
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
              DISPLAY "ERROR!!! Password NO registrat" BEEP LINE 11
              POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE"
              ACCEPT Tecla NO BEEP
              MOVE "RESTAURA.EXE" TO Programa
              MOVE "DEFAULT.SCR 7 5 12 75" TO Parametres
              CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
              CANCEL "COBDOS\COBDOS.EXE"
            END-IF.

          Entrar-Claus.
            DISPLAY SPACES ERASE.
            MOVE "RESTAURA.EXE" TO Programa.
            MOVE "SCR\PPASSWRD.SCR 5 5 15 75" TO Parametres.
            CALL "COBDOS\COBDOS.EXE" USING
                    Estat-Shell Errorlevel Programa Parametres
            CANCEL "COBDOS\COBDOS.EXE".
            DISPLAY Pantalla.
            ACCEPT Pantalla.
            MOVE NomComprobar TO NomUsuari.
            MOVE PasswordComp TO Password.
            WRITE Clau.
            IF NomUsuari = "EMPLEAT" THEN MOVE "SI" TO Acces
            ELSE IF NomUsuari NOT EQUAL "EMPLEAT" MOVE "NO" TO Acces.

          Sortir.
            EXIT PROGRAM.
