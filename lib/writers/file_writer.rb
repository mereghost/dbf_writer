require 'writers/field_writers'

# Generates the binary header and data of the DBF.
#
# Should I split in a Header class since is somewhat complex and only pass field info as needed?
# That could lead to some tight coupling tho.

class FileWriter

  # An array that store the field definitions
  attr_reader :fields

  def initialize
    @fields, @rows, @data = {}, [], ""
    @header = [3]
  end

  # Adds a field to the file definition.
  #
  # Usage:
  #
  # * _name_: can be either a string or a symbol.
  # * _options_: is a hash that takes the following parameters (See the field writers for more info):
  #     :type => [:character, :date] is the field type. character is assumed by default
  #     :length => integer, the length of the character field (default: 50)
  def add_field(field_name, options = {})
    field = BaseFieldWriter.field_for(field_name.to_s, options)
    field.name = change_field_name_to_avoid_collision(field.name)
    @fields[field.name] = field
    self
  end

  # Add a row of data to the definiton
  def add_row(*row)
    @rows << row
  end

  # Creates a binary representation. Including header + data.
  def to_binary_string
    header
    row_data
    eof unless @rows.empty?
    @data
  end

  private
  def header
    current_date
    @header << @rows.size  # total number of records
    @header += field_info
    @data << @header.pack('CCCCVvvxxxxxxxxxxxxxxxxxxxx')
    @data << column_definitions
    @data << "\x0D"
  end

  def column_definitions
    offset = 1
    arr = @fields.values.map do |field|
      current_offset, offset = offset, offset + field.length
      field.definition(current_offset)
    end
    arr.join('')
  end

  def current_date
    @header.push 10, 11, 4 # this should be year, month, day
  end

  def field_info
    #[ size of fields descriptors, field size definitions ]
    [(@fields.size * 32 + 33), (@fields.values.reduce(1) { |sum, field| sum + field.length})]
  end

  def row_data
    @rows.each do |row|
      write_row(row)
    end
  end

  def write_row(row)
    row.each_with_index {|data, index| @data << @fields.values[index].data(data) }
  end

  def eof
    @data << "\x1A"
  end

  def change_field_name_to_avoid_collision(field)
    # select the names that match the field name
    regex = Regexp.new "^#{field}.*"
    names = @fields.keys.select {|key| key =~ regex }
    unless names.empty?
      field = setup_new_name(names.sort.last, field)
    end
    field
  end

  def setup_new_name(last_name, field_name)
    index = last_name.gsub(/\D/,'').to_i
    "#{field_name[0..7]}_#{index.succ}"
  end
end

