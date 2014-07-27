(function() {
  var ElementList;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  ElementList = (function() {
    function ElementList() {
      this.onClick = __bind(this.onClick, this);;      ElementList.__super__.constructor.apply(this, arguments);
    }
    __extends(ElementList, Backbone.View);
    ElementList.prototype.initialize = function() {
      this.template = $templates.elementsList;
      return this.render();
    };
    ElementList.prototype.render = function() {
      var div;
      this.$el.html(this.template(this));
      div = this.$(".page");
      this.collection.each(__bind(function(element) {
        return $(element.get('content')).attr('data-cid', element.cid).appendTo(div);
      }, this));
      return this.delegateEvents();
    };
    ElementList.prototype.events = {
      "click .home": 'onHome',
      "click .addElement": 'onAddElement',
      "click .paragraph": 'onParagraph',
      "click .heading": 'onHeading',
      "click .image": 'onImage',
      "click .snippet": 'onSnippet',
      "click .page>*": 'onClick'
    };
    ElementList.prototype.onHome = function() {
      return window.location.hash = "#";
    };
    ElementList.prototype.onAddElement = function() {
      return this.$(".subtoolbar").toggle();
    };
    ElementList.prototype.onParagraph = function() {
      return this.addElement("<p>Your content goes here...</p>");
    };
    ElementList.prototype.onHeading = function() {
      return this.addElement("<h1>Heading</h1>");
    };
    ElementList.prototype.onImage = function() {
      var url;
      if (url = prompt("Enter URL to your image")) {
        return this.addElement("<img src='" + url + "' />");
      }
    };
    ElementList.prototype.onSnippet = function() {
      return alert("not implemented");
    };
    ElementList.prototype.addElement = function(html) {
      var el, position;
      position = this.collection.isEmpty() ? 1 : this.collection.last().get('position') + 1;
      el = new PageElement({
        position: position,
        content: html
      });
      el.setPage(this.model);
      this.collection.add(el);
      return window.location.hash = "pages/" + this.model.id + "/elements/" + el.cid + "/edit";
    };
    ElementList.prototype.onClick = function(e) {
      var el;
      el = $(e.currentTarget);
      return window.location.hash = "pages/" + this.model.id + "/elements/" + (el.attr('data-cid')) + "/edit";
    };
    return ElementList;
  })();
  this.ElementList = ElementList;
}).call(this);
