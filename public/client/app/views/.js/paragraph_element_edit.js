(function() {
  var ParagraphElementEdit;
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; }, __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
    for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor;
    child.__super__ = parent.prototype;
    return child;
  };
  ParagraphElementEdit = (function() {
    function ParagraphElementEdit() {
      this.onSave = __bind(this.onSave, this);;
      this.onKeypress = __bind(this.onKeypress, this);;      ParagraphElementEdit.__super__.constructor.apply(this, arguments);
    }
    __extends(ParagraphElementEdit, ElementEdit);
    ParagraphElementEdit.prototype.initialize = function() {
      this.template = $templates.editorsParagraph;
      return this.render();
    };
    ParagraphElementEdit.prototype.render = function() {
      this.$el.html(this.template(this));
      this.$(".editing-field").children().attr('contenteditable', true);
      this.delegateEvents();
      setTimeout(__bind(function() {
        return this.focus();
      }, this), 100);
      if (this.model.getNodeName() !== "p") {
        return this.$(".toolbar button + button + button").hide();
      }
    };
    ParagraphElementEdit.prototype.focus = function() {
      var p, r, s;
      p = this.$(".editing-field *")[0];
      s = window.getSelection();
      r = document.createRange();
      r.setStart(p, 0);
      r.setEnd(p, 0);
      s.removeAllRanges();
      return s.addRange(r);
    };
    ParagraphElementEdit.prototype.events = {
      "click .save": 'onSave',
      'click .delete': 'onDelete',
      "click .bold ": 'onBold',
      "click .italic": 'onItalic',
      "click .createlink": 'onCreateLink',
      "keypress .editing-field": 'onKeypress'
    };
    ParagraphElementEdit.prototype.onKeypress = function(e) {
      var br, range, selection, textNode;
      if (e.keyCode === 13) {
        e.preventDefault();
        selection = window.getSelection();
        range = selection.getRangeAt(0);
        br = document.createElement("br");
        textNode = document.createTextNode("\u00a0");
        range.deleteContents();
        range.insertNode(br);
        range.collapse(false);
        range.insertNode(textNode);
        range.selectNodeContents(textNode);
        selection.removeAllRanges();
        selection.addRange(range);
        return true;
      }
    };
    ParagraphElementEdit.prototype.disableEditable = function() {
      return this.$(".editing-field > *").removeAttr('contenteditable');
    };
    ParagraphElementEdit.prototype.onSave = function() {
      this.disableEditable();
      this.model.set({
        content: this.$(".editing-field").html()
      });
      return this.save();
    };
    ParagraphElementEdit.prototype.onBold = function() {
      return document.execCommand("bold", false);
    };
    ParagraphElementEdit.prototype.onItalic = function() {
      return document.execCommand("italic", false);
    };
    ParagraphElementEdit.prototype.onCreateLink = function() {
      var url;
      url = prompt("Enter url for link...");
      if (url) {
        if (url.match(/\:\/\//)) {
          return document.execCommand("createlink", false, url);
        } else {
          return alert("Please enter a complete url including http://...");
        }
      }
    };
    return ParagraphElementEdit;
  })();
  this.ParagraphElementEdit = ParagraphElementEdit;
}).call(this);
