class ArticleMailer < ApplicationMailer
  default from: 'moodyarticlesdrop@gmail.com'
 
  def article_email(url)
    @url  = url
    mail(to: 'find-mood-music@listenloop.com', subject: 'Someone sent a URL to be analyzed!')
  end
end
