window.lavish_parse = (rawless)->
	parser = new(less.Parser)
	parser.parse rawless, (err, tree)->
		if err
			console.log(err)
		else
			css = tree.toCSS()
			$('#css-code').val(css)
			$('#lavish-style').text(css)

$(document).ready ->
	$('.select-color').on 'click', ->
		val = $('.value', this).text()
		$label = $('.color-label', $(this).closest('.btn-group'))
		$('.selected-color', $label).css({"background-color": val})
		$('.selected-value', $label).text(val)
		$("input[data-index='#{$(this).data('index')}']").val(val)
		$(this).closest('.btn-group').removeClass('open')
		$('#customize-form').submit();
		false

	$('.color-input').on 'change', ->
		$('#customize-form').submit();

	$("#preview-toggle").click ->
		preview("http://getbootstrap.com/examples/theme/")
