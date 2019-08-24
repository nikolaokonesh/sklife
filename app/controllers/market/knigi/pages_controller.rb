class Market::Knigi::PagesController < ApplicationController
  before_action :set_market_knigi_page, only: [:show, :edit, :update, :destroy]

  # GET /market/knigi/pages
  # GET /market/knigi/pages.json
  def index
    @market_knigi_pages = Market::Knigi::Page.all
  end

  # GET /market/knigi/pages/1
  # GET /market/knigi/pages/1.json
  def show
  end

  # GET /market/knigi/pages/new
  def new
    @market_knigi_page = Market::Knigi::Page.new
  end

  # GET /market/knigi/pages/1/edit
  def edit
  end

  # POST /market/knigi/pages
  # POST /market/knigi/pages.json
  def create
    @market_knigi_page = Market::Knigi::Page.new(market_knigi_page_params)

    respond_to do |format|
      if @market_knigi_page.save
        format.html { redirect_to @market_knigi_page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @market_knigi_page }
      else
        format.html { render :new }
        format.json { render json: @market_knigi_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market/knigi/pages/1
  # PATCH/PUT /market/knigi/pages/1.json
  def update
    respond_to do |format|
      if @market_knigi_page.update(market_knigi_page_params)
        format.html { redirect_to @market_knigi_page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @market_knigi_page }
      else
        format.html { render :edit }
        format.json { render json: @market_knigi_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market/knigi/pages/1
  # DELETE /market/knigi/pages/1.json
  def destroy
    @market_knigi_page.destroy
    respond_to do |format|
      format.html { redirect_to market_knigi_pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_knigi_page
      @market_knigi_page = Market::Knigi::Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_knigi_page_params
      params.require(:market_knigi_page).permit(:title, :commentable_id, :commentable_type)
    end
end
