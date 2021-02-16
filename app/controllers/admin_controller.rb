class AdminController < ApplicationController
  def show
    @application = ApplicationForm.find(params[:id])
  end
end
