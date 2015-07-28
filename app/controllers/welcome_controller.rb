class WelcomeController < ApplicationController
  def index
  end

  def shop
  end

  def newsletter
  	puts "@@@@@@ check"
    if params[:mailaddress] =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      @user = User.new(name: params[:name], email: params[:mailaddress])

      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver_later
      end
    else
      puts "unvalid mailaddress: #{params[:mailaddress]}"
    end

    render :index
  end

  private
  def is_valid_email?(email)
  (email =~ /^(([A-Za-z0-9]*\.+*_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\+)|([A-Za-z0-9]+\+))*[A-Z‌​a-z0-9]+@{1}((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,4}$/i)
  end
end
