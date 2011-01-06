class DateFieldWriter < BaseFieldWriter

  def self.type
    :date
  end

  def initialize(field_name, options = {})
    options[:length] = 8
    @type = "D"
    super(field_name, options)
  end

  def data
  end
end

