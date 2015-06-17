local app = {}
app.debugFlag = true

app.getDebugFlag = function()
	return app.debugFlag
end

app.setDebugFlag = function(flag)
	app.debugFlag = flag
end

return app