            SELECT FitxerClients ASSIGN TO RANDOM "CLIENTS.AGV"
             ORGANIZATION IS INDEXED
             RECORD KEY IS Dni
             ACCESS MODE IS DYNAMIC
             FILE STATUS IS EstatFitxerClients.
