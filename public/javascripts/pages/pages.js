var app = {  
  
  setupAjaxCallbacks: function () {
    $('body').ajaxStart(function () {
      
    });
    $('body').ajaxStop(function () {

    });
    $('body').ajaxError(function (event, xhr, ajaxOptions, thrownError) {
      console.log({
        event:event,
        response:xhr
      });
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
    var mid_height = $(window).height() - 108;
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
      locale_options.parent().animate({
        height: 18
      }, 200);
      locale_options.delay(200).fadeIn(400);
    }
    function hideLocales(e){
      locale_change.toggleClass('active1');
      locale_options.not('.active').fadeOut(400).hide();
      locale_options.not('.active').parent().delay(320).animate({
        height: 0
      }, 200);
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
  }).dynamic({
    bottom: {
      direction: 'down',
      bounce: true
    }
  });
});

$(function(){
  $("input[type=submit]").hover(function(){
    $(this).addClass('hover');
  }, function(){
    $(this).removeClass('hover');
  });
});

$(window).load(function() {
  $('#nivoSlider').nivoSlider();
});

$(document).ready(function() {
  $('#feature-list #tabs li a').featureList({
    output		 : '#output li',
    start_item : $('#tabs li').index($('#tabs li a.current').closest('li'))
  });
});

$(function() {
  $('#portoflio ul.ad-thumb-list li').each(function(){
    var $this = $(this);
    var $desc = $this.children('.image-desc');
    if($desc.length){
      $this.find('a img').data('ad-desc', $desc.html());
    }
  });

  $('#portoflio .header').adGallery({
    loader_image: '/images/images/loader.gif',
    display_next_and_prev: false,
    description_wrapper: $('#descriptions'),
    effect: 'slide-hori'
  });
});

// Navigation menu
$(function(){
  var b = false, hoverOn = false;
  currentOn = true, current = $("#navigation > ul > li.current:has(ul)");
  if(current.size() == 0) current = null;

  var effects = new Array();
  var doEffect = function(){
    if(current && currentOn){
      currentOn = false;
      current.children('ul').slideUp('fast', doEffect);
      return;
    }
    var o = effects.shift();
    var e = effects.shift();
    if(o){
      b = true;
      if(e == 'slidDown'){
        hoverOn = true;
        $(o).children('ul').slideDown('fast', doEffect)
      }else{
        hoverOn = false;
        $(o).children('ul').slideUp('fast', doEffect)
      }
    } else {
      if(current && !hoverOn){
        current.children('ul').slideDown('fast');
        currentOn = true;
      }
      b = false;
    }
  }

  var runeffect = function(o, e){
    effects.push(o);
    effects.push(e);
    if(!b) doEffect();
  }

  $("#navigation > ul > li:not(.current)").each(function(){
    var $li = $(this);
    if($li.children('ul').size() == 0){
      $li.append('<ul style= "width: 400px;"/>');
    }
  }).hover(function(){
    runeffect(this, 'slidDown');
  }, function(){
    runeffect(this, 'slideUp');
  });
});
//$(function(){
//  var $current_nav = $("#navigation ul.current"), $navigations = $('#navigation > ul > li'), $sub_navigations = $navigations.find('ul');
//  $navigations.find('ul').css('background-color', '#fff').end().hover(function(){
//    var $xxx = $(this).find('div.xtest ul').css({'background-color': '#06C'}).find('a').css({'color': '#fff'}).end();
//    $(this).find('ul').slideDown('slow', function(){
//      $xxx.slideUp();
//    });
//  }, function(){
//    $(this).find('ul').slideUp();
////    $(this).find('ul').removeClass('current');
////    $current_nav.addClass('current');
//  });
//})

//$(function(){
////  var left = $('div.box.equalized:first').parent().position().left;
////  alert(left)
////  $('div.box.equalized').css({
////    position: 'absolute',
////    left: 50
////  });
//  var divs = $('div.expand');
//  divs.css({width: '300px', height: '300px'}).children('div').css({height: '200', overFlow: 'hidden'})
//  divs.css({height: 600});
//  divs.hover(function(){
//      var $this = $(this)
//      // save original box size
//      $this.data('size', [ $this.width(), $this.height() ])
//      .animate({
//        width: 630,
//        height: 500
//      })
//      .find('> div').css({height: 500});
////      if(divs.index(this) == 2){
////        var $this = $(this);
////        $this.after($this.prev());
////      }
//  }, function(){
//    $(this)
//      // save original box size
//      .data('size', [ $(this).width(), $(this).height() ])
//      .animate({
//        width: 310,
//        height: 300
//      })
//      .find('> div').css({height: 200});
//  });
//});

$(function(){
  var $divs = $('div.expand');
  //  $divs.css({
  //    'margin-bottom': '50px'
  //  }).children('div').css({
  //    overflow: 'hidden'
  //  });

  $divs.children('div').each(function(index){
    var $content = $('<div id="mcs-' + index + '" class="mcs_container"><div class="customScrollBox"><div class="container"></div><div class="dragger_container"><div class="dragger"></div></div></div></div>');
    $(this).addClass('content').wrap($content);
    $content.mCustomScrollbar("vertical",200,"easeOutCirc",1.05,"no","yes","yes",10)
  })
  //  $h4s = $divs.children('h4');
  //
  //  $h4s.each(function(index){
  //    alert($divs.eq(index).html())
  //  })
  //
  //  $divs.each(function(index){
  //    $(this).data('index', index)
  //    }).hover(function(){
  //    $divs.hide();
  //    $(this).show().css({
  //      width: '100%'
  //    });
  //  }, function(){
  //    $(this).css({
  //      width: '310px'
  //    });
  //    $divs.show();
  //  })
  //
  //  $divs.children('div').mousewheel(function(event, delta){
  //    this.scrollTop -= (delta * 30);
  //    return false;
  //  })

  //  $divs
  //    .append('<span><a class="arrow-left" href="#">&lt;</a> <a class="arrow-right" href="#">&gt;</a></span>')
  //    .find('a.arrow-left').click(function(){
  //      alert($(this).parent().parent().children('div').html());
  //      $(this).parent().parent().children('div').scrollTop(30);
  //      return false;
  //    })
  //    .end()
  //    .find('.arrow-right').click(function(){
  //      return false;
  //    });
  
});

// Test


//var $el, $tempDiv, $tempButton, divHeight = 0;
//
//$.fn.middleBoxButton = function(text, url) {
//    return this.hover(function(e) {
//        $el = $(this).css("border-color", "white");
//        divHeight = $el.height() + parseInt($el.css("padding-top")) + parseInt($el.css("padding-bottom"));
//
//        $innerDiv = $(this).children('div')
//        $tempDiv = $("<div />", {
//            "class": "overlay rounded",
//            "style": "height:" + $innerDiv.height() + "px;width:" + $innerDiv.width() + "px;top:" + $innerDiv.position().top + "px;left:" + $innerDiv.position().left + "px; background-color: transparent"
//        });
//
//        $tempButton = $("<a />", {
//            "href": url,
//            "text": text,
//            "class": "widget-button rounded",
//            "css": {
//                "top": (divHeight / 2) - 7 + "px"
//            }
//        }).appendTo($tempDiv).click(function(){
//
//
//          $tempDiv = $("<div />", {
//              "style": "position:absolute;width:100%;height:100%;top:0;left:0;background-color:black;opacity:0.6;z-index:5000"
//          });
//          var $theDiv =  $(this).parent().parent().clone().css({
//            'display': 'relative',
//            'width' : '600px',
//            'margin': 'auto auto;'
//          })
//          $theDiv.appendTo($tempDiv);
//          $tempDiv.appendTo($('body'));
//
//        });
//
//        $tempDiv.appendTo($el);
//
//    }, function(e) {
//
//        $el = $(this).css("border-color", "#999");
//
//        $(".overlay").fadeOut("fast", function() {
//            $(this).remove();
//        })
//
//    });
//
//}
//
//$(function() {
//
//    $('div.expand').middleBoxButton("Read More", "#more");
//
//});




$(function(){
  $('.dragbox')
  .each(function(){
    $(this).hover(function(){
      $(this).find('h2').addClass('collapse');
    }, function(){
      $(this).find('h2').removeClass('collapse');
    })
    .find('h2').hover(function(){
      $(this).find('.configure').css('visibility', 'visible');
    }, function(){
      $(this).find('.configure').css('visibility', 'hidden');
    })
    .click(function(){
      $(this).siblings('.dragbox-content').toggle();
    })
    .end()
    .find('.configure').css('visibility', 'hidden');
  });
  $('.column').sortable({
    connectWith: '.column',
    handle: 'h2',
    cursor: 'move',
    placeholder: 'placeholder',
    forcePlaceholderSize: true,
    opacity: 0.4,
    stop: function(event, ui){
      $(ui.item).find('h2').click();
      var sortorder='';
      $('.column').each(function(){
        var itemorder=$(this).sortable('toArray');
        var columnId=$(this).attr('id');
        sortorder+=columnId+'='+itemorder.toString()+'&';
      });
      alert('SortOrder: '+sortorder);
      /*Pass sortorder variable to server using ajax to save state*/
    }
  })
  .disableSelection();
});

$(function(){
  $('#languages-links > div').hover(function(){
    $(this).addClass('hover');
  }, function(){
    $(this).removeClass('hover')
  }).click(function(){
    window.location = $(this).find('a.h3').attr('href');
    return;
  });
});

$(function(){
  $('#movie img.play').click(function(){
    $(this).parent().flash({
      'src':'/swfs/play.swf',
      'width':'480',
      'height':'300'});
  });
})

$(function(){
  var calcuate = function(){
    //var translation_cost_per_word = 0.16; // 0.12
				
		  var source_language = $('#source_language').val();
    var target_language = $('#target_language').val();
    if(source_language == target_language){
      alert('Source language, and target language should be different!')
      $('#calculations p.cost').html('&nbsp; &pound; 0.00');
      return;
    }
    
    var translation_cost_per_word = (source_language == 'ar' || target_language == 'ar') ? 0.16 : 0.12;		
				
				
    var translation_cost_per_page = 250 * translation_cost_per_word;

    var localisation_cost_per_page = 27.5;
    var design_cost_per_page = 27.5;

    var $word_count = $('#word_count');
    var $page_count = $('#page_count');
    
    var  word_count = parseInt($word_count.val());
    var  page_count = parseInt($page_count.val());


    var cost = 0.0;
   if(!$word_count.hasClass('disabled') && word_count > 0){
      $('#calculations :checked').each(function() {
        switch($(this).val())
        {
          case 'translation':
            cost += translation_cost_per_word  * word_count;
            break;
          case 'design':
            cost += design_cost_per_page * Math.ceil(word_count / 250);
            break;
          case 'localisation':
            cost += localisation_cost_per_page * Math.ceil(word_count / 250);
            break;
        }
      });
    } else if (!$page_count.hasClass('disabled') && page_count > 0){
      $('#calculations :checked').each(function() {
        switch($(this).val())
        {
          case 'translation':
            cost += translation_cost_per_page  * page_count;
            break;
          case 'design':
            cost += design_cost_per_page * page_count;
            break;
          case 'localisation':
            cost += localisation_cost_per_page * page_count;
            break;
        }
      });
    } else {
      alert('Should enter number of pages or number or words!');
    }
				
	   $('#calculations p.cost').html('&nbsp; &pound; ' + $.formatNumber(cost, {
      format: '#,000.00'
    }));
  };

  
  $('.numeric input[type=text]').numeric({buttons: false, minValue: 0}).focus(function(){
    $(this).removeClass('disabled');
    $(".numeric input[type=text]").not(this).addClass('disabled');
  });
  $('#calculations input:radio[name=requirements]').change(function(){
    if(this.value == 'translation'){
      $('#word_count').removeAttr('disabled');
    } else {
      $('#word_count').attr('disabled', 'disabled').addClass('disabled');
    }
  })

  $('#calculations input[type=submit]').click(function(){
    calcuate();
    return false;
  });
});

$(function(){
  $('#contact').validate();
});