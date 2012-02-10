module TicketsHelper
  include RegexHelper
  
  def check_ticket(token)
    purge_tickets
    return Ticket.where(:token => token).first
  end
  
  def purge_tickets
    Ticket.destroy_all(["created_at < ?", Time.now.utc - 7.days])
  end
  
  def send_cliq_invites(invites_csv, message, cliq, sender)
    emails = invites_csv.split(',')
    emails = emails.map {|e| e.strip} #remove whitespace
    emails.each do |email|
      if regex_validates(email, email_regex)
        hashyToken = Digest::MD5.hexdigest(Time.now.to_s()+rand.to_s())
        
        # create ticket
        ticket = Ticket.new
        ticket.email = email
        ticket.token = hashyToken
        ticket.cliq_id = cliq.id
        
        if ticket.save
          # send email
          UserMailer.invite_email(hashyToken, email, sender.name, cliq.name, message).deliver
        end 
        
      end
    end
  end
  
  
end