class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_url)

		if @article.save
			ArticleMailer.article_email(@article.articleUrl).deliver_now
			session = GoogleDrive::Session.from_config("config.json")
			ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
			ws.reload
			ws[(ws.rows.length + 1), 1] = @article.articleUrl
			ws[(ws.rows.length), 2] = 'process'
			ws.save
			render json: @article
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def index
		if params[:orderFilta] and params[:orderFilta][:filta] != 'all'
			puts params[:orderFilta][:filta]
			@articles = Article.where(status: params[:orderFilta][:filta])
			puts @articles
		else
			@articles = Article.all()
			puts @articles
		end
		render
	end

	private
	def article_url
		params.require(:article).permit(:articleUrl, :status)
	end

	private
	def order_filta
		params.require(:orderFilta).permit(:order, :filta)
	end
end
