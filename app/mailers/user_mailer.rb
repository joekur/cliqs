class UserMailer < ActionMailer::Base
  default :from => "invites@cliqs.me"
  
  def domain
    "http://localhost:3000"
  end
  
  def invite_email(hashyToken, emailAdd, senderName, cliqName, message)
    @senderName = senderName
    @cliqName = cliqName
    @message = message
    @url = domain + '/users/useTicket/?token=' + hashyToken
    
    mail(:to => emailAdd, :subject => "You have received a Cliqs invite!")
  end
  
end
