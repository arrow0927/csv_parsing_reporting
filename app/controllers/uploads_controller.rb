class UploadsController < ApplicationController
  before_action :set_upload, only: [ :edit, :update, :destroy] #This call back is applied to onky these actions

  # GET /uploads
  def index
    @uploads = Upload.all
	update_file_status
	@uploads = Upload.all
  end

  # GET /uploads/1
  def show
  end

  # GET /uploads/new
  def new
	puts "Running uploads/new"
    @upload = Upload.new()
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
=begin
The following method will render the form partial from the uploads view 
and call the create method from the uploads. Pass the upload object to the create
method. which will reroute to upload/index with a flash notification
=end
  def create
	
	@upload = Upload.new(upload_params)
	if @upload.save
		@upload.update!(:status => "1")
		@upload.update!(:f_path => "#{@upload.sourcedata.path}")
		redirect_to uploads_url, notice: "Upload for #{@upload.task.name} was successfully created with file #{@upload.sourcedata_file_name}."
    else
      	redirect_to tasks_url, alert: "*** ERROR *** Upload for #{@upload.task.name} did not go through successfully. #{@upload.errors.messages}"
    end
  end

  # PATCH/PUT /uploads/1
  	def update
		puts "Update method in Uploads controller received params = #{params.inspect}"
		puts "params[:upload][:job] = #{params[:upload][:job].inspect}"
		#When Button "Add to DB is pressed the following code is evoked"
		if (params[:upload][:job] == "parse")
			puts "Passed params[:job]== \"parse\" "
			
			redirect_to uploads_url, notice: "Parsing data from #{@upload.sourcedata_file_name}....."
			@upload.delay.add_data_to_DB()
			@upload.update!(:status => 4)
		else
			if @upload.update(upload_params)
				redirect_to uploads_url, notice: "#{@upload.sourcedata_file_name} was updated"
    		else
				redirect_to uploads_url, notice: "ERRRO #{@upload.sourcedata_file_name} could NOT be updated"
    		end
		end
	end


  # DELETE /uploads/1
  def destroy
    @upload.destroy
    redirect_to uploads_url, notice: 'Couldnt parse file #{@upload.sourcedata_file_name}'
  end
	
	# GET /uploads/refresh_table
	def refresh_table
		@uploads = Upload.all
		update_file_status
		@uploads = Upload.all
		respond_to do |format|
			format.js # template marked refresh_table.js.erb will be evoked
			#format.html {redirect_to uploads_url}			
		end
	end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:upload][:id])
    end

    # Only allow a trusted parameter "white list" through.
    def upload_params
		#removed the line below as it was causing an exception when the upload button was pressed
		params.require(:upload).permit(:sourcedata, :task_id, :status, :f_path, :job)
		#params.permit(:id, :sourcedata, :task_id, :status, :f_path)
    end

	def update_file_status
	@uploads.each do |u|
		if(File.exist?(u.f_path))
			puts "File #{u.sourcedata_file_name} exists"
		else
			puts "File #{u.sourcedata_file_name} has been removed"
			u.update!(:status => "-1")
		end
	end
	end

end
