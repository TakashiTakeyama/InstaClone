class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture

    mail to: "t757f37a@gmail.com", subject: "InstaCloneへの投稿の確認メール"
  end
end
