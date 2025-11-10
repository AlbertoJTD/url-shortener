class ShortCode
  ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.freeze
  BASE = ALPHABET.length

  def self.encode(number)
    raise ArgumentError, 'Number must be an integer' unless number.is_a?(Integer)

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
  end
end
