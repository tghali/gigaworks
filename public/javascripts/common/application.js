var app = {  
  
  setupAjaxCallbacks: function () {
    $('body').ajaxStart(function () {
      
    });
    $('body').ajaxStop(function () {

    });
    $('body').ajaxError(function (event, xhr, ajaxOptions, thrownError) {
      console.log({event:event,response:xhr});
    });
  }
  
};


$(document).ready(function(){
  jQuery.goverlay(30,10,18);
  
  // HTML 5 and js-framework agnosticism
  // $(document).ready(function() {
  //   $("a[data-function]").live("click", function(ev) {
  //     window[$(this).attr("data-function")].call(this, ev);
  //   });
  // 
  //   $("form[data-function]").live("submit", function(ev) {
  //     window[$(this).attr("data-function")].call(this, ev);
  //     return false;
  //   });
  // });
  
  // Just to warm up my js:
  (function(test_paragraph){
    test_paragraph.append(test_paragraph.attr("data-message"));
  })($('p[data-function=jstest]'));
  
  
  
});
