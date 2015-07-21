require 'objectsframework'
require 'objectsframework/pubsub'

class App < ObjectsFramework::Object
	include ObjectsFramework::PubSub

	publish "time" do |channel|
		while(true)
			channel.send(Time.now.to_s)
			sleep(1)
		end
	end

	def get_index
			response.write File.read("./index.html")
	end
end

run ObjectsFramework::Server.new
