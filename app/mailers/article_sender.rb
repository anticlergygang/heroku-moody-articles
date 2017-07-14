class ArticleSender < ApplicationMailer
  default :from => 'moody-articles@noreply.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_article(article)
  	@article = article
    mail( :to => 'jasonac1994@gmail.com',
    :subject => 'Article url' )
  end
end