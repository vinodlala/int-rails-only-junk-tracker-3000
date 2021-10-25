class VehiclesController < ApplicationController
  before_action :set_vehicle, only: %i[ show edit update destroy ]
  before_action :set_statuses, only: %i[ show new edit create update ]
  before_action :set_vehicle_types, only: %i[ show new edit create update ]

  # GET /vehicles or /vehicles.json
  def index
    @vehicles = Vehicle.all
  end

  # GET /vehicles/1 or /vehicles/1.json
  def show
  end

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
  end

  # POST /vehicles or /vehicles.json
  def create
    @vehicle = Vehicle.new(vehicle_params)

    @vehicle.registration_id = VehicleRegistrationService.register_vehicle @vehicle

    @vehicle.vehicle_type = vehicle_type(params.require(:vehicle).permit(:vehicle_type))

    respond_to do |format|
      if @vehicle.save && @vehicle.vehicle_type.save
        format.html { redirect_to @vehicle, notice: "Vehicle was successfully created." }
        format.json { render :show, status: :created, location: @vehicle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vehicles/1 or /vehicles/1.json
  def update
    @vehicle.vehicle_type = vehicle_type(params.require(:vehicle).permit(:vehicle_type))

    respond_to do |format|
      if @vehicle.update(vehicle_params) && @vehicle.vehicle_type.save
        format.html { redirect_to @vehicle, notice: "Vehicle was successfully updated." }
        format.json { render :show, status: :ok, location: @vehicle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vehicle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vehicles/1 or /vehicles/1.json
  def destroy
    @vehicle.destroy
    respond_to do |format|
      format.html { redirect_to vehicles_url, notice: "Vehicle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vehicle_params
      params.require(:vehicle).permit(:nickname, :mileage, :wheels, :engine_status)
    end

  def set_statuses
    @statuses = [
      [ "", "" ],
      [ "Works", "works" ],
      [ "Fixable", "fixable" ],
      [ "Junk", "junk"],
    ]
  end

  def set_vehicle_types
    @vehicle_types = [
      [ "Coupe", "Coupe" ],
      [ "Sedan", "Sedan" ],
      [ "MiniVan", "MiniVan" ],
      [ "Motorcycle", "Motorcycle" ],
    ]
  end

  def vehicle_type(vehicle_type)
    case vehicle_type["vehicle_type"]
    when 'Coupe'
      Coupe.new(params.require(:vehicle).permit(:doors))
    when 'Sedan'
      Sedan.new(params.require(:vehicle).permit(:doors))
    when 'MiniVan'
      MiniVan.new(params.require(:vehicle).permit(:doors))
    when 'Motorcycle'
      Motorcycle.new(params.require(:vehicle).permit(:seat_status))
    end
  end
end
