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
    var mid_height = $(window).height() - 126;
    $('#wrapper').css("min-height", mid_height);
    
  };
  fill();
  $(window).resize(fill);
  
  
  //Flags
  (function() {
    locale_options = $('#locale-options a');
    locale_change = $('#locale-change');
    
    locale_options.not('.active').hide();
    
    function revealLocales(e){
      locale_change.toggleClass('active1');
      locale_options.parent().animate({height: 18}, 200);
      locale_options.delay(200).fadeIn(400);
    }
    function hideLocales(e){
      locale_change.toggleClass('active1');
      locale_options.not('.active').fadeOut(400).hide();
      locale_options.not('.active').parent().delay(320).animate({height: 0}, 200);
    }
    
    locale_change.toggle(revealLocales, hideLocales);
  })();  
  
  //Form
  (function(){
    file_input = $('input[type=file]');
    file_input.addClass('reform');
    proxy_input = $('<input type="text" />');
    file_input.after(proxy_input);
    file_input.change(function(){
      proxy_input.val(file_input.val());
    });
    file_input.siblings().addClass('reform');
  })();
  
  //Tooltips
  $(".tooltipped a").tooltip({

     // tweak the position
     offset: [2, 10],

     // use the "slide" effect
     effect: 'slide'

  // add dynamic plugin with optional configuration for bottom edge
  }).dynamic({ bottom: { direction: 'down', bounce: true } });
});
