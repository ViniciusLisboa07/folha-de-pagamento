require 'bunny'

class RabbitMQConnection
  def self.create_channel
    conn = Bunny.new(config)
    conn.start
    channel = conn.create_channel
    channel
  end

  private

  def self.config
    {
      host: localhost
      port: 8080
      username: guest
      password: guest
      vhost: '/'
    }
  end
end
