class ContactsController < ApplicationController
  def new
    @title = "Contact Us"
    @tab_title = "Email any questions regarding colleges, majors, salaries, etc"
    @meta_description = "This is the Contact Us page for Ask The Grad. Let us know how we're doing"
    @meta_keywords = "ask the grad, ask the grad contact us, information, questions, comments"
    @contact = Contact.new
    session[:school_id_for_major] = nil
    session[:major_id_for_school] = nil
    cleanup_post_flow
    cleanup_autocomplete_search
  end

  def create
    CommentsMailer.delay.deliver_contact_us_email(params[:contact][:name], params[:contact][:email],params[:contact][:reason],params[:contact][:message])
    flash[:success] = "Thanks for your message! We'll get back to you ASAP!"
    redirect_to root_path and return
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :reason, :message)
  end
end
