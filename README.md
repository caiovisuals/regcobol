# SISTEMA DE CADASTRO BÁSICO (COBOL) - ᴘᴛ

Sistema de cadastro de pessoas em COBOL, com menu interativo, validação de dados, persistência em arquivo e operações completas de CRUD (Cadastrar, Listar, Buscar e Excluir).

### Funcionalidades
- **Cadastrar** pessoa (nome, idade, e-mail e CPF).
- **Excluir** um cadastro pelo CPF (com confirmação).
- **Persistência**: os dados são gravados em `data/records.dat` e recarregados automaticamente ao abrir o programa.

### Pré-requisitos
- [GnuCOBOL](https://gnucobol.sourceforge.io/) (`cobc`) 3.x.

### Como compilar e executar
```sh
make build   # compila para bin/records
make run     # compila (se necessário) e executa
make test    # roda a suíte de testes de integração
make clean   # remove o binário
```

# BASIC REGISTRATION SYSTEM (COBOL) - ᴇɴ

A people-registration system written in COBOL, featuring an interactive menu, input validation, file persistence and full CRUD operations (Create, List, Search and Delete).

### Features
- **Create** a person (name, age, e-mail and CPF).
- **Delete** a record by CPF (with confirmation).
- **Persistence**: data is stored in `data/records.dat` and reloaded automatically on startup.

### Requirements
- [GnuCOBOL](https://gnucobol.sourceforge.io/) (`cobc`) 3.x.

### Build and run
```sh
make build   # compiles to bin/records
make run     # compiles (if needed) and runs
make test    # runs the integration test suite
make clean   # removes the binary
```

by caiothevisual