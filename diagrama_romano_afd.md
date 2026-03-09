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

- Entrada: `XXVII`  
  - q0 --X--> qX (valor +10)  
  - qX --X--> qXX (valor +20)  
  - qXX --V--> qXXV (valor +25)  
  - qXXV --I--> qXXVI (valor +26)  
  - qXXVI --I--> qXXVII (valor +27)  
  - Estado final em qXXVII, saída total = 27 ✅

- Entrada: `CDLVI`  
  - q0 --C--> qC (valor +100)  
  - qC --D--> qCD (valor +400)  
  - qCD --L--> qCDL (valor +450)  
  - qCDL --V--> qCDLV (valor +455)  
  - qCDLV --I--> qCDLVI (valor +456)  
  - Estado final em qCDLVI, saída total = 456 ✅

- Entrada inválida: `MMMM`  
  - q0 --M--> qM1 (valor +1000)  
  - qM1 --M--> qM2 (valor +2000)  
  - qM2 --M--> qM3 (valor +3000)  
  - qM3 --M--> ERRO (repetição > 3) ❌

---

## Diagrama em Mermaid

```mermaid
flowchart LR
    q0(("q0 - início")) -->|I,V,X,L,C,D,M| estados

    %% Milhares
    q0 -->|M| qM1
    qM1 -->|M| qM2
    qM2 -->|M| qM3
    qM3 -->|M| erro(("Erro ❌ - máximo 3999"))

    %% Centenas
    q0 -->|C| qC
    qC -->|C| qCC
    qCC -->|C| qCCC
    qC -->|D| qCD
    qC -->|M| qCM
    q0 -->|D| qD
    qD -->|C| qDC -->|C| qDCC -->|C| qDCCC

    %% Dezenas
    q0 -->|X| qX
    qX -->|X| qXX -->|X| qXXX
    qX -->|L| qXL
    qX -->|C| qXC
    q0 -->|L| qL
    qL -->|X| qLX -->|X| qLXX -->|X| qLXXX

    %% Unidades
    q0 -->|I| qI1 -->|I| qI2 -->|I| qI3
    qI1 -->|V| qIV
    qI1 -->|X| qIX
    q0 -->|V| qV -->|I| qVI -->|I| qVII -->|I| qVIII

    %% Finais
    qM1 --> fim(("Aceito ✅"))
    qM2 --> fim
    qM3 --> fim
    qC --> fim
    qD --> fim
    qX --> fim
    qL --> fim
    qI1 --> fim
    qV --> fim
