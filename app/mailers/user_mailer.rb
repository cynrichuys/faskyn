class UserMailer < ApplicationMailer
	default from: "\"Faskyn web\" <web@faskyn.be>"
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'

	attachments.inline['header.png'] = File.read(Rails.root + "public/header.png")

    mail(to: @user.email, subject: "#{@user.name}, welkom bij Faskyn!")
  end

  def new_order_email1(id, name, email)
  	@id = id
  	@name = name
  	@email = email

	mail(to: 'cynrichuys@gmail.com', subject: 'Nieuwe bestelling (ophalen)')
  end

  def new_order_email2(id, name, email, street, streetnumber, postalcode, city)
  	@id = id
  	@name = name
  	@email = email
  	@street = street
  	@streetnumber = streetnumber
  	@postalcode = postalcode
  	@city = city

	mail(to: 'cynrichuys@gmail.com', subject: 'Nieuwe bestelling (verzenden)')
  end


  def order_email1(id, name, email)
  	@id = id
  	@name = name

  	attachments.inline['header.png'] = File.read(Rails.root + "public/header.png")

	mail(to: email, subject: 'Informatie i.v.m. uw aanvraag/bestelling')
  end

  def order_email2(id, name, email, street, streetnumber, postalcode, city)
  	@id = id
  	@name = name
  	@street = street
  	@streetnumber = streetnumber
  	@postalcode = postalcode
  	@city = city

  	attachments.inline['header.png'] = File.read(Rails.root + "public/header.png")

	mail(to: email, subject: 'Informatie i.v.m. uw aanvraag/bestelling')
  end
end
