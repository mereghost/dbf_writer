# Writes Character fields as per specification.
class CharacterFieldWriter < BaseFieldWriter

  def self.type
    :character
  end

  def initialize(field_name, options = {})
    super(field_name, options)
    @type = "C"
    @length = @options[:length] || 50
    raise ArgumentError.new('CharacterFields must have a length between 1 and 255') unless @length.between?(1,255)
  end

  def data(data)
    [' ', data.ljust(@length)].pack("aa#{@length}")
  end

end

