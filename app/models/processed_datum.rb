class ProcessedDatum
  include Mongoid::Document
  field :transaction_date, type: DateTime
  field :description, type: String
  field :amount, type: BigDecimal
  field :merchant_name, type: String
  field :merchant_category, type: String
end
