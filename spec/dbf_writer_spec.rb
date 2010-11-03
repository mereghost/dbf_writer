require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DbfWriter" do

  it "should accumulate fields" do
    dbf = DbfWriter.new
    dbf.add_field('DATA')
    dbf.fields.size.should == 1
    dbf.fields.should == [{:name => 'DATA', :total_length => 50}]
  end

  it "should write a valid empty file" do
    dbf = DbfWriter.new
    dbf.add_field 'data'
    dbf.to_binary_string.should == File.open('spec/support/sample_dbf/single_column.dbf','rb').readlines.join('')
  end

#  it "should write a single character column DBF" do
#    data = File.open('support/samples/single_column.dbf', 'rb').readlines
#    writer = DbfWriter.new.add_column('DATA')
#    writer.binary.should == data
#  end
end

