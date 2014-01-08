// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require d3
//= require jquery
//= require jquery.ui.effect-blind
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require twitter/bootstrap
//= require turbolinks
//= require dataTables/jquery.dataTables
//= require_tree .



// $(document).ready ->
//    # will call refresh_badges every 5 second
//    setInterval refresh_badges, 5000
//    
// refresh_badges = ->
//    $.ajax url: "/refresh_badges", format: 'js' 
var refresh_badges;

$(document).ready(function() {
  return setInterval(refresh_badges, 5000);
});

refresh_badges = function() {
  return $.ajax({
    url: "/refresh_badges",
    format: 'js'
  });
};