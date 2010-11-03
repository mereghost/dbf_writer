require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DbfWriter" do

  it "should accumulate fields" do
    dbf = DbfWriter.new
    dbf.add_field('DATA')
    dbf.fields.size.should == 1
    dbf.fields.should == ['DATA']
  end

#  it "should write a single character column DBF" do
#    data = File.open('support/samples/single_column.dbf', 'rb').readlines
#    writer = DbfWriter.new.add_column('DATA')
#    writer.binary.should == data
#  end
end

