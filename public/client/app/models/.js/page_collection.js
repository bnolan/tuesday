(function() {
  var PageCollection;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  PageCollection = (function() {
    function PageCollection() {
      PageCollection.__super__.constructor.apply(this, arguments);
    }
    __extends(PageCollection, Backbone.Collection);
    PageCollection.prototype.model = Page;
    PageCollection.prototype.comparator = function(a, b) {
      if (a.get('position') < b.get('position')) {
        return -1;
      } else if (a.get('position') === b.get('position')) {
        return 0;
      } else {
        return 1;
      }
    };
    return PageCollection;
  })();
  this.PageCollection = PageCollection;
}).call(this);
