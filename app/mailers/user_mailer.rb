class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default :from => "invites@cliqs.me"
  
  def domain
    if Rails.env.production?
      "http://www.cliqs.me"
    else
      "http://localhost:3000"
    end
  end
  
  def invite_email(hashyToken, emailAdd, senderName, cliqName, message)
    @senderName = senderName
    @cliqName = cliqName
    @message = message
    @url = domain + '/users/useTicket/?token=' + hashyToken
    
    mail(to: emailAdd, subject: "You have received a Cliqs invite!")
  end

  def notification_email(object, user)
    @object = object
    mail(to: user.email, from: "noreply@cliqs.me", subject: "Cliqs Notification")
  end
  
end
