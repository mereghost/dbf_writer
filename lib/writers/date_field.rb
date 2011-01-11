# Writes Date fields as per specification.
class DateFieldWriter < BaseFieldWriter

  def self.type
    :date
  end

  def initialize(field_name, options = {})
    options[:length] = 8
    @type = "D"
    super(field_name, options)
  end

  # Outputs the data as binary (simple string in this case).
  # TODO: Parse the date to check if it's valid.
  def data(data)
    "  #{data.gsub(/\D/, '')}"
  end
end

