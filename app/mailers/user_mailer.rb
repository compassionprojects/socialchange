class UserMailer < ApplicationMailer
  layout "mailer"

  def notify_new_story
    @user = params[:recipient]
    @story = params[:story]

    # make sure that the email is always sent in the language preferred
    # by the user
    I18n.with_locale(@user.language) do
      mail(
        to: email_address_with_name(@user.email, @user.name),
        subject: t(".subject", title: @story.title)
      )
    end
  end
end
