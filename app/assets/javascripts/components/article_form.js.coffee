@ArticleForm = React.createClass
	getInitialState: ->
		articleUrl: ''
		sort: 'decending'
		filter: 'all'
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState 
			"#{ valueName }": e.target.value
			"status": "process"
	valid: ->
		@state.articleUrl
	handleSubmitArticle: (e) ->
		e.preventDefault()
		$.post '', { article: @state }, (data) =>
			@props.handleNewArticle data
		, 'JSON'
		@setState @getInitialState()
	handleSubmitSortFilter: (e) ->
		e.preventDefault()
		$.get '', { sortFilter: @state }, (data) =>
			@props.handleNewSortFilter data
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
						'Send'
		React.DOM.form 
			onSubmit: @handleSubmitSortFilter
			React.DOM.div 
				className: 'form-inline'
				React.DOM.div 
					className: 'form-group'
					React.DOM.label 
						for: 'sort'
						'Sort'
					React.DOM.select 
						id: 'sort'
						React.DOM.option 
							name: 'sortOption'
							value: 'decending'
							'decending'
						React.DOM.option 
							name: 'sortOption'
							value: 'ascending'
							'ascending'
					React.DOM.div 
						className: 'form-group'
						React.DOM.label 
							for: 'filter'
							'Filter'
						React.DOM.select 
							id: 'filter'
							React.DOM.option 
								name: 'filterOption'
								value: 'all'
								'all'
							React.DOM.option 
								name: 'filterOption'
								value: 'process'
								'process'
							React.DOM.option 
								name: 'filterOption'
								value: 'skip'
								'skip'
							React.DOM.option 
								name: 'filterOption'
								value: 'complete'
								'complete'
					React.DOM.div 
						className: 'form-group'
							React.DOM.button 
								className: 'btn btn-sm btn-danger'
								type: 'submit'
								'Set sort/filter'