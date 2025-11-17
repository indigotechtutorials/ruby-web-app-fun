require 'webrick'
require 'pry'
# require_relative "./controllers/pages_controller"

server = WEBrick::HTTPServer.new Port: 8000

Dir[File.join(__dir__, 'controllers', '*.rb')].each { |file| require file }

routes_file = "./config/routes.rb"

File.readlines(routes_file, chomp: true).each do |line|
  route_action = line.split(" ")[0]
  controller_mapping = line.split(" ")[1].gsub(/\"/, "")
  controller_name = controller_mapping.split("#")[0]
  action_name = controller_mapping.split("#")[1]
  
  served_url = case route_action
  when "root"
    "/"
  end
  server.mount_proc served_url do |req, res|
    controller_class = Object.const_get("#{controller_name.capitalize}Controller")
    controller = controller_class.new(res)
    controller.send(action_name)
  end
end

trap 'INT' do server.shutdown end

server.start