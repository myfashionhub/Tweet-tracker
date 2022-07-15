function doSearch(e) {
  e.preventDefault();
  var formInput = $("#search input[type='text']").val();
  var userId = $('#search').attr('data-user');

  let type;
  if (formInput.indexOf('@') > -1) {
    type = 'username';
  }

  var term = formInput.trim().replace(/@?/, '');
  $.ajax({
    url: '/search',
    type: 'GET',
    dataType: 'json',
    data: { term, type, count: 10 },
    success: function(data) {
      renderTweets(data);
    }
  });
}

function renderTweets(allTweets) {
  this.init = () => {
    $('.search-results').empty();

    if (!allTweets.length) {
      $('.search-results').html('No tweet found.');
      return;
    }

    allTweets.forEach((tweetData) => {
      const tweetView = TweetView(tweetData);
      $('.search-results').append(tweetView.render());
    });
  };

  this.init();
}
