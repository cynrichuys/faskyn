class UserMailer < ApplicationMailer
	default from: 'web@faskyn.be'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: "#{@user.name}, Welcome to My Awesome Site")
  end

end
