Gem::Specification.new do |s|
	s.name = "objectsframework-pubsub"
	s.version = "1.0.0"
	s.licenses = ["MIT"]
	s.summary = "PubSub for ObjectsFramework."
	s.description = "PubSub (with websockets) for ObjectsFramework, documentation see Github"
	s.authors = ["Bram Vandenbogaerde"]
	s.files = ["lib/objectsframework/pubsub.rb"]
	s.homepage = "https://github.com/bramvdbogaerde/objectsframework-pubsub"
	s.add_runtime_dependency "tubesock"
	s.add_runtime_dependency "json"
end
