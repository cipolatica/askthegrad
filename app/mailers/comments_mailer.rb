class CommentsMailer < ActionMailer::Base
  default from: "askthegrad@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comments_mailer.parent_comment.subject
  #
  def child_comment(user, content, username)
    @user = user
    @content = content
    @username = username

    mail to: user.email, subject: "You received a comment on your thread!", from: "askthegrad@example.com"
  end
  def parent_comment(user, comment)
    @user = user
    @comment = comment

    mail to: user.email, subject: "You received a comment on your review!", from: "askthegrad@example.com"
  end
end
