(function() {
  var SiteCollection;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  SiteCollection = (function() {
    function SiteCollection() {
      SiteCollection.__super__.constructor.apply(this, arguments);
    }
    __extends(SiteCollection, Backbone.Collection);
    SiteCollection.prototype.model = Site;
    SiteCollection.prototype.comparator = function(a, b) {
      if (a.get('name') < b.get('name')) {
        return -1;
      } else if (a.get('name') === b.get('name')) {
        return 0;
      } else {
        return 1;
      }
    };
    return SiteCollection;
  })();
  this.SiteCollection = SiteCollection;
}).call(this);
