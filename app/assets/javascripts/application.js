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
//= require jquery
//= require jquery-ui/autocomplete
//= require jquery-ui/slider
//= require jquery_ujs
//= require dresssed
//= require_tree .



// ** IF I EVER WANT TO ADD A PROGRESS BAR A I CAN LOOK INTO THIS
// This code adjusts the Left Offset when the screen size shrinks or expands
//$(document).ready(function(){
//    $(window).on('resize',function(){
//
//        var winWidth =  $(window).width();
//        var element = document.getElementById('progress-tracker');;
//        if(winWidth < 768 ){
//            document.getElementById("progress-tracker").style.visibility = "hidden";
//            //alert('Window Width: '+ winWidth + 'class used: col-sm');
//        }else if( winWidth <= 991){
//            document.getElementById("progress-tracker").style.visibility = "hidden";
//            //alert('Window Width: '+ winWidth + 'class used: col-sm');
//        }else if( winWidth <= 1199){
//            document.getElementById("progress-tracker").style.visibility = "visible";
//            document.getElementById("progress-tracker").style.left = "-250px";
//            //alert('Window Width: '+ winWidth + 'class used: col-sm');
//        }else{
//            document.getElementById("progress-tracker").style.visibility = "visible";
//            document.getElementById("progress-tracker").style.left = "-300px";
//            //alert('Window Width: '+ winWidth + 'class used: col-sm');
//        }
//    });
//});