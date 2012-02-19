// placeholder function for input fields
$('[placeholder]').focus(function() {
  var input = $(this);
  if (input.val() == input.attr('placeholder')) {
    input.val('');
    input.removeClass('placeholder');
  }
}).blur(function() {
  var input = $(this);
  if (input.val() == '' || input.val() == input.attr('placeholder')) {
    input.addClass('placeholder');
    input.val(input.attr('placeholder'));
  }
}).blur();

$(document).ready(function() {
	
	$('form.loading').submit(function() {
		$(this).children('img.loading').show();
		$(this).children('input:last').remove();
		return true;
	});
	
});

