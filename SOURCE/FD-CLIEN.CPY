         FD FitxerClients
           LABEL RECORD IS STANDARD
           DATA RECORD IS DadesClient.
         01 DadesClient.
            02 Dni           PIC X(9).
            02 Nom           PIC X(20).
            02 CNom1         PIC X(30).
            02 CNom2         PIC X(30).
            02 Adress.
               03 Carrer     PIC X(49).
               03 Num        PIC 9(4).
               03 Pis        PIC 9(3).
               03 Porta      PIC 9(3).
               03 Poblacio   PIC X(15).
               03 Provincia  PIC X(15).
               03 CodiPostal PIC X(5).
