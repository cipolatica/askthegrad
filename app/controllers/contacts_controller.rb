class ContactsController < ApplicationController
  def new
    @title = "Contact Us"
    @contact = Contact.new
  end

  def create
    CommentsMailer.delay.deliver_contact_us_email(params[:contact][:name], params[:contact][:email],params[:contact][:reason],params[:contact][:message])
    flash[:notice] = "Thanks for your message! We'll get back to you ASAP!"
    redirect_to root_path and return
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :reason, :message)
  end
end