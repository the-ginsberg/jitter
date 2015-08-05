class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "WynHooked - Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "WynHooked - Password reset"
  end

end
