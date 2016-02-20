class Transaction
  @@id = 0

  attr_accessor :id, :date, :description, :amount, :merchant_name, :merchant_category

  def initialize 
    @@id += 1
  end

end