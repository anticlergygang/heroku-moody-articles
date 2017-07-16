class ArticleMailer < ApplicationMailer
  default from: 'moodyarticlesdrop@gmail.com'
 
  def article_email(url)
    @url  = url
    mail(to: 'jasonac1994@gmail.com', subject: 'Someone sent a URL to be analyzed')
  end
end
