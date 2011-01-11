require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "FileWriter" do

  describe "A new instace" do
    subject { FileWriter.new }

    it "should return the object when a field is added" do
      subject.add_field('data').object_id.should == subject.object_id
    end

    it "should accumulate fields" do
      subject.add_field 'data'
      subject.fields.size.should == 1
      subject.fields[0].should be_a BaseFieldWriter
    end
  end

  describe "File with character fields only" do
    subject { FileWriter.new.add_field 'data' }

    it "should write a valid empty file" do
      subject.to_binary_string.should == load_file('single_column')
    end

    it "write a valid double char column empty file" do
      subject.add_field 'data1', length: 150
      subject.to_binary_string.should == load_file('double_column')
    end

    it "should accept a field size between 1..255" do
      dbf = FileWriter.new
      dbf.add_field 'data', length: 250
      dbf.to_binary_string.should == load_file('single_250_column')
      lambda {
        lambda { dbf.add_field('data2', length: 300) }.should raise_error ArgumentError
      }.should_not change(:fields, :size)
    end

    it "should write a file with 1 column 1 row" do
      subject.add_row 'FIELD_DATA_USED'
      subject.to_binary_string.should == load_file('char_50_single_row')
    end

    it "should write a file with 1 column and 2 rows" do
      subject.add_row 'FIELD_DATA_USED'
      subject.add_row 'SECOND_ROW_DATA'
      subject.to_binary_string.should == load_file('char_50_2_rows')
    end

  end

  describe "with a date field" do
    subject { FileWriter.new.add_field 'date', type: :date }

    it "should be able to write a dbf with a date field" do
      subject.fields[0].should be_a DateFieldWriter
      subject.to_binary_string.should == load_file('single_date_column')
    end

  end

  private

  def load_file(file)
    File.open("spec/support/sample_dbf/#{file}.dbf",'rb').readlines.join('')
  end

end

