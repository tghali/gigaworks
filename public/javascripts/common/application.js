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
  
  //Elastic Layout
  function fill(){
    var width  = $(document).width() - $('#parent').outerWidth() - 14;
    $('#main').width(width)
  };
  fill();
  $(window).resize(fill);
  
  
  //Tooltips
  $(".tooltipped a").tooltip({

     // tweak the position
     offset: [2, 10],

     // use the "slide" effect
     effect: 'slide'

  // add dynamic plugin with optional configuration for bottom edge
  }).dynamic({ bottom: { direction: 'down', bounce: true } });
});
