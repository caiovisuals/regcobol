       IDENTIFICATION DIVISION.
       PROGRAM-ID. REGISTER.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-NAME.
          05 WS-NAME-TXT    PIC X(30).
       01 WS-AGE            PIC 99.

       PROCEDURE DIVISION.
       HOME.
           DISPLAY "=== CADASTRO SIMPLES ===".
           DISPLAY "Digite o nome: ".
           ACCEPT WS-NAME-TXT.

           DISPLAY "Digite a idade: ".
           ACCEPT WS-AGE.

           DISPLAY " ".
           DISPLAY "=== DADOS INFORMADOS ===".
           DISPLAY "Nome : " WS-NAME-TXT.
           DISPLAY "Idade: " WS-AGE.

           DISPLAY " ".
           DISPLAY "Programa finalizado.".
           STOP RUN.
