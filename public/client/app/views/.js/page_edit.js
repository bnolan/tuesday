(function() {
  var PageEdit;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  PageEdit = (function() {
    function PageEdit() {
      this.onTitleChange = __bind(this.onTitleChange, this);;      PageEdit.__super__.constructor.apply(this, arguments);
    }
    __extends(PageEdit, Backbone.View);
    PageEdit.prototype.initialize = function() {
      this.template = $("script#page-details").html();
      return this.render();
    };
    PageEdit.prototype.render = function() {
      var ul;
      this.$el.html(this.template);
      ul = this.$(".page-list");
      this.$("[name='title']").val(this.model.get('title'));
      this.onTitleChange();
      return this.delegateEvents();
    };
    PageEdit.prototype.events = {
      'click .save': 'onSave',
      'click .delete': 'onDelete',
      'keyup input': 'onTitleChange'
    };
    PageEdit.prototype.onSave = function() {
      return this.model.save({}, {
        success: __bind(function() {
          window.location.hash = "";
          return window.location.reload();
        }, this),
        error: __bind(function() {
          return alert("Unable to save your page");
        }, this)
      });
    };
    PageEdit.prototype.onDelete = function() {
      return window.location.hash = "";
    };
    PageEdit.prototype.onTitleChange = function() {
      var path;
      path = this.model.autoPath();
      this.model.set({
        title: this.$("[name='title']").val(),
        path: path
      });
      return this.$(".path").text(path);
    };
    return PageEdit;
  })();
  this.PageEdit = PageEdit;
}).call(this);
