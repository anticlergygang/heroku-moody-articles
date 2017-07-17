class ArticlesController < ApplicationController
	def checkSheetForChanges()
		session = GoogleDrive::Session.from_config("config.json")
		ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
		itt = 1
		numRows = ws.num_rows + 1
		while itt < numRows  do
			a = Article.where(articleUrl: ws[itt,1]).first
			if ws[itt,2] != a.status
				puts 'status change'
				a.status = ws[itt,2]
				a.save
			else
				puts 'no status change'
			end
			if ws[itt,3] != a.moodMusicURL
				puts 'moodMusicURL change'
				a.moodMusicURL = ws[itt,3]
				a.save
			else
				puts 'no moodMusicURL change'
			end
			itt +=1
		end
	end

	def create
		@article = Article.new(article_url)
		if @article.save
			checkSheetForChanges
			ArticleMailer.article_email(@article.articleUrl).deliver_now
			session = GoogleDrive::Session.from_config("config.json")
			ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
			ws[(ws.rows.length + 1), 1] = @article.articleUrl
			ws[(ws.rows.length), 2] = 'process'
			ws.save
			render json: @article
		else
			render json: @article.errors, status: :unprocessable_entity
		end
	end

	def index
		checkSheetForChanges
		if params[:orderFilta]
			if params[:orderFilta][:filta] == 'all'
				@articles = Article.all()
				render json: @articles
			else
				@articles = Article.where(status: params[:orderFilta][:filta])
				render json: @articles
			end
		else
			@articles = Article.all()
		end
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