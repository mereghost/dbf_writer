require '../../lib/dbf_writer'

class Product
  include DbfWriter

  attr_accessor :name, :amount, :price, :purchased_on

  dbf_export :name => 'NAME'
end

