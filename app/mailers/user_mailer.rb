class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email, subject: "アカウントの確認"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "パスワードのリセット"
  end
end
