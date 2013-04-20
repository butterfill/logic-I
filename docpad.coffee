# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	renderPasses : 1

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		moment:
			require('moment')
			
		# Specify some site properties
		site:
			# The production url of our website
			url: "http://website.com"

			# The default title of our website
			title: "Logic I (PH126)"

			# The website description (for SEO)
			description: """
				Notes for lectures on Logic I (PH126), an introduction to predicate logic.
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				logic, truth, logical validity
				"""


		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')
			
		#list_lectures: ->
		#	titles = []
		#	titles.push(l.title) for l in @getCollection('documents').findAll({basename:/^(fast)?lecture_/}, [basename:1]).toJSON()
		#	titles


	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
	
	collections:
		lectures: -> @getCollection('documents').findAll({basename:/^(fast)?lecture_/}, [basename:1])
		normal_lectures: -> @getCollection('documents').findAll({basename:/^lecture_/}, [basename:1])
		short_lectures: -> @getCollection('documents').findAll({basename:/^short_lecture_/}, [basename:1])
		fast_lectures: -> @getCollection('documents').findAll({basename:$startsWith:'fastlecture_'}, [basename:1])
		units: -> @getCollection('documents').findAll({url:/\/units\/unit_/}, [sequence:1])
}

# Export our DocPad Configuration
module.exports = docpadConfig