class UserMailer < ActionMailer::Base
  default from: "hieu.ha.drexel@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.newapp_notice.subject
  #
  def newapp_notice(owner,job,jobapp)
    @job = job
    @jobapp = jobapp
    @owner = owner
    @url  = "Jib.vn"

    mail to: owner.email, subject: "New application for your job posting at Jib.vn"
  end
end
