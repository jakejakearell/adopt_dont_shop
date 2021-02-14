class ApplicationFormsController < ApplicationController
  def index
    @applications = ApplicationForm.all
  end

  def show
    @application = ApplicationForm.find(params[:id])
  end

  def new
  end

  def create
    pet_application = ApplicationForm.new(application_params)
    if pet_application.save
      redirect_to "/applications/#{pet_application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      render :new
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :reviewed, :accepted)
  end
end
