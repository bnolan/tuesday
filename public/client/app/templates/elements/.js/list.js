if(!this.$templates){
  $templates={};
};

this.$templates.elementsList = function (__obj) {
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
    
      __out.push('<div class="elements-list">\n  <header>\n    <button class="home">&laquo; Back</button>\n    <button class="addElement">+ Add</button>\n    <button class="orderElements">&equiv; Reorder</button>\n  </header>\n\n  <div class="subtoolbar toolbar" style="display: none">\n    <button class="heading">Heading</button>\n    <button class="paragraph">Paragraph</button>\n    <button class="image">Image</button>\n    <button class="snippet">Snippet</button>\n  </div>\n\n  <div class="page-info">\n    <h3 class="page-name">');
    
      __out.push(__sanitize(this.model.get('title')));
    
      __out.push('</h3>\n    <address class="page-path">/');
    
      __out.push(__sanitize(this.model.getPath()));
    
      __out.push('</address>\n  </div>\n\n  <div class="page">\n  </div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
} ; 