function doSearch(e) {
  e.preventDefault();
  var formInput = $("#search input[type='text']").val();
  var userId = $('#search').attr('data-user');
  console.log()
  if (formInput.indexOf('@') > -1) {
    var term = formInput.replace('@', '');
    $.ajax({
      url: '/users/'+userId+'/tweets/find',
      type: 'POST',
      dataType: 'json',
      data: { handle: term }, 
      success: function(data) {
        console.log(data)
      }
    });
  } else if (formInput.indexOf('#') > -1) {
      var term = formInput.replace('#', '');
  } else {  
  }
}