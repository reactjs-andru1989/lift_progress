@Lift = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.lift.date
      React.DOM.td null, @props.lift.name
      React.DOM.td null, @props.lift.weight
      React.DOM.td null, @props.lift.is_metric.toString()
      React.DOM.td null, @props.lift.reps_performed
      React.DOM.td null, @props.lift.one_rm