class CharacterFieldWriter < BaseFieldWriter

  def self.type
    :character
  end

  def initialize(field_name, options)
    raise ArgumentError, "Field is too large. Length must be 1..255" unless (1..255).include? options[:length]
    @type = "C"
    super(field_name, options)
  end

  def data(data)
    [' ', data.ljust(@length)].pack("aa#{@length}")
  end

end

