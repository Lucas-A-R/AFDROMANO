class RomanAFD
  def initialize(cadeia)
    @cadeia = cadeia
    @indice = 0
    @valor = 0
    @estado = "q0"
  end

  def proximo
    @indice < @cadeia.size ? @cadeia[@indice] : ""
  end

  def iniciar
    puts "Início no estado #{@estado}"

    loop do
      simbolo = proximo

      case [simbolo, @estado]
      # --- Milhares (1000–3000) ---
      in ["M", "q0"]
        @estado = "qM1"; @valor += 1000
      in ["M", "qM1"]
        @estado = "qM2"; @valor += 1000
      in ["M", "qM2"]
        @estado = "qM3"; @valor += 1000
      in ["M", "qM3"]
        puts "Rejeitado ❌ - valor máximo excedido"; break

      # --- Centenas (100–900) ---
      in ["C", "q0"] | ["C", "qM1"] | ["C", "qM2"] | ["C", "qM3"]
        @estado = "qC"; @valor += 100
      in ["C", "qC"]
        @estado = "qCC"; @valor += 100
      in ["C", "qCC"]
        @estado = "qCCC"; @valor += 100
      in ["D", "qC"] # CD = 400
        @estado = "qCD"; @valor += 300
      in ["D", "q0"] | ["D", "qM1"] | ["D", "qM2"] | ["D", "qM3"]
        @estado = "qD"; @valor += 500
      in ["C", "qD"]
        @estado = "qDC"; @valor += 100
      in ["C", "qDC"]
        @estado = "qDCC"; @valor += 100
      in ["C", "qDCC"]
        @estado = "qDCCC"; @valor += 100
      in ["M", "qC"] # CM = 900
        @estado = "qCM"; @valor += 800

      # --- Dezenas (10–90) ---
      in ["X", "q0"] | ["X", "qC"] | ["X", "qCC"] | ["X", "qCCC"] | ["X", "qCD"] | ["X", "qD"] | ["X", "qDC"] | ["X", "qDCC"] | ["X", "qDCCC"] | ["X", "qCM"] | ["X", "qM1"] | ["X", "qM2"] | ["X", "qM3"]
        @estado = "qX"; @valor += 10
      in ["X", "qX"]
        @estado = "qXX"; @valor += 10
      in ["X", "qXX"]
        @estado = "qXXX"; @valor += 10
      in ["L", "qX"]
        @estado = "qXL"; @valor += 30
      in ["C", "qX"]
        @estado = "qXC"; @valor += 80

      in ["L", "q0"] | ["L", "qC"] | ["L", "qCC"] | ["L", "qCCC"] | ["L", "qCD"] | ["L", "qD"] | ["L", "qDC"] | ["L", "qDCC"] | ["L", "qDCCC"] | ["L", "qCM"] | ["L", "qM1"] | ["L", "qM2"] | ["L", "qM3"]
        @estado = "qL"; @valor += 50
      in ["X", "qL"]
        @estado = "qLX"; @valor += 10
      in ["X", "qLX"]
        @estado = "qLXX"; @valor += 10
      in ["X", "qLXX"]
        @estado = "qLXXX"; @valor += 10

      # --- Unidades (1–9) ---
      in ["I", "q0"] | ["I", "qX"] | ["I", "qXX"] | ["I", "qXXX"] | ["I", "qXL"] | ["I", "qL"] | ["I", "qLX"] | ["I", "qLXX"] | ["I", "qLXXX"] | ["I", "qXC"] | ["I", "qC"] | ["I", "qCC"] | ["I", "qCCC"] | ["I", "qCD"] | ["I", "qD"] | ["I", "qDC"] | ["I", "qDCC"] | ["I", "qDCCC"] | ["I", "qCM"] | ["I", "qM1"] | ["I", "qM2"] | ["I", "qM3"]
        @estado = "qI1"; @valor += 1
      in ["I", "qI1"]
        @estado = "qI2"; @valor += 1
      in ["I", "qI2"]
        @estado = "qI3"; @valor += 1
      in ["V", "qI1"] # IV
        @estado = "qIV"; @valor += 3
      in ["X", "qI1"] # IX
        @estado = "qIX"; @valor += 8

      in ["V", "q0"] | ["V", "qX"] | ["V", "qXX"] | ["V", "qXXX"] | ["V", "qXL"] | ["V", "qL"] | ["V", "qLX"] | ["V", "qLXX"] | ["V", "qLXXX"] | ["V", "qXC"] | ["V", "qC"] | ["V", "qCC"] | ["V", "qCCC"] | ["V", "qCD"] | ["V", "qD"] | ["V", "qDC"] | ["V", "qDCC"] | ["V", "qDCCC"] | ["V", "qCM"] | ["V", "qM1"] | ["V", "qM2"] | ["V", "qM3"]
        @estado = "qV"; @valor += 5
      in ["I", "qV"]
        @estado = "qVI"; @valor += 1
      in ["I", "qVI"]
        @estado = "qVII"; @valor += 1
      in ["I", "qVII"]
        @estado = "qVIII"; @valor += 1

      # --- Fim ---
      in ["", estado_final]
        if @valor <= 3999
          puts "Aceito 😀 - valor decimal #{@valor}"
        else
          puts "Rejeitado ❌ - valor excede 3999"
        end
        break

      else
        puts "Rejeitado ❌ - transição inválida"; break
      end

      @indice += 1
      puts "Estado atual: #{@estado}, valor parcial: #{@valor}"
    end
  end
end

# Exemplos:
RomanAFD.new("III").iniciar      # Aceito, 3
RomanAFD.new("IIII").iniciar     # Rejeitado ❌
RomanAFD.new("IV").iniciar       # Aceito, 4
RomanAFD.new("IL").iniciar       # Rejeitado ❌
RomanAFD.new("MCMXCIV").iniciar  # Aceito, 1994

RomanAFD.new("IC").iniciar       # Rejeitado ❌
RomanAFD.new("VX").iniciar       # Rejeitado ❌


RomanAFD.new("MMXXVI").iniciar   # Aceito, 2026

RomanAFD.new("MMMCMXCIX").iniciar   # Aceito, 3999
