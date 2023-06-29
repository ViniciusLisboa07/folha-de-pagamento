require 'bunny'

class Connection < ApplicationRecord
  include Singleton
  attr_reader :connection

  def self.create_channel
    # @connection = Bunny.new(:host => "localhost", :vhost => "/", :user => "guest", :password => "guest")
    # @connection.start
    # puts "CONECTOU"
    
    # @connection
  end
end
