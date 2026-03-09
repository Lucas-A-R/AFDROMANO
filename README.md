# 🏛️ Autômato Finito Determinístico para Números Romanos

## 📌 Objetivo
Este projeto implementa um **Autômato Finito Determinístico (AFD)** em Ruby para validar e converter números romanos em valores decimais até **3999 (MMMCMXCIX)**.  
O programa garante que a entrada respeite as regras formais da notação romana e rejeita cadeias inválidas.

---

## ⚙️ Estrutura do Código

### Classe `RomanAFD`
- **Atributos internos**  
  - `@cadeia`: cadeia de entrada.  
  - `@indice`: posição atual na leitura.  
  - `@valor`: valor decimal acumulado.  
  - `@estado`: estado atual do autômato.

- **Método `initialize(cadeia)`**  
  Recebe a cadeia de entrada e inicializa variáveis de controle.

- **Método `proximo`**  
  Retorna o próximo símbolo da cadeia ou vazio se chegou ao fim.

- **Método `iniciar`**  
  - Percorre a cadeia símbolo por símbolo.  
  - Aplica transições explícitas para milhares, centenas, dezenas e unidades.  
  - Valida regras de repetição e subtração.  
  - Imprime se a cadeia foi **Aceita 😀** ou **Rejeitada ❌**.  
  - Mostra o estado atual e o valor parcial a cada passo.

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

4. **Limite máximo**  
   O valor máximo aceito é **3999**. Cadeias que ultrapassem esse limite são rejeitadas.

---


