require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CharacterFieldWriter do

  it "should be able to write it's definition as a char field" do
    field = CharacterFieldWriter.new('data', 50)
    field.definition(0).should == "DATA\x00\x00\x00\x00\x00\x00\x00C\x00\x00\x00\x002\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
  end

  it "should be able to output its data in binary format" do
    field = CharacterFieldWriter.new('data', 15)
    field.data('FIELD_DATA').should == " FIELD_DATA     "
  end

end

