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
//= require jquery.turbolinks
//= require bootstrap-sprockets
//= require jquery_ujs
//= require gritter
//= require cocoon
//= require filterrific/filterrific-jquery
//= require_tree .
// require turbolinks

// for change nav bg on scroll
$(document).ready(function(){       
   var scroll_start = 0;
   var startchange = $('.top-front-page');
   var offset = startchange.offset();
    if (startchange.length){
     $(document).scroll(function() { 
        scroll_start = $(this).scrollTop();
        if(scroll_start > offset.top) {
            $(".navbar-inverse").css('background-color', '#f0f0f0');
            $(".dropdown-menu").css('background-color', '#f0f0f0');
         } else {
            // $('.navbar-default').css('background-color', 'transparent');
            $('.navbar-inverse').css('background-color', 'rgba(246, 233, 233, 0.4');
            $(".dropdown-menu").css('background-color', 'rgba(234, 234, 234, 0.9)');
         }

         if ($(document).scrollTop() > 50) {
             $('nav').addClass('shrink');
           } else {
             $('nav').removeClass('shrink');
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
// for change nav bg on scroll post index
$(document).ready(function(){       
   var scroll_start = 0;
   var startchange = $('.top-posts');
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

         if ($(document).scrollTop() > 50) {
             $('nav').addClass('shrink');
           } else {
             $('nav').removeClass('shrink');
           }
     });
    }
});
// for change nav bg on scroll



//////  Smooth scroling with Jquery //////////////
$(document).ready(function(){
// Select all links with hashes
$('a[href*="#"]')
  // Remove links that don't actually link to anything
  .not('[href="#"]')
  .not('[href="#0"]')
  .click(function(event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') 
      && 
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top
        }, 1000, function() {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex','-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });

  });
//////  Smooth scroling with Jquery //////////////


/************ Animation on page change **************/
window.addEventListener("beforeunload", function () {
  document.body.classList.add("animate-out");
});
/************ Animation on page change **************/

/// close nav when clicked outside on mobile
$(document).ready(function () {

    $(document).on('click touchend', function (e) {
        if (!$(e.target).is('a')) {
            $('.collapse').collapse('hide');         
        }
    });

    

});

$(document).ready(function () {
  // show/hide the menu when examples is clicked
  // $(".navbar-toggle").on("click", function () {
  //   $(".submenu").show(1000);
  // });
  // hide the menu when an exmple is clicked
  $(".example").on("click", function(){
    $('.collapse').collapse('hide');
  });
});




