# 🏛️ Autômato Finito Determinístico para Números Romanos

## 📌 Objetivo
Este projeto implementa um **Autômato Finito Determinístico (AFD)** em Ruby para validar e converter números romanos em valores decimais.  
O programa garante que a entrada respeite as regras formais da notação romana e rejeita cadeias inválidas.

---

## ⚙️ Estrutura do Código

### Classe `RomanAFD`
- **Constante `ROMAN_VALUES`**  
  Mapeia cada símbolo romano para seu valor decimal.
  
- **Método `initialize(cadeia)`**  
  Recebe a cadeia de entrada e inicializa variáveis de controle.

- **Método `proximo`**  
  Retorna o próximo símbolo da cadeia ou `nil` se chegou ao fim.

- **Método `iniciar`**  
  - Percorre a cadeia símbolo por símbolo.  
  - Aplica regras de repetição e subtração.  
  - Soma ou subtrai valores conforme necessário.  
  - Valida se a entrada é correta; caso contrário, rejeita.  
  - Imprime se a cadeia foi **Aceita 😀** ou **Rejeitada ❌**.

- **Método `valido_subtracao?(s1, s2)`**  
  Verifica se uma subtração é permitida (ex: `I` antes de `V` ou `X`).

- **Método `invalido(msg)`**  
  Imprime mensagem de rejeição quando a entrada não respeita as regras.

---

## 📖 Regras Implementadas
1. **Repetição máxima**  
   - `I`, `X`, `C`, `M` → até 3 vezes seguidas.  
   - `V`, `L`, `D` → não podem se repetir.

2. **Subtração permitida**  
   - `I` antes de `V` ou `X`.  
   - `X` antes de `L` ou `C`.  
   - `C` antes de `D` ou `M`.  
   - Nenhum outro caso de subtração é válido.

3. **Ordem decrescente**  
   Símbolos devem aparecer em ordem decrescente, exceto nos casos de subtração.

---

## 🧪 Testes Realizados
O programa foi testado com os seguintes exemplos:

| Romano      | Decimal |
|-------------|---------|
| III         | 3       |
| IV          | 4       |
| IX          | 9       |
| XIV         | 14      |
| XXIX        | 29      |
| XLII        | 42      |
| LXXXVIII    | 88      |
| CXCIV       | 194     |
| MCMXC       | 1990    |
| MMXXIV      | 2024    |

Todos os testes foram **aceitos corretamente** ✅.

---

## 📊 Diagrama do Autômato (Mermaid)

```mermaid
flowchart LR
    q0("Início") -->|I| q0
    q0 -->|V| q1
    q0 -->|X| q2
    q1 -->|I| q1
    q2 -->|X| q2
    q2 -->|L| q3
    q2 -->|C| q4
    q4 -->|D| q5
    q4 -->|M| q6
    q6 -->|Fim| qf(("Aceito ✅"))
