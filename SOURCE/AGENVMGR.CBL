       IDENTIFICATION DIVISION.
         PROGRAM-ID. A-ViatgesModulGestioReserves.
       ENVIRONMENT DIVISION.
         COPY CONFIG-S.CPY.
       DATA DIVISION.

        WORKING-STORAGE SECTION.
         77 NumOpcions               PIC 9.
         77 Opc                      PIC 9.
         77 OpcEscollida             PIC 9.
         77 Sortir                   PIC XX VALUE "NO".
         77 Programa                 PIC X(50).
         77 Parametres               PIC X(50).
         77 Estat-Shell              PIC 9.
         77 Errorlevel               PIC 999.

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

        Principal.
           MOVE 4 TO Numopcions.
           MOVE 0 TO OpcEscollida.
           MOVE 1 TO Opc.
           MOVE "Visualitzar." TO Opcions(1).
           MOVE "Formalitzar." TO Opcions(2).
           MOVE "Anul-lar.   " TO Opcions(3).
           MOVE "Retornar.   " TO Opcions(4).
           MOVE
           "Visualitza les reserves realitzades."
               TO Ajudes (1).
           MOVE "Realitza una reserva." TO Ajudes(2).
           MOVE "Permet anul-lar una reserva." TO Ajudes(3).
           MOVE "Permet retornar al menu anterior." TO Ajudes(4).
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
             WHEN 1 PERFORM Visualitzar
             WHEN 2 PERFORM Formalitzar
             WHEN 3 PERFORM Anul-lar
             WHEN 4 MOVE "SI" TO Sortir
           END-EVALUATE.

        Visualitzar.
           CALL "LLIRESER.COB".
           CANCEL "LLIRESER.COB".

        Formalitzar.
           CALL "FERRESER.COB".
           CANCEL "FERRESER.COB".

        Anul-lar.
           CALL "ANURESER.COB".
           CANCEL "ANURESER.COB".

        Sortir.
           EXIT PROGRAM.

