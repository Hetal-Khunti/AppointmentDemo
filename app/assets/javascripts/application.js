// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery-ui
//= require activestorage
//= require turbolinks
//= require_tree .
//= require datetimepicker
//= require tinymce




$(function () {

    $("#appointment_date" ).datetimepicker({
          format: 'Y-m-d',
          timepicker: false,
    }).attr('readonly', 'readonly');


    $("#appointment_start_time" ).datetimepicker({
          datepicker: false,
          format:'H:i',
          step: 30,
          onShow: function () {
              this.setOptions({
                  maxTime:$('#appointment_end_time').val()?$('#appointment_end_time').val():false
              });
          }
    }).attr('readonly', 'readonly');
    $( "#appointment_end_time" ).datetimepicker({
        datepicker: false,
        format: 'H:i',
        step: 30,
          onShow: function () {
              this.setOptions({
                  minTime:$('#appointment_start_time').val()?$('#appointment_start_time').val():false
              });
          }                    
    }).attr('readonly', 'readonly'); 
  });