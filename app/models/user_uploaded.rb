class UserUploaded
  include Mongoid::Document
  field :transaction_date, type: DateTime
  field :description, type: String
  field :amount, type: BigDecimal
  field :merchant_name, type: String
  field :merchant_types, type: Array


  def description= description
    merchant = ''
    if description.include? "  "
      merchant = /.+?(?=\s\s)/.match(description) 
    else 
      merchant = description
    end
    self.merchant_name = merchant
    super
  end

  def merchant_name= merchant_name
    uri = URI("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{merchant_name}&key=AIzaSyCfFqNoumcpYEh7fLKlPouPuDeB-_hSGXU")
    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)
    if json_response['status'] == "ZERO_RESULTS"
      self.merchant_types = ["NO TYPE"]
    else
      self.merchant_types = json_response['results'][0]['types']
    end
    super
  end
end
