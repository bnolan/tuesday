(function() {
  var PageElement;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  PageElement = (function() {
    function PageElement() {
      PageElement.__super__.constructor.apply(this, arguments);
    }
    __extends(PageElement, Backbone.Model);
    PageElement.prototype.getNodeName = function() {
      return this.getNode().nodeName.toLowerCase();
    };
    PageElement.prototype.getNode = function() {
      return $(this.get('content'))[0];
    };
    PageElement.prototype.setInnerContent = function(html) {
      return this.set({
        content: "<" + (this.getNodeName()) + ">" + html + "</" + (this.getNodeName()) + ">"
      });
    };
    PageElement.prototype.getPage = function() {
      return this.page;
    };
    PageElement.prototype.setPage = function(page) {
      return this.page = page;
    };
    PageElement.prototype.destroy = function() {
      return this.getPage().getElements().remove(this);
    };
    return PageElement;
  })();
  this.PageElement = PageElement;
}).call(this);
