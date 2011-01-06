require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#require File.expand_path(File.dirname(__FILE__) + '/../../lib/writers/field_writers')

describe BaseFieldWriter do
  SUBCLASSES = [CharacterFieldWriter, DateFieldWriter]

  it "should know it's subclasses" do
    BaseFieldWriter.subclasses.size.should == SUBCLASSES.size
    BaseFieldWriter.subclasses.map(&:to_s).sort.should == SUBCLASSES.map(&:to_s).sort
  end
end

