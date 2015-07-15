class NewsletterMailer < ApplicationMailer

  default from: "anneke@faskyn.be"

  def subscribe_email(email)
    puts "-- try"
    mail(to: email, subject: 'Ingeschreven op de Faskyn nieuwsbrief!')
  	puts "-- complete"
  end

end
