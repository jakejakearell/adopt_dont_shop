class AdminController < ApplicationController
  def show
    @application = ApplicationForm.find(params[:id])
  end

  def pet_status
    @application = ApplicationForm.find(params[:application_id])
    pet = ApplicationPet.pet_on_app(params[:pet], @application.id)
    pet.update(accepted: params[:approve])
    ApplicationPet.approved?(params[:pet], params[:application_id])
    render :show
  end
end
