class HomeController < ApplicationController
  def home
    @categories = Category.all
    @posts = Post.all
  end

  def web_developer
    @name = "Ivy Rubi-Olamit"
    @contact = {email: "ivyr.ca@gmail.com",
                mobile: "1-604-716-7533"}
    @links = {linkedin: "https://ca.linkedin.com/in/ivyolamit",
              github: "https://github.com/ivyr"}
  end
end
