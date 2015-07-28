class UserMailer < ApplicationMailer
	default from: "\"Faskyn web\" <web@faskyn.be>"
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'

	attachments.inline['header.png'] = File.read(Rails.root + "public/header.png")

    mail(to: @user.email, subject: "#{@user.name}, welkom bij Faskyn!")
  end

end
