# Provides the basics of writing a field header to binary format and the barebones initialization.
class BaseFieldWriter
  # is the name of the field on the generated DBF
  attr_reader :name
  # is the field length
  attr_reader :length
  # is a type descriptor per DBF specification. It should be set by the child classes
  attr_reader :type

  def initialize(field_name, options)
    sanitize_field_name(field_name)
    @length = options[:length]
    @header_definition = []
    column
  end

  def definition(offset)
    @header_definition.insert(2, offset)
    @header_definition.pack('a11aCx2CCx15')
  end

  # Tries to identify the class responsible for the field data. Insipired on
  # subclassResponsibility in Smalltalk
  # Usage:
  #
  #   BaseFieldWriter.field_for('awesome', length: 10, type: :character)
  #   BaseFieldWriter.field_for('awesome', length: 10, type: :date)
  def self.field_for(field_name, options)
    klass = subclasses.select {|klass| klass.type == options[:type] }
    klass[0].new(field_name, options) unless klass.nil?
  end

  # Implementation of the subclasses method from smalltalk.
  # It should be called only at the creation on the file structure, so performance
  # shouldn't be an issue.
  def self.subclasses
    subclasses = []
    ObjectSpace.each_object(Class) do |klass|
      subclasses << klass if klass.ancestors.include? self and klass != self
    end
    subclasses
  end

  private
  def column
    @header_definition.push @name.upcase, @type, 0, @length
    @header_definition.push 0, 0, 0, 0, 0, 0
    #columns << 0 #WorkAreaId
    #columns << 0 #multiuser
    #columns << 0 #Setfield
    #columns << 0 #reserved
    #columns << 0 #reserved
    #columns << 0 #IncludeMdx
  end

  def sanitize_field_name(field_name)
    name = field_name.gsub(/[^A-Za-z1-9_]/, '')[0..9].upcase
    @name = name.empty? ? 'FIELD' : name
  end
end

