class WelcomeController < ApplicationController
  def index
  end

  def show
    uploads = UserUploaded.all.group_by {|d| d.transaction_date.strftime('%Y-%m') }
    values = uploads.inject({}) do |hash, (key,val)|
      types = {}
      total_amount_per_category = {}
      val.each do |upload|
        type = upload.merchant_types[0]
        if types.has_key? type
          types[type] += 1
          total_amount_per_category[type] += upload.amount.to_f.abs
        else
          types[type] = 1
          total_amount_per_category[type] = upload.amount.to_f.abs
        end
      end
      type_hash = {}
      types.keys.each do |key|
        type_hash[key] ={amount:total_amount_per_category[key], count:types[key]}
      end
      hash.merge({key => {types: type_hash, transactions: val}})
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: values }
    end
  end

  def file_upload
    transaction_column = params[:transaction_column].to_i
    decription_column = params[:decription_column].to_i
    amount_column = params[:amount_column].to_i
    params[:file].tempfile.each_line do |line|
      tokens = line.split(',')
      UserUploaded.create(
          transaction_date: Date.strptime(tokens[transaction_column], '%m/%d/%Y'),
          description: tokens[decription_column],
          amount: tokens[amount_column])
    end
    redirect_to show_path
  end
end
