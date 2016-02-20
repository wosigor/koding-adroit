class User
  include Mongoid::Document
  field :transactions, type: Array
end