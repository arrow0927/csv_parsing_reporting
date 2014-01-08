class ModelsDatatable
  	delegate :params, :link_to, to: :@view
	attr_accessor :model_instance, :models

  def initialize(view, model_instance)
    puts "*******Initializing Model Datatables with modelname = #{model_instance}"
	@view = view
	@model_instance = model_instance.constantize
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i, 		#variable needed by Datatables server
      iTotalRecords: @model_instance.count,	#variable needed by Datatables server
      iTotalDisplayRecords: models.total_entries,
      aaData: data
    }
  end

private #====================================================================

  def data
	att_array = @model_instance.attribute_names.to_a
	test = models.collect {|m| att_array.collect {|a| m.send(a)}}

	#p "#{att_array.inspect}"
	# test = models.map do |m|
# 	  [
# 		att_array.collect do |att|
# 			m.send(att)
# 		end
# 	  ].flatten
# 	end
	p "test: #{test.inspect}"
	test
	
  end

  def models
    @models ||= fetch_models
  end

  def fetch_models
    mod_instance = @model_instance.order("#{sort_column} #{sort_direction}")
    mod_instance = mod_instance.page(page).per_page(per_page)
    if params[:sSearch].present?
      mod_instance = mod_instance.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
    end
    mod_instance
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
	att_array = @model_instance.attribute_names.to_a
    columns = att_array
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end