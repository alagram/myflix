class MyflixMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail from: 'albert.agram@gmail.com', to: user.email, subject: "Welcome to MyFlix!"
  end
end