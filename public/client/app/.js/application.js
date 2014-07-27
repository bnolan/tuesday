(function() {
  var Application;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Application = (function() {
    function Application() {
      this.startRouter = __bind(this.startRouter, this);;      this.site = new Site({});
    }
    Application.prototype.start = function() {
      this.domain = window.location.host;
      return this.site.load({
        name: "ben",
        password: "froggy"
      }, this.domain, {
        success: this.startRouter,
        error: function() {
          return alert("Oh knoes");
        }
      });
    };
    Application.prototype.startRouter = function() {
      this.router = new Router(this.site);
      return Backbone.history.start();
    };
    return Application;
  })();
  this.Application = Application;
}).call(this);
