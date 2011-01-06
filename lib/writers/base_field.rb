class BaseFieldWriter
  attr_reader :name, :length, :type

  def initialize(field_name, options)
    @name, @length = field_name, options[:length]
  end

  def definition(offset)
    columns = []
    columns << @name.upcase
    columns << @type
    columns << offset
    columns << 0 #Reserved
    columns << @length
    6.times { columns << 0 }
#    columns << 0 #WorkAreaId
#    columns << 0 #multiuser
#    columns << 0 #Setfield
#    columns << 0 #reserved
#    columns << 0 #reserved
#    columns << 0 #IncludeMdx
    columns.pack('a11aCx2CCx15')
  end

  def self.field_for(field_name, options)
    klass = subclasses.select {|klass| klass.type == options[:type] }
    klass[0].new(field_name, options)
  end

  def self.subclasses
    [CharacterFieldWriter, DateFieldWriter]
  end
end

