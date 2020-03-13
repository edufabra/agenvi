           SELECT FitxerReserves ASSIGN TO RANDOM "RESERVES.AGV"
            ORGANIZATION IS INDEXED
            RECORD KEY IS Dni
            ALTERNATE RECORD KEY IS CodiViatge
            ACCESS MODE IS DYNAMIC
            FILE STATUS IS EstatFitxerReserves.
