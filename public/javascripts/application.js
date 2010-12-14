$(document).ready(function() {
  
  $('form.train').submit(function() {
    $.ajax({
      url: $(this).attr('action') + '.json',
      type: 'POST',
      data: {'text': $(this).find('input.text').val()},
      success: function() {
        $(this).closest('tr').addClass('clicked');
        $(this).addClass('marked');
      },
      context: this
    });
    return false;
  });
  
  $('.tweets').tablesorter({
    sortList: [[3,1]], // sort by 4th column DESC
    textExtraction: function(node) {
      if ($(node).data('sortkey')) {
        return $(node).data('sortkey');
      } else {
        return node.innerHTML;
      }
    }
  });
  
});
