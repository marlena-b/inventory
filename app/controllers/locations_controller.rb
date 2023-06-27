class LocationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def index
    @locations = Location.all
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update
      redirect_to @location
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    location = Location.find(params[:id])
    location.destroy
    redirect_to locations_url, status: :see_other
  end

  private

  def location_params
    params.require(:location).permit(:name, :address)
  end
end