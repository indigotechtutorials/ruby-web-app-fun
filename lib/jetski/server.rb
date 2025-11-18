require 'webrick'
require 'pry'
require_relative './splash_router'
require_relative './waterfall_controller.rb'
Dir[File.join('..', '..', 'app', 'controllers', '*.rb')].each { |file| require file }

module Jetski
  class Server
    def initialize
    end

    def call
      server = WEBrick::HTTPServer.new Port: 8000

      Jetski::SplashRouter.new(server).call

      trap 'INT' do server.shutdown end

      server.start
    end
  end
end