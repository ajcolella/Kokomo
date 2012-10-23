$ ->
	Parse.initialize "HUwQwGcJulMS5IQkqCG1RYtcOPJXiAt526Xx5v9E", "jQX22nTU48FFdReC5XNlbfYskMc8s1xGdRgKT2s1"

	window.App = Ember.Application.create()

	App.islandsController = Ember.ArrayController.create({
	    content: [],
	    alteredContent: (-> 
	        arr = @get("content").toArray().reverse()
	        # Iterate and append a hashtag to each name for internal page link
	        for item in arr
        		item.nameTag = '#' + item.name
        		item.mapFrame = 'https://maps.google.com/maps?q=' + item.location._latitude + ',+' + item.location._longitude + '+(' + item.name + ')&amp;hl=en&amp;ie=UTF8&amp;t=f&amp;ll=' + item.location._latitude + ',' + item.location._longitude + '&amp;spn=0.325385,0.411987&amp;z=10&amp;ecpose=' + item.location._latitude + ',-' + item.location._longitude + ',37367.33,0,6.064,0&amp;iwloc=A&amp;output=embed' #<br /><small><a href="https://maps.google.com/maps?q=37.771008,+-122.41175+({{name}})&amp;hl=en&amp;ie=UTF8&amp;t=f&amp;ll=37.833669,-122.411728&amp;spn=0.325385,0.411987&amp;z=10&amp;ecpose=37.79801412,-122.41172755,37367.33,0,6.064,0&amp;iwloc=A&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></small>'
        		if item.usedInSong then item.usedInSong = 'you know it.' else item.usedInSong = "nope..." 
	        return arr
	    ).property("content.@each").cacheable(),
	    })
	    
	App.Island = Parse.Object.extend("Island")
	App.IslandsCollection = Parse.Collection.extend(model: App.Island)

	islands = new App.IslandsCollection()
	
	islands.comparator = (object) ->
	    object.get 'population'

	islands.fetch success: ->
	  App.islandsController.set "content", islands.models.map((o) ->
	    Ember.Object.create o.attributes
	  )



