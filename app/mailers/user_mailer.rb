class UserMailer < ApplicationMailer
  default from: 'mdxmdx@yopmail.com'
  
  def welcome_email(user)
    #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
    @user = user 

    #on définit une variable @url qu'on utilisera dans la view d’e-mail
    @url  = 'http://monsite.fr/login' 

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Bienvenue chez nous !') 
  end

  def attendance_email(admin, event)
    @admin = admin 
    @url  = 'http://monsite.fr/login' 
    @event = event
    mail(to: @admin.email, subject: 'Inscription à un event!') 
  end
end
