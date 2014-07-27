(function() {
  var ElementEdit;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  }, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  ElementEdit = (function() {
    function ElementEdit() {
      ElementEdit.__super__.constructor.apply(this, arguments);
    }
    __extends(ElementEdit, Backbone.View);
    ElementEdit.prototype.save = function() {
      return this.model.getPage().save({}, {
        success: __bind(function() {
          return window.location.hash = "pages/" + (this.model.getPage().id);
        }, this),
        error: __bind(function() {
          return alert("COULDNT SAVE YO");
        }, this)
      });
    };
    ElementEdit.prototype.destroy = function() {
      this.model.destroy();
      return this.save();
    };
    return ElementEdit;
  })();
  this.ElementEdit = ElementEdit;
}).call(this);
