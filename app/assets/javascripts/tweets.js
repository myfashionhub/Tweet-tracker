function Tweet(tweetJson){
  this.handle  = tweetJson.handle;
  this.content = tweetJson.content;
  this.url     = tweetJson.url;
  this.id      = tweetJson.id;
}

function TweetView(model){
  this.model = model;
  this.el    = undefined;
}

TweetView.prototype.render = function(){
  var newLi = $('<li>').html(this.model.handle+': '+this.model.content)
  var link = $('<a>').attr('href', this.model.url).html(this.model.url)
  newLi.append(link);
  this.el = newLi;
  return this;
}

function Feed(){
  this.models = {};
}

Feed.prototype.add = function(tweetJson){
  var newTweet = new Tweet(tweetJson);
  this.models[tweetJson.id] = newTweet; 
  return this;  
}

Feed.prototype.fetch = function(){
  var that = this;
  $.ajax({
    url: '/tweets',
    dataType: 'json',
    success: function(data){
      for (var i = 0; i < data.length; i++){
        that.add(data[i]);
      }
    }  
  })
};
