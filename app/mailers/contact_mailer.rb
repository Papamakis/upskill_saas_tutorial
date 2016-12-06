class ContactMailer < ActionMailer::Base
    default to: 'marioswwwe@yahoo.gr'
    
    def contact_email (name, email, body)
        @name= name
        @eamil=email
        @body=body
        
        mail(for: email, subject: 'Contact Form Message')
    end
end

    