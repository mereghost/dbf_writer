#encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#require File.expand_path(File.dirname(__FILE__) + '/../../lib/writers/field_writers')

describe BaseFieldWriter do
  SUBCLASSES = [CharacterFieldWriter, DateFieldWriter]

  it "should know it's subclasses" do
    BaseFieldWriter.subclasses.size.should == SUBCLASSES.size
    BaseFieldWriter.subclasses.map(&:to_s).sort.should == SUBCLASSES.map(&:to_s).sort
  end

  it "should sanitize it's field name" do
    BaseFieldWriter.new('coisa1').name.should =~ /COISA1/
    BaseFieldWriter.new('COISA').name.should =~ /COISA/
    BaseFieldWriter.new('thingamajic').name.should =~ /^THINGAMAJI$/
    BaseFieldWriter.new('coisa_1').name.should =~ /COISA_1/
    BaseFieldWriter.new('really_long_field_name').name.should =~ /^REALLY_LON$/
    BaseFieldWriter.new('ç~ãááácoisa').name.should =~ /COISA/
    BaseFieldWriter.new('ç').name.should =~ /FIELD/
  end
end

