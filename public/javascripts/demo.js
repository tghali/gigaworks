$(document).ready(function() {
    $('.myTable01').fixedHeaderTable({ width: '100%', height: '400', footer: true, cloneHeadToFoot: false, altClass: 'odd', themeClass: 'fancyTable', autoShow: false });
    
    $('.myTable01').fixedHeaderTable('show', 1000);
    			
	$('.myTable02').fixedHeaderTable({ width: '100%', height: '200', footer: true, altClass: 'odd', themeClass: 'fancyTable-1' });
				
    
    $('.myTable03').fixedHeaderTable({ width: '400', height: '400', altClass: 'odd', footer: true, themeClass: 'fancyDarkTable' });
    
	$('a.makeTable').bind('click', function() {
		

		$('.myTable01').fixedHeaderTable('destroy');
		
		$('.myTable01 th, .myTable01 td')
			.css('border', $('#border').val() + 'px solid ' + $('#color').val());
			
		$('.myTable01').fixedHeaderTable({ width: $('#width').val(), height: $('#height').val(), footer: true, themeClass: 'fancyTable' });
	});
})