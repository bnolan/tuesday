(function() {
  var Page;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  Page = (function() {
    function Page() {
      Page.__super__.constructor.apply(this, arguments);
    }
    __extends(Page, Backbone.Model);
    Page.prototype.url = function() {
      return "http://" + app.domain + "/sites/" + (this.getSite().id) + "/pages/";
    };
    Page.prototype.getSite = function() {
      return this.site;
    };
    Page.prototype.setSite = function(site) {
      return this.site = site;
    };
    Page.prototype.getPath = function() {
      return this.get('path');
    };
    Page.prototype.getSnippet = function() {
      return $(this.get("content")).text().slice(0, 50) + "...";
    };
    Page.prototype.getElements = function() {
      return this.elements || (this.elements = this._parseElements());
    };
    Page.prototype._parseElements = function() {
      var array, doc, el, element, index;
      doc = $("<div>" + this.get('content') + "</div>");
      index = 0;
      array = (function() {
        var _i, _len, _ref, _results;
        _ref = doc.children();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          element = _ref[_i];
          el = new PageElement({
            content: $('<div>').append($(element).clone().removeAttr('contenteditable')).html(),
            position: ++index
          });
          el.setPage(this);
          _results.push(el);
        }
        return _results;
      }).call(this);
      return new PageElementCollection(array);
    };
    Page.prototype.getElementsAsHtml = function() {
      var html;
      html = '';
      this.getElements().each(function(el) {
        return html += el.get('content');
      });
      console.log(html);
      return html;
    };
    Page.prototype.autoPath = function() {
      return this.get('title').toLowerCase().replace(/[^a-z0-9\-_]+/g, '-');
    };
    Page.prototype.toJSON = function() {
      return {
        id: this.get('id'),
        title: this.get('title'),
        position: this.get('position'),
        content: this.getElementsAsHtml(),
        path: this.get('path')
      };
    };
    return Page;
  })();
  this.Page = Page;
}).call(this);
