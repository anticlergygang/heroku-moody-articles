class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_url)

		if @article.save
			session = GoogleDrive::Session.from_config("config.json")
			ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
			ws[(ws.rows.length + 1), 1] = article_url.articleUrl
			render json: @article
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def index
		@articles = Article.all
	end

	private
	def article_url
		params.require(:article).permit(:articleUrl, :status)
	end
end
