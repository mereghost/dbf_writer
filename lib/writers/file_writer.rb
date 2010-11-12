require 'writers/base_field'

class FileWriter

  attr_reader :fields

  def initialize
    @fields = []
  end

  def add_field(field_name, length = 50)
    if (1..255).include? length
      @fields << BaseFieldWriter.new(field_name, length)
    else
      raise ArgumentError, "Field is too large. Length must be 1..255"
    end
  end

  def to_binary_string
    header
#    eof
    @data
  end

  private
  def column_definitions
    offset = 1
    arr = @fields.inject([]) do |binary, field|
      binary << field.definition(offset)
      offset += field.length
      binary
    end
    @data << arr.flatten.join('')
  end

  def header
    header = [3]
    header << 10
    header << 11
    header << 4
    header << 0
    header << (@fields.size * 32 + 33)
    header << @fields.inject(1) { |s,f| s + f.length}
    @data = header.pack('CCCCVvvxxxxxxxxxxxxxxxxxxxx')
    column_definitions
    @data << "\x0D"
  end

  def eof
    @data << "\x1A"
  end
end

