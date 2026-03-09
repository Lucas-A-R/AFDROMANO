class RomanAFD
  ROMAN_VALUES = {
    "I" => 1, "V" => 5,
    "X" => 10, "L" => 50,
    "C" => 100, "D" => 500,
    "M" => 1000
  }

  def initialize(cadeia)
    @cadeia = cadeia
    @indice = 0
    @max = cadeia.size
    @valor = 0
  end

  def proximo
    @indice < @max ? @cadeia[@indice] : nil
  end

  def iniciar
    repeticoes = 1
    ultimo_simbolo = nil

    while (simbolo = proximo)
      atual = ROMAN_VALUES[simbolo]
      return invalido("Símbolo inválido: #{simbolo}") if atual.nil?

      # Verifica repetição
      if simbolo == ultimo_simbolo
        repeticoes += 1
        if ["V","L","D"].include?(simbolo) && repeticoes > 1
          return invalido("Repetição inválida de #{simbolo}")
        elsif repeticoes > 3
          return invalido("Repetição inválida de #{simbolo}")
        end
      else
        repeticoes = 1
      end

      # Verifica subtração
      proximo_valor = ROMAN_VALUES[@cadeia[@indice + 1]] if @indice + 1 < @max
      if proximo_valor && atual < proximo_valor
        unless valido_subtracao?(simbolo, @cadeia[@indice + 1])
          return invalido("Subtração inválida: #{simbolo} antes de #{@cadeia[@indice + 1]}")
        end
        @valor += (proximo_valor - atual)
        @indice += 2
      else
        @valor += atual
        @indice += 1
      end

      ultimo_simbolo = simbolo
    end

    puts "Aceito 😀 Valor decimal: #{@valor}"
    @valor
  end

  private

  def invalido(msg)
    puts "Rejeitado ❌ - #{msg}"
    nil
  end

  def valido_subtracao?(s1, s2)
    case s1
    when "I" then ["V","X"].include?(s2)
    when "X" then ["L","C"].include?(s2)
    when "C" then ["D","M"].include?(s2)
    else false
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