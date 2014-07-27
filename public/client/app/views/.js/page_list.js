(function() {
  var PageList;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  PageList = (function() {
    function PageList() {
      this.onClick = __bind(this.onClick, this);;      PageList.__super__.constructor.apply(this, arguments);
    }
    __extends(PageList, Backbone.View);
    PageList.prototype.initialize = function() {
      this.template = $templates.pagesList;
      return this.render();
    };
    PageList.prototype.render = function() {
      this.$el.html(this.template(this));
      return this.delegateEvents();
    };
    PageList.prototype.events = {
      'click .page-list li': 'onClick',
      'click .addPage': 'onAddPage'
    };
    PageList.prototype.onClick = function(e) {
      var el;
      el = $(e.currentTarget);
      return window.location.hash = "pages/" + el.attr('data-id');
    };
    PageList.prototype.onAddPage = function() {
      return window.location.hash = "pages/new";
    };
    return PageList;
  })();
  this.PageList = PageList;
}).call(this);
