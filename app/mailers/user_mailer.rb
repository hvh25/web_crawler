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

    mail to: owner.email, subject: "New application for "+job.title+" at Jib.vn"
  end

  def job_weekly(email,jobs,user,keywords)
    @email=email
    @jobs=jobs
    @user=user
    @keywords = keywords

    mail to: email, subject: "New jobs for your search @Jib.vn"
  end

end
