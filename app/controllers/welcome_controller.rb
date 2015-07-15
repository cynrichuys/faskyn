class WelcomeController < ApplicationController
  def index
  end

  def shop
  end

  def newsletter
  	puts "@@@@@@ check"

  	puts "- start sending"
  	NewsletterMailer.subscribe_email("cynrichuys@gmail.com")
  	puts "- send"
  	render :index
  end
end
