class ContactsController < ApplicationController
  
  #GET request to /contact-us
  #show new contact form 
    def new
        @contact = Contact.new
    end
    #POST request /contacts
  def create
    #Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    #Save the object to the database
    if @contact.save
      #Store form filed via paramaters, into variables
      name = params[:contact][:name]
      email = params [:contact][:email]
      body = params [:contact][:comments]
      #plug variables into Contact Mailer
      #email method ans send email
      ContactMailer.contact_email(name, email, body).deliver
      #store succes message in flash hash
      #and redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      #If Contact object doenst save;
      #store errors in flash hash
      #and redirect to the new action
     flash[:danger] = @contact.errors.full_messages.join(", ")
     redirect_to new_contact_path
    end
  end
  
  private
  #To collect data from form we need to use stong parameters
  #and whitelist the form field
  def contact_params
     params.require(:contact).permit(:name, :email, :comments)
  end
end