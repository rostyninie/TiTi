class CategoriSalairesController < ApplicationController
  before_action :set_categori_salaire, only: [:show, :edit, :update, :destroy]

  # GET /categori_salaires
  # GET /categori_salaires.json
  def index
    @categori_salaires = CategoriSalaire.all
  end

  # GET /categori_salaires/1
  # GET /categori_salaires/1.json
  def show
  end

  # GET /categori_salaires/new
  def new
    @categori_salaire = CategoriSalaire.new
  end

  # GET /categori_salaires/1/edit
  def edit
  end

  # POST /categori_salaires
  # POST /categori_salaires.json
  def create
    @categori_salaire = CategoriSalaire.new(categori_salaire_params)

    respond_to do |format|
      if @categori_salaire.save
        format.html { redirect_to @categori_salaire, notice: 'Categori salaire was successfully created.' }
        format.json { render action: 'show', status: :created, location: @categori_salaire }
      else
        format.html { render action: 'new' }
        format.json { render json: @categori_salaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categori_salaires/1
  # PATCH/PUT /categori_salaires/1.json
  def update
    respond_to do |format|
      if @categori_salaire.update(categori_salaire_params)
        format.html { redirect_to @categori_salaire, notice: 'Categori salaire was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @categori_salaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categori_salaires/1
  # DELETE /categori_salaires/1.json
  def destroy
    @categori_salaire.destroy
    respond_to do |format|
      format.html { redirect_to categori_salaires_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categori_salaire
      @categori_salaire = CategoriSalaire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categori_salaire_params
      params.require(:categori_salaire).permit(:code, :nom, :is_active)
    end
end
