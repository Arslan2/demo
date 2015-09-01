class UserMailer < ActionMailer::Base
  default from: "noreply@shopify.com"

  def send_receipt(params)
    @user = params[:user]
    @amount = params[:price]
    @address = params[:address]
    mail(to: @user.email, subject: "Your receipt details. Thanks for shopping @ shopify")
  end
end
