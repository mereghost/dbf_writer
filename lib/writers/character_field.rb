class CharacterFieldWriter < BaseFieldWriter

  def data(data)
    [' ', data.ljust(@length)].pack("aa#{@length}")
  end

end

