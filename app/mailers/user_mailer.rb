class UserMailer < ActionMailer::Base
  default from: "noreply@shopify.com"

  def send_receipt(parameters)
    @user = parameters[:user]
    @amount = parameters[:price]
    @address = parameters[:address]
    @products = parameters[:products]
    mail(to: @user.email, subject: "Your receipt details. Thanks for shopping @ shopify")
  end
end
