window.TweetView = (model) => {
  this.model = model;
  this.el    = undefined;

  this.render = () => {
    const newLi = $('<li>');
    const user = $('<a>')
      .attr('href', `http://twitter.com/${this.model.handle}`)
      .attr('target', '_blank')
      .html(`@${this.model.handle}`);
    const separator = $('<span>').html(': ');
    const tweet = $('<a>').attr('href', this.model.link).attr('target', '_blank');
    tweet.html(this.model.content);

    newLi.append(user).append(separator).append(tweet);
    this.el = newLi;
    return newLi;
  }

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
