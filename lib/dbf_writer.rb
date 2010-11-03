class DbfWriter

  attr_reader :fields

  def initialize
    @fields = []
  end

  def add_field(field)
    @fields << {:name => field, :total_length => 50}
  end

  def to_binary_string
    header
#    eof
    @data
  end

  private
  def column_definitions
    arr = @fields.inject([]) do |stuff, hash|
      columns = []
      columns << hash[:name].upcase
      columns << "C"
      columns << 0 #Reserved
      columns << hash[:total_length]
      columns << 0 #WorkAreaId
      columns << 0 #multiuser
      columns << 0 #Setfield
      columns << 0 #reserved
      columns << 0 #reserved
      columns << 0 #IncludeMdx
      stuff << columns.pack('a10ax4CCx15')
    end
    @data << arr.flatten.join('')
  end

  def header
    header = [3]
    header << 10
    header << 11
    header << 3
    header << 0
    header << (@fields.size * 32 + 33)
    header << @fields.inject(0) { |s,f| s + f[:total_length]} + 1
    @data = header.pack('CCCCVvvxxxxxxxxxxxxxxxxxxxx')
    column_definitions
    @data << "\x0D"
  end

  def eof
    @data << "\x1A"
  end
end

