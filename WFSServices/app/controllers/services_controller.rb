class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  authorize_resource


  # GET /services
  # GET /services.json
  # allows search on index page
  def index
    @services = Service.alphabetical.paginate(page: params[:page]).per_page(5)
    @categories = Category.alphabetical
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @s_locations = @service.service_locations
    @s_contacts = @service.service_contacts
    # @s_comments = @service.comments
  end

  # GET /services/new
  def new
    @service = Service.new
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to @service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:name, :description, :philosophy, :entrance_criteria, 
        :exclusion_criteria, :exit_criteria, :level_of_care, :average_length_of_stay, :referral_process,
        :matching_elements, :created_by, :updated_by, :category_id, :contact, :location, :comment_id, 
        :microenterprise, :array_of_services, :created_at, :updated_at, :payment_insurance)
    end
end
