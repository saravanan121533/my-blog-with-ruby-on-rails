class BlogMailer < ApplicationMailer
  def notify_blog_owner(comment)
    # SYNTAX mail(to: <email>, subject: "<subject>")
    @comment = comment
    @post = comment.post
    @owner = @post.user
    mail(to: @owner.email, subject: "You got a new comment to your blog.")
  end
end
