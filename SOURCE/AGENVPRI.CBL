       IDENTIFICATION DIVISION.
         PROGRAM-ID. AgenciesViatgesModulPrincipal.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
          77 Estat-Shell    PIC 9.
          77 Errorlevel      PIC 999.
          77 Parametres      PIC X(50).
          77 Programa        PIC X(50).
          77 Tecla           PIC X.
          77 NumOpcions      PIC 9.
          77 Opc             PIC 9.
          77 OpcEscollida    PIC 9.
          77 Sortir          PIC XX VALUE "NO".
          77 Acces           PIC X(2) VALUE "NO".

          01 Taula.
            02 Opcions OCCURS 5 PIC X(12).

          01 Taula2.
            02 Ajudes OCCURS 5 PIC X(60).

       SCREEN SECTION.
       01 BORRADO BLANK SCREEN.

       01 NORMAL.
           02 VALUE " "
               FOREGROUND WHITE BACKGROUND BLACK.

       PROCEDURE DIVISION.
          PRINCIPAL.
            DISPLAY BORRADO.
            MOVE "&MODE CO80" TO Programa.
            CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa
            CANCEL "COBDOS\COBDOS.EXE".
            MOVE "CSHOW\CSHOW.EXE" TO Programa.
            MOVE "PORTADA.PCX+X" TO Parametres.
            CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa Parametres
            CANCEL "COBDOS\COBDOS.EXE".
            ACCEPT TECLA NO BEEP.
            MOVE "&MODE CO80" TO Programa.
            CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa
            CANCEL "COBDOS\COBDOS.EXE".
            MOVE "&MODE CO80" TO Programa.
            CALL "COBDOS\COBDOS.EXE" USING
                 Estat-Shell Errorlevel Programa
            CANCEL "COBDOS\COBDOS.EXE".
            MOVE 4 TO Numopcions.
            MOVE 0 TO OpcEscollida.
            MOVE 1 TO Opc.
            MOVE "Clients. " TO Opcions(1).
            MOVE "Viatges. " TO Opcions(2).
            MOVE "Reserves." TO Opcions(3).
            MOVE "Sortir.  " TO Opcions(4).
            MOVE
              "Permet gestionar les dades dels Clients."
               TO Ajudes (1).
            MOVE "Permet gestionar les dades dels Viatges." TO Ajudes(2).
            MOVE "Permet gestionar les reserves." TO Ajudes(3).
            MOVE "Finalitza la sesio i retorna al DOS." TO Ajudes(4).
            MOVE "NO" TO Sortir.
            PERFORM Proces UNTIL Sortir = "SI".
            STOP RUN.

        Proces.
           CALL "GESTECLA.COB"
             USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
           CANCEL "GESTECLA.COB"
           PERFORM EvaluarTecla.

        EvaluarTecla.
           EVALUATE OpcEscollida
             WHEN 0 MOVE "SI" TO Sortir
             WHEN 1 PERFORM GestioClients
             WHEN 2 PERFORM GestioViatges
             WHEN 3 PERFORM GestioReserves
             WHEN 4 MOVE "SI" TO Sortir
           END-EVALUATE.

        GestioClients.
           CALL "AGENVMGC.COB" .
           CANCEL "AGENVMGC.COB".

        GestioViatges.
           CALL "AGENVMGV.COB".
           CANCEL "AGENVMGV.COB".

        GestioReserves.
           CALL "AGENVMGR.COB" .
           CANCEL "AGENVMGR.COB".


