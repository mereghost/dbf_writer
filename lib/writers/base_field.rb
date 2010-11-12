class BaseFieldWriter
  attr_reader :name, :length

  def type
    "C"
  end

  def initialize(field_name, field_length)
    @name, @length = field_name, field_length
  end

  def definition(offset)
    columns = []
    columns << name.upcase
    columns << type.upcase
    columns << offset
    columns << 0 #Reserved
    columns << length
    columns << 0 #WorkAreaId
    columns << 0 #multiuser
    columns << 0 #Setfield
    columns << 0 #reserved
    columns << 0 #reserved
    columns << 0 #IncludeMdx
    columns.pack('a11aCx2CCx15')
  end
end
