(function() {
  var Site;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  Site = (function() {
    function Site() {
      Site.__super__.constructor.apply(this, arguments);
    }
    __extends(Site, Backbone.Model);
    Site.prototype.url = 'site';
    Site.prototype.getPages = function() {
      return this.pages || (this.pages = new PageCollection(this.get('pages')));
    };
    Site.prototype.load = function(user, host, callbacks) {
      return $.ajax({
        url: "http://" + host + "/sites/2.json",
        success: __bind(function(response) {
          this.set(response);
          this.setSiteOnPages();
          return callbacks.success();
        }, this),
        error: callbacks.error,
        crossDomain: true
      });
    };
    Site.prototype.setSiteOnPages = function() {
      var page, _i, _len, _ref, _results;
      _ref = this.getPages().models;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        page = _ref[_i];
        _results.push(page.setSite(this));
      }
      return _results;
    };
    return Site;
  })();
  this.Site = Site;
}).call(this);
