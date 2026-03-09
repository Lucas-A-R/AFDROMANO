# 📊 Modelo Formal do Autômato Finito para Números Romanos

## Definição Formal

Um **AFD** é definido como uma 5-tupla:



\[
M = (Q, \Sigma, \delta, q_0, F)
\]



- **Q**: conjunto de estados  
- **Σ**: alfabeto de entrada (símbolos romanos válidos: {I, V, X, L, C, D, M})  
- **δ**: função de transição (definida pelas regras de repetição e subtração)  
- **q₀**: estado inicial  
- **F**: conjunto de estados finais (aceitação)

### Alfabeto de Entrada e Saída
- **Entrada (Σ)**: símbolos romanos {I, V, X, L, C, D, M}  
- **Saída (Γ)**: valores decimais correspondentes ou mensagens de erro.  

### Tipo de Transdutor
Este autômato é um **Transdutor de Mealy**, pois a saída (valor decimal ou rejeição) depende **tanto do estado atual quanto do símbolo de entrada**.  
Exemplo:  
- Estado `q0` lendo `I` → saída parcial `+1`.  
- Estado `q0` lendo `V` após `I` → saída `+4` (regra de subtração).  

Se fosse um **Moore**, a saída dependeria apenas do estado, mas aqui precisamos do símbolo para decidir se somamos ou subtraímos.

---

## Exemplos de Transições

- Entrada: `III`  
  - q0 --I--> q0 (saída +1)  
  - q0 --I--> q0 (saída +1)  
  - q0 --I--> q0 (saída +1)  
  - Estado final em q0, saída total = 3 ✅

- Entrada: `IV`  
  - q0 --I--> q0 (aguarda próximo)  
  - q0 --V--> q1 (subtração válida, saída +4)  
  - Estado final em q1, saída total = 4 ✅

- Entrada inválida: `IIII`  
  - q0 --I--> q0  
  - q0 --I--> q0  
  - q0 --I--> q0  
  - q0 --I--> ERRO (repetição > 3) ❌

---

## Diagrama em Mermaid

```mermaid
flowchart LR
    q0(("q0 - início")) -->|I| q0
    q0 -->|V| q1
    q0 -->|X| q2
    q0 -->|L| q3
    q0 -->|C| q4
    q0 -->|D| q5
    q0 -->|M| q6

    q0 -->|IIII| erro(("Erro ❌"))
    q1 -->|I| q1
    q2 -->|X| q2
    q2 -->|L| q3
    q2 -->|C| q4
    q4 -->|D| q5
    q4 -->|M| q6

    q6 --> fim(("Aceito ✅"))
