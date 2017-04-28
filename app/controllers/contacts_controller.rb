class ContactsController < ApplicationController
    #Show new contact form
    #TODO: Don't show completely new form when error
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        #Mass assignment of form fields
       @contact = Contact.new(contact_params) 
       
       if @contact.save
           name = params[:contact][:name]
           email = params[:contact][:email]
           body = params[:contact][:comments]
           
           #Plug variables into Contact Mailer email method and send the mail
           ContactMailer.contact_email(name, email, body).deliver
           flash[:success] = "Message sent."
           redirect_to contact_us_path
       else
           flash[:danger] = @contact.errors.full_messages.join(", ")
           redirect_to contact_us_path
       end
    end
    
    private 
        # To collect data from form, strong parameters have to be used
        # and form fields have to be whitelisted
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end