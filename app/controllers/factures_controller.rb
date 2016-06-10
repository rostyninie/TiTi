class FacturesController < ApplicationController
  before_filter :login_required
  filter_resource_access
  before_action :set_facture, only: [:show, :edit, :update, :destroy]

  # GET /factures
  # GET /factures.json
  def index
    @factures = Facture.all
  end

  # GET /factures/1
  # GET /factures/1.json
  def show
  end

  # GET /factures/new
  def new
    @facture = Facture.new
  end

  # GET /factures/1/edit
  def edit
  end

  # POST /factures
  # POST /factures.json
  def create
    @facture = Facture.new(facture_params)

    respond_to do |format|
      if @facture.save
        format.html { redirect_to @facture, notice: 'Facture was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facture }
      else
        format.html { render action: 'new' }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factures/1
  # PATCH/PUT /factures/1.json
  def update
    respond_to do |format|
      if @facture.update(facture_params)
        format.html { redirect_to @facture, notice: 'Facture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factures/1
  # DELETE /factures/1.json
  def destroy
    @facture.destroy
    respond_to do |format|
      format.html { redirect_to factures_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facture
      @facture = Facture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facture_params
      params.require(:facture).permit(:num, :commande_id, :client_id, :montant, :is_solde, :date_facture)
    end
end
