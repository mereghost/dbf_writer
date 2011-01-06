require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#require File.expand_path(File.dirname(__FILE__) + '/../../lib/writers/field_writers')

describe BaseFieldWriter do
  it "should know it's subclasses" do
    BaseFieldWriter.subclasses.size.should == subclasses_for(BaseFieldWriter).size
    BaseFieldWriter.subclasses.map(&:to_s).sort.should == subclasses_for(BaseFieldWriter).map(&:to_s).sort
  end

  private
  def subclasses_for(klass)
    subclasses = []
    ObjectSpace.each_object(Class) do |clazz|
      subclasses << clazz if clazz.ancestors.include? klass and clazz != klass
    end
    subclasses
  end

end

