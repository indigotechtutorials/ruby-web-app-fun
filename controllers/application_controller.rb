class ApplicationController
  attr_accessor :action_name, :controller_name
  attr_reader :res
  def initialize(res)
    @res = res
  end

  def render
    rendered_content = File.read("./views/layouts/application.html")
    page_content = File.read("./views/#{controller_name}/#{action_name}.html")
    res.body = rendered_content.gsub("YIELD_CONTENT", page_content)
  end

  # Deprecated
  # def controller_name
  #   self.class.to_s.downcase.gsub(/controller/, "")
  # end
end