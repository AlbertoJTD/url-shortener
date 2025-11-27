class ShortCode
  ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  BASE = ALPHABET.length

  def self.encode(number)
    raise ArgumentError, 'Number must be an integer' unless number.is_a?(Integer)
    raise ArgumentError, 'Number must be positive' if number.negative?

    # Returns `0`
    return ALPHABET[0] if number.zero? || number.nil?

    result = ''
    while number.positive?
      remainder = number % BASE
      character = ALPHABET[remainder]
      result.prepend(character)
      number /= BASE
    end

    result
  end

  def self.decode(string)
    raise ArgumentError, 'Decoded value must be a string' unless string.is_a?(String)

    result = 0
    string.chars.reverse.each_with_index do |character, power|
      character_index = ALPHABET.index(character)
      result += character_index * (BASE**power)
    end

    result
  end
end
