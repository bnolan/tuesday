if(!this.$templates){
  $templates={};
};

this.$templates.pagesList = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var page, _i, _len, _ref;
    
      __out.push('<div class="pages-list">\n  <header>\n    <a href="/" class="home">&laquo; Back</a>\n    <button class="addPage">+ Add</button>\n    <button class="orderElements">&equiv; Shuffle</button>\n  </header>\n\n  <div class="site-info">\n    <h3 class="site-name">');
    
      __out.push(__sanitize(this.model.get('name')));
    
      __out.push('</h3>\n    <address class="site-subdomain">');
    
      __out.push(__sanitize(this.model.get('domain')));
    
      __out.push('</address>\n\n    ');
    
      if (this.collection.isEmpty()) {
        __out.push('\n      <p class="no-content">\n        This is an empty site. Click the "+ Add" button to start adding pages to your site.\n      </p>\n    ');
      }
    
      __out.push('\n  </div>\n\n  <ul class="page-list">\n    ');
    
      _ref = this.collection.models;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        page = _ref[_i];
        __out.push('\n      <li data-id="');
        __out.push(__sanitize(page.id));
        __out.push('">\n        <span class="title">');
        __out.push(__sanitize(page.get('title')));
        __out.push('</span>\n        <span class="snippet">');
        __out.push(__sanitize(page.getSnippet()));
        __out.push('</span>\n      </li>\n    ');
      }
    
      __out.push('\n  </ul>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
} ; 