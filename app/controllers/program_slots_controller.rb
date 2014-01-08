class ProgramSlotsController < ApplicationController
  before_action :set_program_slot, only: [:show, :edit, :update, :destroy]

  # GET /program_slots
  # GET /program_slots.json
  def index
    puts "Running ProgramSlot/index"
	puts "Model name = #{controller_name.classify}"
	respond_to do |format|
      format.html
      format.json { render json: ModelsDatatable.new(view_context, controller_name.classify)  }
    end
	
  end

  # GET /program_slots/1
  # GET /program_slots/1.json
  def show
	@program_slot = ProgramSlot.find(params[:id])
  end

  # GET /program_slots/new
  def new
    @program_slot = ProgramSlot.new
  end

  # GET /program_slots/1/edit
  def edit
	@program_slot = ProgramSlot.find(params[:id])
  end

  # POST /program_slots
  # POST /program_slots.json
  def create
    @program_slot = ProgramSlot.new(program_slot_params)

    respond_to do |format|
      if @program_slot.save
        format.html { redirect_to @program_slot, notice: 'Program slot was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program_slot }
      else
        format.html { render action: 'new' }
        format.json { render json: @program_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_slots/1
  # PATCH/PUT /program_slots/1.json
  def update
    respond_to do |format|
      if @program_slot.update(program_slot_params)
        format.html { redirect_to @program_slot, notice: 'Program slot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program_slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_slots/1
  # DELETE /program_slots/1.json
  def destroy
    @program_slot.destroy
    respond_to do |format|
      format.html { redirect_to program_slots_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_slot
      @program_slot = ProgramSlot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_slot_params
      params[:program_slot]
    end
end
