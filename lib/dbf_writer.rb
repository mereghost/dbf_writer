class DbfWriter

  attr_reader :fields

  def initialize
    @fields = []
  end

  def add_field(field)
    @fields << field
  end

end

