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
//= require bootstrap-sprockets
//= require jquery_ujs
//= require gritter
//= require cocoon
//= require turbolinks
//= require_tree .

// for change nav bg on scroll
$(document).ready(function(){       
   var scroll_start = 0;
   var startchange = $('.top-front-page');
   var offset = startchange.offset();
    if (startchange.length){
     $(document).scroll(function() { 
        scroll_start = $(this).scrollTop();
        if(scroll_start > offset.top) {
            $(".navbar-default").css('background-color', '#f0f0f0');
         } else {
            // $('.navbar-default').css('background-color', 'transparent');
            $('.navbar-default').css('background-color', 'rgba(246, 233, 233, 0.4');
         }
     });
    }
});
// for change nav bg on scroll
// for change nav bg on scroll
$(document).ready(function(){       
   var scroll_start = 0;
   var startchange = $('.user-front-page');
   var offset = startchange.offset();
    if (startchange.length){
     $(document).scroll(function() { 
        scroll_start = $(this).scrollTop();
        if(scroll_start > offset.top) {
            $(".navbar-default").css('background-color', '#f0f0f0');
         } else {
            // $('.navbar-default').css('background-color', 'transparent');
            $('.navbar-default').css('background-color', 'rgba(246, 233, 233, 0.4');
         }
     });
    }
});
// for change nav bg on scroll












