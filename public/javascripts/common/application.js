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
  var self = this;
  jQuery.goverlay(30,10,18);
  
  // Just to warm up my js:
  // (function(test_paragraph){
  //   test_paragraph.html(test_paragraph.attr("data-message"));
  // })($('p[data-function=jstest]'));
  
  //Elastic Layout
  function fill(){
    var width  = $(document).width() - $('#parent').outerWidth() - 14;
    var mid_height = $(document).height() - $('#bar').outerHeight();
    $('#main').width(width);
    $('#mid').height(mid_height);
    $('#mid').children('div').height(mid_height - 20);
    
  };
  fill();
  $(window).resize(fill);
  
  $("label.infield").inFieldLabels();
  
  // Text direction switch
  $("select.language_toggle").live("change", function(ev){
    var toggle = $(this);
    var input = $(document.getElementById(toggle.attr("rel")));
    if ($.inArray(toggle.val(), ["he", "ha", "fa", "ps", "ur", "yi", "ar"]) != -1) {
      input.attr("dir", "rtl");
    } else {
      input.attr("dir", "ltr");
    }
  }).trigger("change");
  
  //Tooltips
  $(".tooltipped a").tooltip({

     // tweak the position
     offset: [2, 10],

     // use the "slide" effect
     effect: 'slide'

  // add dynamic plugin with optional configuration for bottom edge
  }).dynamic({ bottom: { direction: 'down', bounce: true } });
  
  //Overlays
  $('a.overlay-switch').overlay()
  
  //Tabs
  //$("ul.tabs").tabs("div.panes > div");  
  
  // HTML 5 and js-framework agnosticism
  (function() {
    $("a[data-function]").live("click", function(ev) {
      self[$(this).attr("data-function")].call(self, ev);
    });

    // $("form[data-function]").live("submit", function(ev) {
    //   window[$(this).attr("data-function")].call(this, ev);
    //   return false;
    // });
  })();
  
});
