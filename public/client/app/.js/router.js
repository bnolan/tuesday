(function() {
  var Router;
  var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  Router = (function() {
    function Router() {
      Router.__super__.constructor.apply(this, arguments);
    }
    __extends(Router, Backbone.Router);
    Router.prototype.routes = {
      "": "listPages",
      "pages/new": "newPage",
      "pages/:page": "listElements",
      "pages/:page/elements/:element/edit": "editElement"
    };
    Router.prototype.initialize = function(site) {
      this.site = site;
      this.el = $('body');
      return this.showSpinner();
    };
    Router.prototype.showSpinner = function() {
      return this.el.empty().html("<center class='spinner'>Loading yo...</center>");
    };
    Router.prototype.setView = function(view) {
      if (this.view) {
        this.view.undelegateEvents();
      }
      return this.view = view;
    };
    Router.prototype.listPages = function() {
      return this.setView(new PageList({
        el: this.el.empty(),
        model: this.site,
        collection: this.site.getPages()
      }));
    };
    Router.prototype.newPage = function() {
      var page;
      page = new Page({
        title: 'New Page'
      });
      return this.setView(new PageEdit({
        el: this.el.empty(),
        model: page
      }));
    };
    Router.prototype.listElements = function(id) {
      var page;
      page = this.site.getPages().get(id);
      return this.setView(new ElementList({
        el: this.el.empty(),
        model: page,
        collection: page.getElements()
      }));
    };
    Router.prototype.editElement = function(pageId, id) {
      var element, nodeName, page, view;
      page = this.site.getPages().get(pageId);
      element = page.getElements().get(id);
      nodeName = element.getNodeName();
      view = nodeName === "p" ? new ParagraphElementEdit({
        el: this.el.empty(),
        model: element
      }) : nodeName === "h1" ? new HeaderElementEdit({
        el: this.el.empty(),
        model: element
      }) : nodeName === "div" && element.getComponent === "img" ? new ImageElementEdit({
        el: this.el.empty(),
        model: element
      }) : nodeName === "div" ? new ComponentElementEdit({
        el: this.el.empty(),
        model: element
      }) : void 0;
      return this.setView(view);
    };
    return Router;
  })();
  this.Router = Router;
}).call(this);
