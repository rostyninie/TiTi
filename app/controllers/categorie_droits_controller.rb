class CategorieDroitsController < ApplicationController
  before_action :set_categorie_droit, only: [:show, :edit, :update, :destroy]

  # GET /categorie_droits
  # GET /categorie_droits.json
  def index
    @categorie_droits = CategorieDroit.all
  end

  # GET /categorie_droits/1
  # GET /categorie_droits/1.json
  def show
  end

  # GET /categorie_droits/new
  def new
    @categorie_droit = CategorieDroit.new
  end

  # GET /categorie_droits/1/edit
  def edit
  end

  # POST /categorie_droits
  # POST /categorie_droits.json
  def create
    @categorie_droit = CategorieDroit.new(categorie_droit_params)

    respond_to do |format|
      if @categorie_droit.save
        format.html { redirect_to @categorie_droit, notice: 'Categorie droit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @categorie_droit }
      else
        format.html { render action: 'new' }
        format.json { render json: @categorie_droit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorie_droits/1
  # PATCH/PUT /categorie_droits/1.json
  def update
    respond_to do |format|
      if @categorie_droit.update(categorie_droit_params)
        format.html { redirect_to @categorie_droit, notice: 'Categorie droit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @categorie_droit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorie_droits/1
  # DELETE /categorie_droits/1.json
  def destroy
    @categorie_droit.destroy
    respond_to do |format|
      format.html { redirect_to categorie_droits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categorie_droit
      @categorie_droit = CategorieDroit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categorie_droit_params
      params.require(:categorie_droit).permit(:categorie_id, :droit_id)
    end
end
