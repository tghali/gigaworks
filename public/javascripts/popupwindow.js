  $("#table_grid table tr").mouseover(function () {
    $(this).find(".add_view_1").show();
    }).mouseout(function () {
    $(this).find(".add_view_1").hide();
    });

      //select all the a tag with name equal to modal
      $('a[name=modal]').click(function (e) {
          //Cancel the link behavior
          e.preventDefault();
  
          //Get the A tag
          var id = $(this).attr('href');
  
          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
         // var winH = $(window).height();
//          var winW = $(window).width();
  
										 var popMargTop = ($(id).height() + 10) / 2;
											var popMargLeft = ($(id).width() + 10) / 2;
		
          //Set the popup window to center
											$(id).css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
											
          //transition effect
          $(id).fadeIn(2000);
  
      });
  
        //select all the a tag with name equal to modal
      $('a[name=preview_image]').click(function (e) {
          //Cancel the link behavior
           $('#dialog_new_term_test').show();

          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
/*          var winH = $(window).height();
          var winW = $(window).width();*/
  
											var popMargTop = ($('#dialog_new_term_test').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#dialog_new_term_test').width() + 10) / 2;
				
			
          //Set the popup window to center
											$('#dialog_new_term_test').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
		
		
          //Set the popup window to center
/*          $('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          $('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);*/
  
          //transition effect
          $('#dialog_new_term_test').fadeIn(2000);
  
      });
  
  
    
    
    //select all the a tag with name equal to modal
      $("#popup").click(function () {

          //Cancel the link behavior
         // e.preventDefault();

          //Get the A tag
         // var id = $(this).attr('href');
          $('#dialog_new_term_test').show();

          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
/*          var winH = $(window).height();
          var winW = $(window).width();*/
  
											var popMargTop = ($('#dialog_new_term_test').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#dialog_new_term_test').width() + 10) / 2;
				
			
          //Set the popup window to center
											$('#dialog_new_term_test').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
		
		
          //Set the popup window to center
/*          $('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          $('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);*/
  
          //transition effect
          $('#dialog_new_term_test').fadeIn(2000);
	  
	  
  
      });
      
     //select all the a tag with name equal to modal
      $('a[name=sentence_edit]').click(function () {

          //Cancel the link behavior
         // e.preventDefault();

          //Get the A tag
         // var id = $(this).attr('href');
          $('#dialog_new_term_test').show();

          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
											var popMargTop = ($('#dialog_new_term_test').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#dialog_new_term_test').width() + 10) / 2;
		
          //Set the popup window to center
											$('#dialog_new_term_test').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
			
		
		
          //Get the window height and width
/*          var winH = $(window).height();
          var winW = $(window).width();
  
          //Set the popup window to center
          $('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          $('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);*/
  
          //transition effect
          $('#dialog_new_term_test').fadeIn(2000);
	  
	  
  
      });  
 
     //select all the a tag with name equal to modal
      $('a[name=sentence_comment]').click(function () {

          //Cancel the link behavior
         // e.preventDefault();

          //Get the A tag
         // var id = $(this).attr('href');
          $('#dialog_new_term_test').show();

          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
          //var winH = $(window).height();
          //var winW = $(window).width();
  
          //Set the popup window to center
          //$('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          //$('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);
  
  								var popMargTop = ($('#dialog_new_term_test').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#dialog_new_term_test').width() + 10) / 2;
		
          //Set the popup window to center
											$('#dialog_new_term_test').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
  
  
  
          //transition effect
          $('#dialog_new_term_test').fadeIn(2000);
	  
	  
  
      });  

     //select all the a tag with name equal to modal
      $('a[name=sentence_tag]').click(function () {

          //Cancel the link behavior
         // e.preventDefault();

          //Get the A tag
         // var id = $(this).attr('href');
          $('#dialog_tag_comment').show();

          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
          //var winH = $(window).height();
          //var winW = $(window).width();
  
          //Set the popup window to center
          //$('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          //$('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);
  
  								var popMargTop = ($('#dialog_tag_comment').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#dialog_tag_comment').width() + 10) / 2;
		
          //Set the popup window to center
											$('#dialog_tag_comment').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
  
  
  
          //transition effect
          $('#dialog_tag_comment').fadeIn(2000);

  
      });  




    //select all the a tag with name equal to modal
      $('a[name=edit_image]').click(function () {

          //Cancel the link behavior
         // e.preventDefault();
   
          //Get the A tag
         // var id = $(this).attr('href');
          $('#imageedit').show();


          //Get the screen height and width
          var maskHeight = $(document).height();
          var maskWidth = $(window).width();
  
          //Set heigth and width to mask to fill up the whole screen
          $('#mask').css({
              'width': maskWidth,
              'height': maskHeight
          });
  
          //transition effect		
          $('#mask').fadeIn(1000);
          $('#mask').fadeTo("slow", 0.8);
  
          //Get the window height and width
          //var winH = $(window).height();
          //var winW = $(window).width();
  
          //Set the popup window to center
          //$('#dialog_new_term_test').css('top', winH / 2 - $('#dialog_new_term_test').height() / 2);
          //$('#dialog_new_term_test').css('left', winW / 2 - $('#dialog_new_term_test').width() / 2);
  
  								var popMargTop = ($('#imageedit').height() + 10) / 2;
											if(popMargTop == 5){popMargTop = 204}
											var popMargLeft = ($('#imageedit').width() + 10) / 2;
		
          //Set the popup window to center
											$('#imageedit').css({ 
												'margin-top' : -popMargTop,
												'margin-left' : -popMargLeft
											});
  
  
  
          //transition effect
          $('#imageedit').fadeIn(2000);
	  
	  
  
      });  

      
      //if close button is clicked
      $('.window .close').click(function (e) {
          //Cancel the link behavior
          e.preventDefault();
  
          $('#mask').fadeOut(200);
          $('.window').fadeOut(200);
      });     