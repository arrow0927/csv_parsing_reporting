class DateRangesController < ApplicationController
  before_action :set_date_range, only: [:show, :edit, :update, :destroy]

  # GET /date_ranges
  def index
    @date_ranges = DateRange.all
  end

  # GET /date_ranges/1
  def show
  end

  # GET /date_ranges/new
  def new
    @date_range = DateRange.new
  end

  # GET /date_ranges/1/edit
  def edit
  end

  # POST /date_ranges
  def create
    @date_range = DateRange.new(date_range_params)

    if @date_range.save
      redirect_to @date_range, notice: 'Date range was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /date_ranges/1
  def update
    if @date_range.update(date_range_params)
      redirect_to @date_range, notice: 'Date range was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /date_ranges/1
  def destroy
    @date_range.destroy
    redirect_to date_ranges_url, notice: 'Date range was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_date_range
      @date_range = DateRange.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def date_range_params
      params.require(:date_range).permit(:date_range, :description, :upload_id)
    end
end
