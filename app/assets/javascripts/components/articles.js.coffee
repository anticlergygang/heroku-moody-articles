@Articles = React.createClass
	getInitialState: ->
		articles: @props.data
	getDefaultProps: ->
		articles: []
	addArticle: (article) ->
		articles = @state.articles.slice()
		articles.push article
		@setState articles: articles
	render: ->
		React.DOM.div
			className: 'articles'
			React.DOM.h3
				className: 'title'
				'Send us a blog atricle that you would like to have anlized by a expert mood musician from ListenLoop.'
			React.createElement ArticleForm, handleNewArticle: @addArticle
			React.DOM.table
				className: 'table table-bordered'
				React.DOM.thead null
					React.DOM.th null, "Article URL"
					React.DOM.th null, "Status"
					React.DOM.th null, "Mood Music URL"
				React.DOM.tbody null,
					for article in @state.articles
						React.createElement Article, key: article.id, article: article