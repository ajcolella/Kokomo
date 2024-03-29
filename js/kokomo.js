// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    var islands;
    Parse.initialize("HUwQwGcJulMS5IQkqCG1RYtcOPJXiAt526Xx5v9E", "jQX22nTU48FFdReC5XNlbfYskMc8s1xGdRgKT2s1");
    window.App = Ember.Application.create();
    App.islandsController = Ember.ArrayController.create({
      content: [],
      alteredContent: (function() {
        var arr, item, _i, _len;
        arr = this.get("content").toArray().reverse();
        for (_i = 0, _len = arr.length; _i < _len; _i++) {
          item = arr[_i];
          item.nameTag = '#' + item.name;
          item.mapFrame = 'https://maps.google.com/maps?q=' + item.location._latitude + ',+' + item.location._longitude + '+(' + item.name + ')&amp;hl=en&amp;ie=UTF8&amp;t=f&amp;ll=' + item.location._latitude + ',' + item.location._longitude + '&amp;spn=0.325385,0.411987&amp;z=10&amp;ecpose=' + item.location._latitude + ',-' + item.location._longitude + ',37367.33,0,6.064,0&amp;iwloc=A&amp;output=embed';
          if (item.usedInSong) {
            item.usedInSong = 'you know it.';
          } else {
            item.usedInSong = "nope...";
          }
        }
        return arr;
      }).property("content.@each").cacheable()
    });
    App.Island = Parse.Object.extend("Island");
    App.IslandsCollection = Parse.Collection.extend({
      model: App.Island
    });
    islands = new App.IslandsCollection();
    islands.comparator = function(object) {
      return object.get('population');
    };
    return islands.fetch({
      success: function() {
        return App.islandsController.set("content", islands.models.map(function(o) {
          return Ember.Object.create(o.attributes);
        }));
      }
    });
  });

}).call(this);
