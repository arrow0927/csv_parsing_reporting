# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
   setInterval refresh_table, 7000
   # $(".add_data_button").click ->
#      #if confirm("Start File Parsing?")
#      #$(".add_data_button").hide()
#      #$("#confirm_btn").css({'background-color':'88ff88'}).animate({'backgroun-color':'#000000'}, 1000)
#      else
#       false   


refresh_table = ->
   $.ajax url: "/uploads/refresh_table", format: 'js' 

