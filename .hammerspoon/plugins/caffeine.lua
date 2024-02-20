function toggleCaffeine()
	result = hs.caffeinate.toggle("displayIdle")
	if result then
		hs.alert.show("Caffeine ON")
	else
		hs.alert.show("Caffeine OFF")
	end
end
