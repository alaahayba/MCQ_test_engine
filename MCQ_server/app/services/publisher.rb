require 'bunny'
class Publisher
  class << self
    def publish(queue_name, message = {})
      @queue ||= channel.queue(queue_name)
      channel.default_exchange.publish(message.to_json, routing_key: @queue.name)
      # x = channel.fanout("crawler.#{exchange}")
      # x.publish(message.to_json)
    end
    def channel
      @channel ||= connection.create_channel
    end
    def connection
      @connection ||=  Bunny.new(host: ENV["RMQ_HOST"]).tap(&:start)
      # Bunny.new.tap(&:start)
    end
  end
end