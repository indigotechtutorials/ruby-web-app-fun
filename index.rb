require 'webrick'
require 'pry'
require_relative "./controllers/pages_controller"

root = File.expand_path './views'
server = WEBrick::HTTPServer.new Port: 8000

server.mount_proc '/' do |req, res|
  controller = PagesController.new(res)
  controller.home
end

trap 'INT' do server.shutdown end

server.start