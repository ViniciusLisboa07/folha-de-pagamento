

class Publisher
  def publish_message(message)
    @connection = Bunny.new(:host => "localhost", :vhost => "/", :user => "guest", :password => "guest")
    @connection.start
    
    channel = @connection.create_channel
    puts " CRIOU"
    queue = channel.queue('folha_pagamento')
    channel.default_exchange.publish(message, routing_key: queue.name)
    channel.close
    puts " [x] Sent 'Hello World!'"
  end

  def connection
    @connection ||= Connection
  end
end
