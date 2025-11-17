require_relative "./application_controller"

class PagesController < ApplicationController
  def home
    render("home")
  end
end