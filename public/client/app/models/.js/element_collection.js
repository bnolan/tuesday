(function() {
  var PageElementCollection;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  PageElementCollection = (function() {
    function PageElementCollection() {
      PageElementCollection.__super__.constructor.apply(this, arguments);
    }
    __extends(PageElementCollection, Backbone.Collection);
    PageElementCollection.prototype.model = PageElement;
    PageElementCollection.prototype.comparator = function(a, b) {
      if (a.get('position') < b.get('position')) {
        return -1;
      } else if (a.get('position') === b.get('position')) {
        return 0;
      } else {
        return 1;
      }
    };
    return PageElementCollection;
  })();
  this.PageElementCollection = PageElementCollection;
}).call(this);
