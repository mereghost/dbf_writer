require 'writers/field_writers'

class FileWriter

  attr_reader :fields

  def initialize
    @fields, @rows, @data = [], [], ""

  end

  def add_field(field_name, length = 50)
    @fields << CharacterFieldWriter.new(field_name, length)
  end

  def add_row(*row)
    @rows << row
  end

  def to_binary_string
    header
    row_data
    eof unless @rows.empty?
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
    header << @rows.size  # total number of records
    header << (@fields.size * 32 + 33) #size of fields descriptors
    header << @fields.inject(1) { |s,f| s + f.length} #field definitions
    @data << header.pack('CCCCVvvxxxxxxxxxxxxxxxxxxxx')
    column_definitions
    @data << "\x0D"
  end

  def eof
    @data << "\x1A"
  end

  def row_data
    @rows.each do |row|
      row.each_with_index {|data, index| @data << @fields[index].data(data) }
    end
  end
end

