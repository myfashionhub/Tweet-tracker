//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function() {
    $('form#search').submit(doSearch);
});


$(function(){
  var newFeed = new Feed();
  //newFeed.fetch();
})