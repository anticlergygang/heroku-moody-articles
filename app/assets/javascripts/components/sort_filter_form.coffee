@ArticleOrderFiltaForm = React.createClass
	getInitialState: ->
		order: ''
		filta: ''
	handleValueChange: (e) ->
		valueName = e.target.name
		@setState "#{ valueName }": e.target.value
	valid: ->
		(@state.order == 'a' || @state.order == 'd') && (@state.filta == 'a' || @state.filta == 'p' || @state.filta == 'c' || @state.filta == 's')
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
					placeholder: '(a)scending/(d)escending'
					name: 'order'
					value: @state.order
					onChange: @handleValueChange
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: '(a)ll/(p)rocess/(s)kip/(c)omplete'
					name: 'filta'
					value: @state.filta
					onChange: @handleValueChange
				React.DOM.span
					className: 'input-group-button'
					React.DOM.button
						className: 'btn btn-danger'
						type: 'submit'
						disabled: !@valid()
						'Set Order/Fliter'