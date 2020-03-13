       IDENTIFICATION DIVISION.
        PROGRAM-ID. GestioDeRegistres.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
         INPUT-OUTPUT SECTION.
          FILE-CONTROL.
           COPY S-FCLIEN.CPY.

       DATA DIVISION.
         FILE SECTION.
           COPY FD-CLIEN.CPY.

        WORKING-STORAGE SECTION.

        77 EstatFitxerClients  PIC XX VALUE "00".
        77 Estat-Shell         PIC 9.
        77 Errorlevel          PIC 999.
        77 Parametres          PIC X(50).
        77 Programa            PIC X(50).
        77 Tecla               PIC X.
        77 Trobat              PIC X(5) VALUE "TRUE".
        77 Segur               PIC X VALUE "N".
        77 DniEdicio           PIC X(9) VALUE ALL "_".
        77 NomEdicio           PIC X(20) VALUE ALL "_".
        77 CNom1Edicio         PIC X(30) VALUE ALL "_".
        77 CNom2Edicio         PIC X(30) VALUE ALL "_".
        77 CarrerEdicio        PIC X(49) VALUE ALL "_".
        77 NumEdicio           PIC ZZZZ VALUE ZEROS.
        77 PisEdicio           PIC ZZZ VALUE ZEROS.
        77 PortaEdicio         PIC ZZZ VALUE ZEROS.
        77 PoblacioEdicio      PIC X(15) VALUE ALL "_".
        77 ProvinciaEdicio     PIC X(15) VALUE ALL "_".
        77 CPEdicio            PIC X(5) VALUE ALL "_".

        SCREEN SECTION.
        01 RegistreClient BACKGROUND IS WHITE FOREGROUND IS RED
            AUTO.
          02 LINE 9 COL 20 PIC X(9) USING DniEdicio
             UNDERLINE JUST RIGHT.
          02 LINE 9 COL 38 PIC X(20) USING NomEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 10 COL 22 PIC X(30) USING CNom1Edicio UNDERLINE
             JUST RIGHT.
          02 LINE 11 COL 22 PIC X(30) USING CNom2Edicio UNDERLINE
             JUST RIGHT.
          02 LINE 12 COL 21 PIC X(49) USING CarrerEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 13 COL 18 PIC ZZZZ USING NumEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 13 COL 29 PIC ZZZ USING PisEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 13 COL 41 PIC ZZZ USING PortaEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 13 COL 55 PIC X(15) USING PoblacioEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 14 COL 24 PIC X(15) USING ProvinciaEdicio UNDERLINE
             JUST RIGHT.
          02 LINE 14 COL 54 PIC X(5) USING CPEdicio FULL UNDERLINE
             JUST RIGHT.

        PROCEDURE DIVISION.
        DECLARATIVES.
          PRIMERA SECTION.
             USE AFTER STANDARD ERROR PROCEDURE ON
                 FitxerClients.
         END DECLARATIVES.
        SEGUNDA SECTION.

        PRINCIPAL.
           OPEN I-O FitxerClients.
           IF EstatFitxerClients NOT EQUAL "00"
             OPEN OUTPUT FitxerClients
             CLOSE FitxerClients
             OPEN I-O FitxerClients
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
           DISPLAY "Introdueixi DNI del Client: " LINE 11 POSITION 10
             CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           ACCEPT DniEdicio LINE 11 POSITION 38 CONTROL
             "FCOLOR=GREY, BCOLOR=WHITE, PROMPT, UPPER" NO BEEP.
           MOVE DniEdicio TO Dni.
           READ FitxerClients.
           PERFORM VisualitzarClient.
           PERFORM Sortir.

        VisualitzarClient.
           MOVE Dni TO DniEdicio.
           MOVE Nom TO NomEdicio.
           MOVE CNom1 TO CNom1Edicio.
           MOVE CNom2 TO CNom2Edicio.
           MOVE Carrer TO CarrerEdicio.
           MOVE Num TO NumEdicio.
           MOVE Pis TO PisEdicio.
           MOVE Porta TO PortaEdicio.
           MOVE Poblacio TO PoblacioEdicio.
           MOVE Provincia TO ProvinciaEdicio.
           MOVE CodiPostal TO CPEdicio.
           MOVE "GRABA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 5 5 15 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "SCR\VISCLI.SCR 5 5 15 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".
           DISPLAY "                            " LINE 7 POSITION 27
             CONTROL "FCOLOR=BLUE, BCOLOR=BLUE".
           DISPLAY RegistreClient.
           ACCEPT RegistreClient.
           IF DniEdicio NOT EQUAL "         "
             MOVE DniEdicio TO Dni
             MOVE NomEdicio TO Nom
             MOVE CNom1Edicio TO CNom1
             MOVE CNom2Edicio TO CNom2
             MOVE CarrerEdicio TO Carrer
             MOVE NumEdicio TO Num
             MOVE PisEdicio TO Pis
             MOVE PortaEdicio TO Porta
             MOVE PoblacioEdicio TO Poblacio
             MOVE ProvinciaEdicio TO Provincia
             MOVE CPEdicio TO CodiPostal
             WRITE DadesClient INVALID KEY REWRITE DadesClient
           END-IF.
           IF DniEdicio = "         "
             MOVE "GRABA.EXE" TO Programa
             MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres
             CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
             CANCEL "COBDOS\COBDOS.EXE"
             MOVE "RESTAURA.EXE" TO Programa
             MOVE "SCR\PREGS.SCR 7 5 13 75" TO Parametres
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
             IF Segur = "S" OR Segur = "s" PERFORM BorrarClient
           END-IF.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT.SCR 5 5 15 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
           CANCEL "COBDOS\COBDOS.EXE".

        BorrarClient.
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
           DISPLAY "Client BORRAT Satisfactoriament" BEEP LINE 11
           POSITION 10 CONTROL "FCOLOR=GREY, BCOLOR=WHITE".
           ACCEPT Tecla NO BEEP.
           DELETE FitxerClients RECORD.
           MOVE "RESTAURA.EXE" TO Programa.
           MOVE "DEFAULT1.SCR 7 5 12 75" TO Parametres.
           CALL "COBDOS\COBDOS.EXE" USING
             Estat-Shell Errorlevel Programa Parametres.
           CANCEL "COBDOS\COBDOS.EXE".

        Sortir.
           EXIT PROGRAM.

