       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulGestioViatges.
         AUTHOR. Eduard-Fabra-Bori-/-Emilio-J-Cendrero.
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
         77 NumOpcions               PIC 9.
         77 Opc                      PIC 9.
         77 OpcEscollida             PIC 9.
         77 Sortir                   PIC XX VALUE "NO".
         77 Codi                     PIC 9(5).

         01 Taula.
           02 Opcions OCCURS 5 PIC X(12).

         01 Taula2.
           02 Ajudes OCCURS 5 PIC X(60).

       PROCEDURE DIVISION.
         Principal.
           MOVE 4 TO Numopcions
           MOVE 0 TO OpcEscollida
           MOVE 1 TO Opc
           MOVE "Manteniment." TO Opcions(1)
           MOVE "Llistats.   " TO Opcions(2)
           MOVE "Mirar.      " TO Opcions(3)
           MOVE "Retornar.   " TO Opcions(4)
           MOVE
           "Permet Afegir, Modificar o Borrar les dades d'un viatge"
             TO Ajudes (1)
           MOVE "Permet Visualitzar Llistats dels Viatges" TO Ajudes(2)
           MOVE "Permet mirar el cataleg" TO Ajudes(3)
           MOVE "Permet retornar al menu anterior" TO Ajudes(4)
           MOVE "NO" TO Sortir
           PERFORM ProcesComplert UNTIL Sortir = "SI"
           PERFORM Sortir.

         ProcesComplert.
             CALL "GESTECLA.COB"
               USING Taula, Taula2, NumOpcions, Opc, OpcEscollida
             CANCEL "GESTECLA.COB"
             PERFORM EvaluarTeclaC.

         EvaluarTeclaC.
             EVALUATE OpcEscollida
               WHEN 0 MOVE "SI" TO Sortir
               WHEN 1 PERFORM Manteniment
               WHEN 2 PERFORM Llistar
               WHEN 3 PERFORM Mirar
               WHEN 4 MOVE "SI" TO Sortir
             END-EVALUATE.



         Manteniment.
             CALL "MANCATVI.COB".
             CANCEL "MANCATVI.COB".

         Llistar.
             CALL "LLICATVI.COB".
             CANCEL "LLICATVI.COB".

         Mirar.
             CALL "BROWSEV.COB" USING Codi.
             CANCEL "BROWSEV.COB".

         Sortir.
           EXIT PROGRAM.
