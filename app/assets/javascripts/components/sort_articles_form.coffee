@SortFilterArticlesForm = React.createClass
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState 
			"#{ valueName }": e.target.value
	handleSubmit: (e) ->
		e.preventDefault()
		$.post '', { sortFilter: @state }, (data) =>
			@props.handleArticleSortFilter data
		, 'JSON'
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
					onChange: @handleValueChange
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "process"
						onChange: @handleValueChange
						'Process'
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "skip"
						onChange: @handleValueChange
						'Skip'
			React.DOM.div
				className: "form-check"
				React.DOM.label
					className: "form-check-label"
					React.DOM.input
						type: "checkbox"
						className: "form-check-input"
						value: "complete"
						onChange: @handleValueChange
						'Complete'
			React.DOM.button
				type: "submit"
				className: "btn btn-primary"
				'Submit'