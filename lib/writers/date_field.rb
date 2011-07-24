# Writes Date fields as per specification.
class DateFieldWriter < BaseFieldWriter

  def self.type
    :date
  end

  def initialize(field_name, options = {})
    @type = "D"
    @length = 8
    super(field_name, options)
  end

  # Outputs the data as binary (simple string in this case).
  # TODO: Parse the date to check if it's valid.
  def data(content)
    " #{content.gsub(/\D/, '')}"
  end
end

