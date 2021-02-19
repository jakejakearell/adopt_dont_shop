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

  def shelters
    @shelters = Shelter.reverse_order_by_name
    @pending = Shelter.pending_apps
  end

  def shelter_show
    @shelter = Shelter.find(params[:id])
    @count = Shelter.adoptable_pets(params[:id])
    @adopted = Shelter.adopted_pets(params[:id])
    @age = Shelter.pet_age(params[:id])
    @action_required = Shelter.action_required(params[:id])
  end
end
