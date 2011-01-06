class DateFieldWriter < BaseFieldWriter

  def self.type
    :date
  end

  def initialize(field_name, options = {})
    options[:length] = 8
    super(field_name, options)
    @type = "D"
  end

  def data
  end
end

