# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready -> 
	console.log("before datatables init")
	$("#channels").dataTable
		sPaginationType: "full_numbers" 
		bJQueryUI:true
		bProcessing:true
		bServerSide:true
		sAjaxSource: $('#channels').data('source')
	console.log("after datatables init")