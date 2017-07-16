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
							for: 'filter
							'Filter'
						React.DOM.select 
							id: 'filter
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