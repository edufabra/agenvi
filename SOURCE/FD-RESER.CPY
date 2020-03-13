         FD FitxerReserves
           LABEL RECORD IS STANDARD
           DATA RECORD IS Reserva.
         01 Reserva.
           02 Clau.
             03 DniReserva         PIC X(9).
             03 CodiViatgeReservat PIC 9(5).
           02 DiaSortida           PIC X(10).
           02 PlacesReservades     PIC 9(4).
           02 PreuTotalReserva     PIC 9(7).
