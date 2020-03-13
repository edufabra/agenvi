         FD CatalegViatges
           LABEL RECORD IS STANDARD
           DATA RECORD IS RegistreCatalegViatges.
         01 RegistreCatalegViatges.
           02 CodiViatge        PIC 9(5).
           02 Titol             PIC X(37).
           02 Continent         PIC X(20).
           02 Majorista         PIC X(20).
           02 Paisos            PIC X(30).
           02 MediTransport     PIC XX.
             88 Vaixell              VALUE "VA".
             88 Avio                 VALUE "AV".
             88 Autocar              VALUE "AU".
             88 Tren                 VALUE "TR".
           02 RegimAllotjament  PIC XX.
             88 PensioComplerta      VALUE "PC".
             88 MitjaPensio          VALUE "MP".
             88 AllotjamentDesdejuny VALUE "AD".
           02 TipusAllotjament  PIC XXX.
             88 Hotel                VALUE "HOT".
             88 ApartHotel           VALUE "APH".
             88 Apartament           VALUE "APT".
             88 Camping              VALUE "CPG".
             88 Bungalow             VALUE "BGW".
           02 SuplementTempAlta PIC 9(5).
           02 IniciTempAlta.
             03 MesIniTempAlta  PIC 9(2).
           02 FiTempAlta.
             03 MesFiTempAlta   PIC 9(2).
           02 DatesSortida      PIC X(31).
           02 DuracioViatge     PIC 9(3).
           02 PlacesDisponibles PIC 9(4).
           02 PreuPersona       PIC 9(6).
           02 Fotografia.
             03 PathFotografia  PIC X(46).
