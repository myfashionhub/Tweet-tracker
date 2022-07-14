function doSearch(e) {
  e.preventDefault();
  var formInput = $("#search input[type='text']").val();
  var userId = $('#search').attr('data-user');

  let type;
  if (formInput.indexOf('@') > -1) {
    type = 'username';
  } else if (formInput.indexOf('#') > -1) {
    type = 'hashtag';
  }

  var term = formInput.trim().replace(/@?#?/, '');
  $.ajax({
    url: '/tweets/search',
    type: 'GET',
    dataType: 'json',
    data: { term, type },
    success: function(data) {
      console.log(data)
    }
  });
}
