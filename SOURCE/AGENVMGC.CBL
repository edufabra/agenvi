       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulGestioClients.
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
         77 NumOpcions               PIC 9.
         77 Opc                      PIC 9.
         77 OpcEscollida             PIC 9.
         77 Sortir                   PIC XX VALUE "NO".
         01 Taula.
           02 Opcions OCCURS 5 PIC X(12).

         01 Taula2.
           02 Ajudes OCCURS 5 PIC X(60).

       PROCEDURE DIVISION.
         Principal.
           MOVE 3 TO Numopcions.
           MOVE 0 TO OpcEscollida.
           MOVE 1 TO Opc.
           MOVE "Manteniment." TO Opcions(1).
           MOVE "Llistats.   " TO Opcions(2).
           MOVE "Retornar.   " TO Opcions(3).
           MOVE
           "Permet Afegir, Modificar o Borrar les dades d'un client"
               TO Ajudes (1).
           MOVE "Permet Visualitzar Llistats dels Clients" TO Ajudes(2).
           MOVE "Permet retornar al menu anterior" TO Ajudes(3).
           MOVE "NO" TO Sortir.
           PERFORM Proces UNTIL Sortir = "SI".
           PERFORM Sortir.

         Proces.
           CALL "GESTECLA.COB"
             USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
           CANCEL "GESTECLA.COB"
           PERFORM EvaluarTecla.

         EvaluarTecla.
           EVALUATE OpcEscollida
             WHEN 0 MOVE "SI" TO Sortir
             WHEN 1 PERFORM Manteniment
             WHEN 2 PERFORM Llistar
             WHEN 3 MOVE "SI" TO Sortir
           END-EVALUATE.

         Manteniment.
           CALL "MANTCLI.COB".
           CANCEL "MANTCLI.COB".

         Llistar.
           CALL "LLISTCLI.COB".
           CANCEL "LLISTCLI.COB".

         Sortir.
           EXIT PROGRAM.
