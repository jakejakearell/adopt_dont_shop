class AdminController < ApplicationController
  def show
    @application = ApplicationForm.find(params[:id])
  end

  def pet_status
    if params[:approve] == "true"
      @application = ApplicationForm.find(params[:application_id])
      pet = ApplicationPet.where("pet_id = ? AND application_form_id = ?", params[:pet], @application.id)
      pet.update(accepted: params[:approve])
      render :show
    end
  end
end
