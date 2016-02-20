class WelcomeController < ApplicationController
  def index
  end

  def show
  end

  def file_upload
    params[:file].tempfile.each_line do |line|
      tokens = line.split(',')
      UserUploaded.create(
          transaction_date: tokens[0],
          description: tokens[1],
          amount: tokens[2])
    end
    redirect_to root_path
  end
end
