require 'open-uri'
require 'net/http'
require 'json'
require 'csv'
require 'openssl'
require_relative 'user'
require_relative 'transaction'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

def extract_merchant(token)
  merchant = ''
  if token.include? "  "
    merchant = /.+?(?=\s\s)/.match(token) 
  else 
    merchant = token
  end
  return merchant
end

def extract_country(token)
  merchant = ''
  if token.include? "  "
    merchant = /.+?(?=\s\s)/.match(token) 
  else 
    merchant = token
  end
  return merchant
end

def run_query(merchant_name)
  uri = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{merchant_name}&key=AIzaSyCfFqNoumcpYEh7fLKlPouPuDeB-_hSGXU")
  response = Net::HTTP.get(uri)
  response
end

def get_merchant_category(merchant_name)
  response = run_query(merchant_name)
  response_json = JSON.parse(response)
  if response_json['status'] == "ZERO_RESULTS"
    merchant_types = "NO TYPE"
  else
    merchant_types = response_json['results'][0]['types']
  end
  merchant_types
end

def process_file(user, file_name)
  CSV.foreach(file_name) do |row|

    transaction = Transaction.new()
    transaction.date = row[0]
    transaction.description = row[1]
    transaction.amount = row[2]
    merchant_name = extract_merchant(row[1])
    transaction.merchant_name = merchant_name
    
    transaction.merchant_category = get_merchant_category(merchant_name)

    user.transactions.push(transaction)

     # save_data(date, description, amount, merchant_name, merchant_types)

  end
end

file = File.open("visa.csv", "r")
user = User.new()
result = process_file(user, file)
  




