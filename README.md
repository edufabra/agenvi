Versió 1.1 Novembre-Desembre 1994                         


                        A   G   E   N   V   I   (v.1.1)

                            (c) COPYRIGHT 1994

                        Dissenyat per: EDUARD FABRA BORI
                                       EMILIO J. CENDRERO
                                       

                            MANUAL DEL USUSARI
                          ----------------------

Contingut:
             1.- Què es AGENVI ?.
             2.- Instalació.
             3.- Execució.
             4.- Caracter¡stiques Tècniques.
             5.- Funcionament
               5.1.- Les opcions del Menu Principal.
               5.2.- Les opcions del Submenu de Clients.
               5.3.- Les opcions del Submenu del Catàleg de Viatges.
               5.4.- Les opcions del Submenu de Reserves.
               5.5.- La opció de MANTENIMENT.
               5.6.- La opció de MIRAR.

1.- Què és AGENVI ?.              
--------------------

  AGENVI és un programa dissenyat per fer més facil la feina de les AGENcies 
  de VIatges. AGENVI principalment permet:

       - Altes, Baixes, Modificacions, Baixes i Llistats de Clients.
       - Altes, Baixes, Modificacions, Baixes i Llistats del Catàleg de
         Viatges.
       - Formalitzar, Anul-lar i Visualitzar les Reserves.
       
  AGENVI a més permet la introducció de fotografies digitalitzades en els 
  principals formats gràfics com PCX, GIF, BMP, etc... per una millor 
  presentació del cataleg de viatges.


2.- Instalació.
---------------

  El programa es pot executar des del disquet per• degut a la baixa velocitat
  de les unitats de disquet val la pena instalar al disc dur el programa, per 
  dur a terme aquesta operació només cal escriure:

                   A:\INSTALA UnitatOrigen: UnitatDest¡:

  La Unitat d'Origen serà la unitat de disquet on tingui el programa i la 
  Unitat de Destí serà el disc dur on vulgui instalar el programa per exemple:
                   
                         A:\INSTALA A: C:

  Després d'executar aquest programa es crearà el subdirectori AGENVI al disc 
  dur i tots els altres subdirectoris que te el programa.

  
3.- Execució.
-------------

  Per executar el programa només cal escriure des del inductor de la unitat on
  estiguem:

                   A:\EXECUTA  Si l'executem des del disquet.
                   C:\AGENVI\EXECUTA Si l'executem des del disc dur.      
                   

4.- Caracter¡stiques Técniques.
-------------------------------

  - AGENVI (v.1.1) està dissenyat en RM/COBOL-85.

  - Disposa d'un (GUI) Interface Gràfic d'Usuari molt semblant al programa
    Microsoft Windows (TM) (v.3.1) per• gestionat amb menus de barres.

  - Les pantalles son restaurades mitjan‡ant un programa dissenyat en CLIPPER
    (v.5.1).

  - Incorpora la ultima versió de la utilitat Shareware CSHOW (v.8.73) que 
    permet visualitzar les fotografies introduides al cataleg de viatges.

  - El problema que te el llenguatge de programació RM/COBOL-85 que no pot 
    cridar al sistema es soluciona amb una utilitat desenvolupada per 
    APLISOFT A.I.S.L. anomenada COBDOS que ens permet cridar al sistema per
    tal de executar altres utilitats fora de les limitacions que el propi
    llenguatge te.
    
  - Com a principal inconvenient de la realització d'aquest programa cal
    dir que les limitacions del llenguatge de programació escollit per 
    fer el programa, han predeterminat que el programa no pogués tindre un 
    suport per al ratol¡ o unes pantalles en gràfics, que sens dubte haurien
    fet més fàcil la relació usuari-aplicació. Malgrat tot s'ha de dir que 
    s'ha intentat que la vistositat del programa dintre de les posibilitats
    del propi llenguatge fos la més acurada posible. D'altre banda cal dir 
    que en l'elecció de llenguatge de programació es va buscar el millor en
    quan a gestió de fitxers, i en aquesta tasca el COBOL és el millor.


5.- Funcionament.
-----------------

  5.1.- Les opcions del Menu Principal.
  -------------------------------------

    El menu Principal consta de les seguents opcions:

            - CLIENTS (Accedeix al submenu de Clients)
            - VIATGES (Accedeix al submenu del Catàleg Viatges)
            - RESERVES (Accedeix al submenu de Reserves)
            - SORTIR (Torna al inductor de comandes del D.O.S.)

    Selecciona la opció desitjada mitjan‡ant fletxa a dalt o fletxa abaix i 
    pulsi ENTER.


  5.2.- Les opcions del Submenu de Clients.
  -----------------------------------------

    El submenu de Clients consta de les seguents opcions:

            - MANTENIMENT (Permet realitzar ALTES, BAIXES, MODIFICACIONS i 
                           CONSULTES dels Clients)
            - LLISTATS (Permet fer llistats esquemàtics dels clients)
            - RETORNAR (Torna al Menu Principal)

    Selecciona la opció desitjada mitjan‡ant fletxa a dalt o fletxa abaix i 
    pulsi ENTER.


  5.3.- Les opcions del Submenu del Catàleg de Viatges.
  -----------------------------------------------------

    El submenu del Catàleg de Viatges consta de les seguents opcions:

            - MANTENIMENT (Permet realitzar ALTES, BAIXES, MODIFICACIONS i 
                           CONSULTES del Viatges)
            - LLISTATS (Permet fer llistats esquemàtics dels Viatges)
            - MIRAR (Permet mirar els viatges com si d'un cataleg de viatges
                     es tractés)
            - RETORNAR (Torna al Menu Principal)

    Selecciona la opció desitjada mitjan‡ant fletxa a dalt o fletxa abaix i 
    pulsi ENTER.


  5.4.- Les opcions del Submenu de Reserves.
  ------------------------------------------

    El submenu de Reserves consta de les seguents opcions:

            - VISUALITZAR (Permet fer llistats esquemàtics de les Reserves)
            - FORMALITZAR (Permet realitzar reserves dels viatges)
            - ANUL-LAR (Permet anul-lar una reserva existent)
            - RETORNAR (Torna al Menu Principal)

    Selecciona la opció desitjada mitjan‡ant fletxa a dalt o fletxa abaix i 
    pulsi ENTER.

  5.5.- La opció de MANTENIMENT.
  ------------------------------

    Aquesta opció permet introduir borrar consultar i modificar els clients
    si estem al submenu de Clients o bé els viatges si estem al submenu de 
    Viatges.

    Com a dada d'entrada es demana el D.N.I (compost per 8 digits i una lletra)
    en el cas dels Clients, o bé el Codi del viatge (compost per 5 digits). Si 
    el que s'ha introduit existeix en el fitxer es podrà consultar, modificar o
    bé borrar el registre. Si no existeix, es crea el registre.

    Per tal de borrar un registre només hem d'introduir la clau del registre
    i un cop s'ens visualitzi la informació escriure espais a la clau del 
    registre i s'ens preguntarà si realment desitjem borrarlo.


  5.6.- La opció de MIRAR.
  ------------------------
     Aquesta opció es troba al submenu del Catàleg de Viatges i ens deixa 
     pasar per cada viatge mitjan‡ant fletxa a dalt i fletxa abaix. Si 
     al camp PathFotografia s'ha especificat el path d'una fotografia
     s'ens visualitzarà automàticament esperant que pulsem una tecla.

