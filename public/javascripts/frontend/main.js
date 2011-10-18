var hoverColour = "#FFF";

$(function(){
		   
	$("a.hoverBtn_1").show("fast", function() {
	var currentId = jQuery(this).find('a').attr('id');	
	if(this.id=='news')
		{
			$(this).wrap("<div class=\"hoverBtn\">");			
		}
	if(this.id=='join')
		{
			$(this).wrap("<div class=\"hoverBtn2\">");			
		}
	if(this.id=='contact')
		{
			$(this).wrap("<div class=\"hoverBtn3\">");			
		}

	$(this).attr("class", "");
	});
	
	//display the hover div
	$("div.hoverBtn,div.hoverBtn2,div.hoverBtn3").show("fast", function() {
		//append the background div
		$(this).append("<div></div>");
		
		//get link's size
		var wid = $(this).children("a").width();
		var hei = $(this).children("a").height();
		
		//set div's size
		$(this).width(wid);
		$(this).height(hei);
		$(this).children("div").width(wid);
		$(this).children("div").height(hei);
		
		//on link hover
		$(this).children("a").hover(function(){
			//store initial link colour
			if ($(this).attr("rel") == "") {
				$(this).attr("rel", $(this).css("color"));
			}
			//fade in the background
			$(this).parent().children("div")
				.stop()
				.css({"display": "none", "opacity": "1"})
				.fadeIn("fast");
			//fade the colour
			$(this)	.stop()
				.css({"color": $(this).attr("rel")})
				.animate({"color": hoverColour}, 350);
		},function(){
			//fade out the background
			$(this).parent().children("div")
				.stop()
				.fadeOut("slow");
			//fade the colour
			$(this)	.stop()
				.animate({"color": $(this).attr("rel")}, 250);
		});
	});
});
