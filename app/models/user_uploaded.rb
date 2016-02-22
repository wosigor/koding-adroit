class UserUploaded
  include Mongoid::Document
  embeds_many :transaction_lines
end