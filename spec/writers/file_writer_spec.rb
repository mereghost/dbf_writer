require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FileWriter" do

  before :each do
    @dbf = FileWriter.new
  end

  it "should accumulate fields" do
    @dbf.add_field('DATA')
    @dbf.fields.size.should == 1
    @dbf.fields[0].should be_a BaseFieldWriter
  end

  it "should write a valid empty file" do
    @dbf.add_field 'data'
    @dbf.to_binary_string.should == load_file('single_column')
  end

  it "write a valid double char column empty file" do
    @dbf.add_field 'data1', length: 150
    @dbf.add_field 'data2'
    @dbf.to_binary_string.should == load_file('double_column')
  end

  it "should accept a field size between 1..255" do
    @dbf.add_field 'data', length: 250
    @dbf.to_binary_string.should == load_file('single_250_column')
    lambda {
      lambda { @dbf.add_field('data2', length: 300) }.should raise_error ArgumentError
    }.should_not change(:fields, :size)
  end

  it "should write a file with 1 column 1 row" do
    @dbf.add_field 'data'
    @dbf.add_row 'FIELD_DATA_USED'
    @dbf.to_binary_string.should == load_file('char_50_single_row')
  end

  it "should write a file with 1 column and 2 rows" do
    @dbf.add_field 'data'
    @dbf.add_row 'FIELD_DATA_USED'
    @dbf.add_row 'SECOND_ROW_DATA'
    @dbf.to_binary_string.should == load_file('char_50_2_rows')
  end

  it "should be able to write a dbf with a date field" do
    @dbf.add_field 'date', type: :date
    @dbf.fields[0].should be_a DateFieldWriter
    @dbf.to_binary_string.should == load_file('single_date_column')
  end

  private

  def load_file(file)
    File.open("spec/support/sample_dbf/#{file}.dbf",'rb').readlines.join('')
  end

end

