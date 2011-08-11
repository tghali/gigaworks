$(document).ready(function(){
	$('.toolTip_text').hover(
		function() {
		this.tip = this.title;
		$(this).append(
			'<div class="toolTipWrapper">'
				+'<div class="toolTipTop"></div>'
				+'<div class="toolTipMid">'
					+this.tip
				+'</div>'
				+'<div class="toolTipBtm"></div>'
			+'</div>'
		);
		var $tooltip = $('.toolTipWrapper');
		this.title = "";
		this.width = $(this).width();
		$(this).find('.toolTipWrapper').css({right:this.width-100/2})
		$('.toolTipWrapper').fadeIn(300);
		
		$(this).mousemove(function(e){
							$tooltip.css({
								top: e.pageY + 5,
								left: e.pageX - 20
							});
						});
	},
	function() {
		$('.toolTipWrapper').fadeOut(100);
		$(this).children().remove();
			this.title = this.tip;
		}
	);
});
