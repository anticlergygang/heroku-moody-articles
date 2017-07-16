@ArticleOrderFiltaForm = React.createClass
	getInitialState: ->
		order: 'decending'
		filta: 'all'
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState "#{ valueName }": e.target.value
	valid: ->
		@state.order && @state.filta
	handleSubmitOrderFilta: (e) ->
		e.preventDefault()
		$.get '', { orderFilta: @state }, (data) =>
			@props.handleNewOrderFilta data
		, 'JSON'
		@setState @getInitialState()
	render: ->
		React.DOM.form
			className: 'form-input'
			onSubmit: @handleSubmitOrderFilta
			React.DOM.div
				className: 'input-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'order'
					name: 'order'
					value: @state.order
					onChange: @handleValueChange
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'fliter'
					name: 'flita'
					value: @state.flita
					onChange: @handleValueChange
				React.DOM.span
					className: 'input-group-button'
					React.DOM.button
						className: 'btn btn-danger'
						type: 'submit'
						disabled: !@valid()
						'Send'