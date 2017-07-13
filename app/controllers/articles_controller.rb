class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_url)

		if @article.save
			session = GoogleDrive::Session.from_config("config.json")
			ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
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
