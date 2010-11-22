require 'writers/base_field'

class FileWriter

  attr_reader :fields

  def initialize
    @fields, @data = [], ""

  end

  def add_field(field_name, length = 50)
    @fields << BaseFieldWriter.new(field_name, length)
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
    header << 10 # this should be year
    header << 11 # month
    header << 4  # day
    header << 0  # reserved
    header << (@fields.size * 32 + 33) #size of fields descriptors
    header << @fields.inject(1) { |s,f| s + f.length} #field definitions
    @data << header.pack('CCCCVvvxxxxxxxxxxxxxxxxxxxx')
    column_definitions
    @data << "\x0D"
  end

  def eof
    @data << "\x1A"
  end
end

