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
//= require jquery_ujs
//= require jquery-ui-1.10.4
//= require jquery.ui.touch-punch
//= require underscore
//= require backbone
//= require_tree .

(function($) {
 $.fn.doubleTap = function(doubleTapCallback) {
   return this.each(function(){
      var elm = this;
      var lastTap = 0;
      $(elm).bind('mousedown', function (e) {
        var now = (new Date()).valueOf();
        var diff = (now - lastTap);
        lastTap = now ;
        if (diff < 250) {
          if($.isFunction( doubleTapCallback )){
             doubleTapCallback.call(elm, e);
          }
        }      
      });
    });
  }
})(jQuery);