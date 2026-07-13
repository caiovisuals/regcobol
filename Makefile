# Makefile - SISTEMA DE CADASTRO (COBOL / GnuCOBOL)

COBC      = cobc
COBFLAGS  = -x -Wall
SRC       = src/main.cob
BIN       = bin/records

.PHONY: all build run test clean

all: build

build: $(BIN)

$(BIN): $(SRC)
	@mkdir -p bin data
	$(COBC) $(COBFLAGS) $(SRC) -o $(BIN)

run: build
	./$(BIN)

test: build
	bash tests/run.sh

clean:
	rm -f $(BIN)