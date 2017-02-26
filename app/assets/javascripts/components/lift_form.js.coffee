@LiftForm = React.createClass
  getInitialState: ->
    date: ''
    name: ''
    is_metric: false
    weight: ''
    reps_performed: ''
    one_rm: 0
    coefficients: {
      1: 1, 2: .943, 3: .906, 4: .881, 5: .851, 6: .831, 7: .807, 8: .786, 9: .765, 10: .744
    }
  calculateOneRm: ->
    if @state.weight and @state.reps_performed
      @state.one_rm = @state.weight / @state.coefficients[@state.reps_performed]
    else
      0
  handleValueChange: (e) ->
    valueName = e.target.name
    @setState "#{ valueName }" : e.target.value
  toggleUnit: (e) ->
    e.preventDefault()
    @setState is_metric: !@state.is_metric
  valid: ->
    @state.date && @state.name && @state.weight && @state.reps_performed && @state.one_rm
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { lift: @state }, (data) =>
      @props.handleNewLift data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'date'
          className: 'form-control'
          placeholder: 'date'
          name: 'date'
          value: @state.date
          onChange: @handleValueChange
        React.DOM.input
          type: 'name'
          className: 'form-control'
          placeholder: 'name'
          name: 'name'
          value: @state.name
          onChange: @handleValueChange
        React.DOM.a
          className: 'btn btn-primary'
          onClick: @toggleUnit
          'Metric = ' + @state.is_metric.toString()
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'weight'
          name: 'weight'
          value: @state.weight
          onChange: @handleValueChange
        React.DOM.input
          type: 'number'
          min: 1
          max: 10
          className: 'form-control'
          placeholder: 'reps_performed'
          name: 'reps_performed'
          value: @state.reps_performed
          onChange: @handleValueChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Create Lift'
        React.createElement OneRmBox, one_rm: @calculateOneRm()