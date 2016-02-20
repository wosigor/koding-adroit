class UserUploaded
  include Mongoid::Document
  field :transaction_date, type: DateTime
  field :description, type: String
  field :amount, type: BigDecimal
end
