$(document).ready(function() {
  
  $('form.train').submit(function() {
    $.ajax({
      url: $(this).attr('action') + '.json',
      type: 'POST',
      data: {'text': $(this).find('input.text').val()},
      success: function() {
        $(this).closest('tr').addClass('clicked');
      },
      context: this
    });
    return false;
  });

});