class ArticlesController < ApplicationController
	def create
		@article = Article.new(article_url)

		if @article.save
			puts 'test'
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
