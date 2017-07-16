@SortArticleForm = React.createClass
	getInitialState: ->
		articleOrder: 'descending',
		articleStatusFilter: ['process','skip','complete']
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState 
			"#{ valueName }": e.target.value
	valid: ->
		@state.articleOrder && @state.articleStatusFilter
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '', { sortFilter: @state }, (data) =>
			@props.handleArticleSortFilter data
		, 'JSON'
		@setState @getInitialState()
	render: ->
		React.DOM.form 
			onSubmit: @handleSubmit
			React.DOM.div
				className: "form-group"
				React.DOM.label
					for: "sort"
					'Sort'
				React.DOM.select
					className: "form-control"
					id: "sort"
					React.DOM.option
						value: 'ascending'
						'Ascending'
					React.DOM.option
						value: 'decending'
						'Decending'
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "process"
						'Process'
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "skip"
						'Skip'
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "complete"
						'Complete'
			React.DOM.button
				type: "submit"
				className: "btn btn-primary"
				disabled: !@valid()
				'Submit'