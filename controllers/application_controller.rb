class ApplicationController
  attr_reader :res
  def initialize(res)
    @res = res
  end

  def render(action_name)
    rendered_content = File.read("./views/layouts/application.html")
    page_content = File.read("./views/#{controller_name}/#{action_name}.html")
    res.body = rendered_content.gsub("YIELD_CONTENT", page_content)
  end

  def controller_name
    self.class.to_s.downcase.gsub(/controller/, "")
  end
end