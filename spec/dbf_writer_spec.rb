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
    dbf.to_binary_string.should == load_file('single_column')
  end

  it "write a valid double char column empty file" do
    dbf = DbfWriter.new
    dbf.add_field 'data1'
    dbf.add_field 'data2'

    dbf.to_binary_string.should == load_file('double_column')
  end

  private

  def load_file(file)
    File.open("spec/support/sample_dbf/#{file}.dbf",'rb').readlines.join('')
  end

end

