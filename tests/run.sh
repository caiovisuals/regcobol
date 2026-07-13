set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BIN="bin/records"
DATA="data/records.dat"
FAILS=0

# CPFs de teste (validos pelo digito verificador)
CPF_A="52998224725"
CPF_B="11144477735"

# CPFs invalidos
CPF_BAD="12345678900"
CPF_SEQ="11111111111"

run() {
    # run "<entrada>" -> imprime a saida do programa
    printf '%b' "$1" | timeout 10 "./$BIN" 2>&1
}

check() {
    # check "<descricao>" "<saida>" "<trecho esperado>"
    local desc="$1" out="$2" needle="$3"
    if grep -qF -- "$needle" <<<"$out"; then
        printf 'ok   - %s\n' "$desc"
    else
        printf 'FAIL - %s\n       esperava: %s\n' "$desc" "$needle"
        FAILS=$((FAILS + 1))
    fi
}

check_absent() {
    local desc="$1" out="$2" needle="$3"
    if grep -qF -- "$needle" <<<"$out"; then
        printf 'FAIL - %s\n       nao deveria conter: %s\n' "$desc" "$needle"
        FAILS=$((FAILS + 1))
    else
        printf 'ok   - %s\n' "$desc"
    fi
}

echo "== build =="
make build >/dev/null || { echo "build falhou"; exit 1; }

echo "== testes =="
rm -f "$DATA"

# 1) cadastro valido
OUT="$(run "1\nMaria Silva\n30\nmaria@ex.com\n$CPF_A\n\n0\n")"
check "cadastro valido" "$OUT" ">> Cadastro realizado com sucesso!"

# 2) CPF com digito verificador invalido e recusado
OUT="$(run "1\nJoao\n40\njoao@ex.com\n$CPF_BAD\n\n0\n")"
check "CPF invalido recusado" "$OUT" ">> CPF invalido."

# 3) CPF em sequencia (todos iguais) e recusado
OUT="$(run "1\nAna\n25\nana@ex.com\n$CPF_SEQ\n\n0\n")"
check "CPF em sequencia recusado" "$OUT" ">> CPF invalido."

# 4) idade fora da faixa e recusada
OUT="$(run "1\nPedro\n200\npedro@ex.com\n$CPF_B\n\n0\n")"
check "idade invalida recusada" "$OUT" ">> Idade invalida."

# 5) e-mail sem @ e recusado
OUT="$(run "1\nCarla\n33\ncarla-sem-arroba\n$CPF_B\n\n0\n")"
check "e-mail invalido recusado" "$OUT" ">> E-mail invalido."

# 6) CPF duplicado e recusado (Maria ja existe do teste 1)
OUT="$(run "1\nOutra Maria\n50\noutra@ex.com\n$CPF_A\n\n0\n")"
check "CPF duplicado recusado" "$OUT" ">> Ja existe cadastro com esse CPF."

# 7) persistencia: Maria continua listada em nova execucao
OUT="$(run "2\n\n0\n")"
check "persistencia entre execucoes" "$OUT" "Maria Silva"

# 8) busca por CPF existente
OUT="$(run "3\n$CPF_A\n\n0\n")"
check "busca encontra registro" "$OUT" ">> Registro encontrado:"

# 9) atualizacao mantendo campos em branco e mudando idade
OUT="$(run "4\n$CPF_A\n\n99\n\n\n2\n\n0\n")"
check "atualizacao aplicada" "$OUT" ">> Registro atualizado com sucesso!"
check "idade atualizada para 099" "$OUT" "Idade: 099"

# 10) exclusao com confirmacao
OUT="$(run "5\n$CPF_A\nS\n\n2\n\n0\n")"
check "exclusao confirmada" "$OUT" ">> Registro excluido com sucesso!"
check "lista vazia apos exclusao" "$OUT" ">> Nenhum registro cadastrado."

echo "== resultado =="
if [ "$FAILS" -eq 0 ]; then
    echo "Todos os testes passaram."
    exit 0
else
    echo "$FAILS teste(s) falharam."
    exit 1
fi