@ArticleForm = React.createClass
	getInitialState: ->
		articleUrl: ''
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState 
			"#{ valueName }": e.target.value
			"status": "process"
	valid: ->
		@state.articleUrl
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '', { article: @state }, (data) =>
			@props.handleNewArticle data
			# @setState @getInitialState()
		, 'JSON'
	render: ->
		React.DOM.form
			className: 'form-input'
			onSubmit: @handleSubmit
			React.DOM.div
				className: 'input-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Enter an articles URL to get some mood music!'
					name: 'articleUrl'
					value: @state.articleUrl
					onChange: @handleValueChange
				React.DOM.span
					className: 'input-group-button'
					React.DOM.button
						className: 'btn btn-danger'
						type: 'submit'
						disabled: !@valid()
						'Search for some music!'