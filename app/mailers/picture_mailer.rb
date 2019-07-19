class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture

    mail to: "t757f37a@gmail.com", subject: "お問い合わせの確認メール"
  end
end
