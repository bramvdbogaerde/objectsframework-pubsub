require 'json'
require 'tubesock'

module ObjectsFramework
	module PubSub
		@@channels = {}

		def self.included(child)
			child.add_hook :filter => "request.capture", :method => "pubsub_capture_request"
			child.extend ClassExtend
		end

		def pubsub_capture_request
			# TODO: hijack rack request

			if(@env["HTTP_UPGRADE"] == "websocket")
				# Request is websockets hijacking
				tubesock = Tubesock.hijack(@env)

				@@channels[request.path.split("/")[2]].sockets << tubesock

				tubesock.onclose do
						@@channels[request.path.split("/")[2]].sockets.delete(tubesock)
				end

				tubesock.listen

				[-1, {}, []]
			else
				return continue
			end
		end

		module ClassExtend
			def publish(channelName)
				channels = class_variable_get(:@@channels)
				channel = ObjectsFramework::PubSub::Channel.new(channelName)

				Thread.new do
					yield channel
				end

				channels[channelName] = channel

				class_variable_set(:@@channels, channels)
			end
		end

		class Channel
			attr_accessor :sockets

			def initialize(channelName)
				@channelName = ""
				@sockets = []
			end


			def send(message)
				@sockets.each do |socket|
					socket.send_data message
				end
			end
		end
	end
end
