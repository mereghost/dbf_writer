require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'date'

describe DateFieldWriter do

  it "should be able to write it's definition as a date field" do
    field = DateFieldWriter.new 'data'
    field.definition(0).should == "DATA\x00\x00\x00\x00\x00\x00\x00D\x00\x00\x00\x00\b\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
  end

  it "should be able to output its data in binary format" do
    field = DateFieldWriter.new 'data'
    field.data(Date.today.to_s).should == ' ' + Date.today.to_s.tr('-','')
  end

end

