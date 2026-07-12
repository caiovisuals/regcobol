       IDENTIFICATION DIVISION.
       PROGRAM-ID. REGISTER.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-REG ASSIGN TO "data/cadastros.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD  ARQ-REG.
       01  REG-CAD.

       WORKING-STORAGE SECTION.
       01 WS-NAME.
           05 WS-NAME-TXT   PIC X(30).
       01 WS-AGE            PIC 99.

       01 WS-EMAIL.
           05 WS-EMAIL-TXT  PIC X(50).

       01 WS-CPF            PIC X(11).

       PROCEDURE DIVISION.
       PRINCIPAL.
           DISPLAY "=== CADASTRO ===".
           DISPLAY "Digite o nome: ".
           ACCEPT WS-NAME-TXT.

           DISPLAY "Digite a idade: ".
           ACCEPT WS-AGE.

           DISPLAY "Digite seu e-mail: ".
           ACCEPT WS-EMAIL-TXT.

           DISPLAY "Digite seu CPF: ".
           ACCEPT WS-CPF.

           DISPLAY " ".
           DISPLAY "=== DADOS INFORMADOS ===".
           DISPLAY "Nome: " WS-NAME-TXT.
           DISPLAY "Idade: " WS-AGE.
           DISPLAY "E-MAIL: " WS-EMAIL-TXT.
           DISPLAY "CPF: " WS-CPF-TXT.

           DISPLAY " ".
           DISPLAY "CADASTRO FINALIZADO.".
           STOP RUN.
       LOAD-FILE.
           MOVE 0 TO WS-QTD
           OPEN INPUT ARQ-REG
           IF FS-OK
               PERFORM UNTIL FS-EOF
                   READ ARQ-REG
                   END-READ
               END-PERFORM
               CLOSE ARQ-REG
           END-IF.
       SAVE-FILE.
           OPEN OUTPUT ARQ-REG
           IF FS-OK
               PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-QTD
                   WRITE REG-CAD
               END-PERFORM
               CLOSE ARQ-REG
           ELSE
               DISPLAY ">> Erro ao salvar arquivo (status " WS-FS ")."
           END-IF.
