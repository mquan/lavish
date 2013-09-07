window.toggleSpinner = (show=true) ->
	$("div.spinner-container").toggle(show)
	if show
		$("#spinner").spin({
			lines: 15
			length: 20
			width: 8
			radius: 30
			corners: 1
			speed: 1
			color: '#fff'
		})
	else
		$("#spinner").spin(false)

window.submitColors = ->
	toggleSpinner(true)
	$('#customize-form').submit()

window.lavish_parse = (rawless)->
	parser = new(less.Parser)
	parser.parse rawless, (err, tree)->
		if err
			console.log(err)
		else
			css = tree.toCSS()
			$('#css-code').val(css)
			$('#lavish-style').text(css)

		toggleSpinner(false)

$(document).ready ->
	$('.select-color').on 'click', ->
		val = $('.value', this).text()
		$label = $('.color-label', $(this).closest('.btn-group'))
		$('.selected-color', $label).css({"background-color": val})
		$('.selected-value', $label).text(val)
		$("input[data-index='#{$(this).data('index')}']").val(val)
		$(this).closest('.btn-group').removeClass('open')
		submitColors()
		false

	$('.color-input, input.jscolor').on 'change', ->
		submitColors()
