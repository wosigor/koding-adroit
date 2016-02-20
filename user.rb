class User

  attr_accessor :transactions
  
  def initialize
     self.transactions = [] # on object creation initialize this to an array
  end
end