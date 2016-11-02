class MouvementStocksController < ApplicationController
  before_action :set_mouvement_stock, only: [:show, :edit, :update, :destroy]

  # GET /mouvement_stocks
  # GET /mouvement_stocks.json
  def index
    @mouvement_stocks = MouvementStock.all
  end

  # GET /mouvement_stocks/1
  # GET /mouvement_stocks/1.json
  def show
  end

  # GET /mouvement_stocks/new
  def new
    @mouvement_stock = MouvementStock.new
  end

  # GET /mouvement_stocks/1/edit
  def edit
  end

  # POST /mouvement_stocks
  # POST /mouvement_stocks.json
  def create
    @mouvement_stock = MouvementStock.new(mouvement_stock_params)

    respond_to do |format|
      if @mouvement_stock.save
        format.html { redirect_to @mouvement_stock, notice: 'Mouvement stock was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mouvement_stock }
      else
        format.html { render action: 'new' }
        format.json { render json: @mouvement_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mouvement_stocks/1
  # PATCH/PUT /mouvement_stocks/1.json
  def update
    respond_to do |format|
      if @mouvement_stock.update(mouvement_stock_params)
        format.html { redirect_to @mouvement_stock, notice: 'Mouvement stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mouvement_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mouvement_stocks/1
  # DELETE /mouvement_stocks/1.json
  def destroy
    @mouvement_stock.destroy
    respond_to do |format|
      format.html { redirect_to mouvement_stocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mouvement_stock
      @mouvement_stock = MouvementStock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mouvement_stock_params
      params.require(:mouvement_stock).permit(:date, :type, :achat_id, :produit_id, :quantite, :prix_u)
    end
end
