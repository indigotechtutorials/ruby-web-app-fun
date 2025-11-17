class ApplicationController
  attr_accessor :action_name, :controller_name
  attr_reader :res
  def initialize(res)
    @res = res
  end

  def render
    views_folder = File.join(__dir__, '../../','app', 'views')
    rendered_content = File.read(File.join(views_folder, "layouts", "application.html"))
    page_content = File.read(File.join(views_folder, controller_name, "#{action_name}.html"))
    res.body = rendered_content.gsub("YIELD_CONTENT", page_content)
  end

  # Deprecated
  # def controller_name
  #   self.class.to_s.downcase.gsub(/controller/, "")
  # end
end