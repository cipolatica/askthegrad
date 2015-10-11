class CommentsMailer < ActionMailer::Base
  #default from: "askthegrad@example.com"

  def deliver_contact_us_email(name, email, reason, message)
    contact_us(name, email, reason, message)
  end

  def deliver_parent_email(review_user, comment)
    parent_comment(review_user, comment)

  end

  def deliver_child_email (user, content, username)
    child_comment(user, content, username)
  end

  def contact_us(name, email, reason, message)
    @name = name
    @email = email
    @reason = reason
    @message = message

    mail to: 'apsilver23@gmail.com', subject: "ATG - Contact Message", from: '"Ask The Grad" <support@askthegrad.com>',body: render_to_string("comments_mailer/contact_us"), content_type:'text/html'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comments_mailer.parent_comment.subject
  #
  def child_comment(user, content, username)
    @user = user
    @content = content
    @username = username

    mail to: user.email, subject: "You received a comment on your thread!", from: '"Ask The Grad" <support@askthegrad.com>',body: render_to_string("comments_mailer/child_comment"), content_type:'text/html'
  end
  def parent_comment(user, comment)
    @user = user
    @comment = comment

    mail to: user.email, subject: "You received a comment on your review!", from: '"Ask The Grad" <support@askthegrad.com>', body: render_to_string("comments_mailer/parent_comment"), content_type:'text/html'
  end
end
