@ArticleForm = React.createClass
	getInitialState: ->
		articleUrl: ''
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState 
			"#{ valueName }": e.target.value
			"status": "process"
	valid: ->
		@state.articleUrl.match /(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9]\.[^\s]{2,})/i
	handleSubmitArticle: (e) ->
		e.preventDefault()
		$.post '', { article: @state }, (data) =>
			@props.handleNewArticle data
		, 'JSON'
		@setState @getInitialState()
	render: ->
		React.DOM.form
			className: 'form-input'
			onSubmit: @handleSubmitArticle
			React.DOM.div
				className: 'input-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'ex: https://medium.com/@byrnehobart/the-slow-motion-trainwreck-facing-the-meal-kit-industry-345f14df45ad '
					name: 'articleUrl'
					value: @state.articleUrl
					onChange: @handleValueChange
				React.DOM.span
					className: 'input-group-button'
					React.DOM.button
						className: 'btn btn-danger'
						type: 'submit'
						disabled: !@valid()
						'Send Article URL'