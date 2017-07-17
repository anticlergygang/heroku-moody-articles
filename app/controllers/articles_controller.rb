class ArticlesController < ApplicationController
	def checkSheetForChanges()
		session = GoogleDrive::Session.from_config("config.json")
		ws = session.spreadsheet_by_key("1klCFgSwetuuQlkM4llE2hjXQcVZX-wUNkDaWWoVs7ds").worksheets[0]
		itt = 1
		numRows = ws.num_rows + 1
		while itt < numRows  do
			a = Article.where(articleUrl: ws[itt,1]).first
			if ws[itt,2] != a.status
				a.status = ws[itt,2]
				a.save
			end
			if ws[itt,3] != a.moodMusicURL
				a.moodMusicURL = ws[itt,3]
				a.save
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
				if params[:orderFilta][:order] == 'ascending'
					@articles = @articles.reverse
				end
				render json: @articles
			else
				if params[:orderFilta][:filta] == 'process'
					@articles = Article.all()
					if params[:orderFilta][:order] == 'ascending'
						@articles = @articles.reverse
					end
					render json: @articles
				else
					if params[:orderFilta][:filta] == 'skip'
						@articles = Article.all()
						if params[:orderFilta][:order] == 'ascending'
							@articles = @articles.reverse
						end
						render json: @articles
					else
						if params[:orderFilta][:filta] == 'complete'
							@articles = Article.all()
							if params[:orderFilta][:order] == 'ascending'
								@articles = @articles.reverse
							end
							render json: @articles
						end
					end
				end
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