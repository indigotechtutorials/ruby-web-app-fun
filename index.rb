require 'webrick'
require 'pry'
# require_relative "./controllers/pages_controller"

server = WEBrick::HTTPServer.new Port: 8000

Dir[File.join(__dir__, 'app', 'controllers', '*.rb')].each { |file| require file }

routes_file = "./config/routes.rb"

# Convert routes file into render of correct controller and action

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
    controller.action_name = action_name
    controller.controller_name = controller_name
    controller.send(action_name)
    controller.render
  end
end

# Render css via url

css_files = Dir[File.join(__dir__, 'app', 'assets', 'stylesheets', '*.css')]
css_files.each do |file_path|
  filename = file_path.split("/").last
  asset_url = "/assets/#{filename}"
  puts "Asset url: #{asset_url}"
  server.mount_proc asset_url do |req, res|
    res.body = File.read("app/assets/stylesheets/#{filename}")
  end
end

trap 'INT' do server.shutdown end

server.start