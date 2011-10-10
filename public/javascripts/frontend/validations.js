// JavaScript Document

function slider_validation(option_type)
{
			 var tabtype = document.getElementById('frontend_page_tab_type');
	   var create_content = document.getElementById('create_content');
	   var adapt_content = document.getElementById('adapt_content');				
	   var deliver_content = document.getElementById('deliver_content');								
				
    if(option_type == "create" && create_content.value == "")
    {
      alert('Please enter content for create tab');
      create_content.focus();
      return false;
    }	

    if(option_type == "adapt" && adapt_content.value == "")
    {
      alert('Please enter content for adapt tab');
      adapt_content.focus();
      return false;
    }		

    if(option_type == "deliver" && deliver_content.value == "")
    {
      alert('Please enter content for deliver tab');
      deliver_content.focus();
      return false;
    }		

      return true;	
}

function home_middle_validation()
{
	 var mid_content = document.getElementById('middle_content');
		var mid_title = document.getElementById('middle_title');
		
		if(mid_title.value == "")
    {
      alert('Please enter title');
      mid_title.focus();
      return false;
    }		

		if(mid_content.value == "")
    {
      alert('Please enter content for the middle tag');
      mid_content.focus();
      return false;
    }		


      return true;	
		
}

function network_validation()
{
	 var news = document.getElementById('frontend_page_news');
		var network = document.getElementById('frontend_page_network');
		var contact = document.getElementById('frontend_page_contact_us');

		
		if(news.value == "" || network.value == "" || contact.value == "")
    {
      alert('Please enter the text for news, join the network and contact us block');
      news.focus();
      return false;
    }		

      return true;	
		
}

	/*	language block start*/

  function lang_validate()
  {

    var lang_heading = document.getElementById('lang_heading');
    var lang_summary = document.getElementById('lang_summary');
				
				
    if(lang_heading.value == "" || lang_heading.value == " ")
    {
      alert('Please enter heading for languages');
      lang_heading.focus();
      return false;
    }
    if(lang_summary.value == "" || lang_summary.value == " ")
    {
						alert('Please enter summary for languages');
      lang_summary.focus();
      return false;
    }
    return true;
  }
		
		
		function lang_trans_validate()
		{

    var trans_heading = document.getElementById('lang_translation_heading');
    var trans_summary = document.getElementById('lang_translation_summary');

    if(trans_heading.value == "" || trans_heading.value == " ")
    {
      alert('Please enter heading for language translation');
      trans_heading.focus();
      return false;
    }
    if(trans_summary.value == "" || trans_summary.value == " ")
    {
						alert('Please enter summary for language translation');
      trans_summary.focus();
      return false;
    }
    return true;



		}
		
		function lang_consultancy_validate()
		{
    var consultancy_summary = document.getElementById('lang_consultancy_summary');
    var consultancy_heading = document.getElementById('lang_consultancy_heading');
    var consultancy_summary2 = document.getElementById('lang_consultancy_summary1');
				
    if(consultancy_summary.value == "" || consultancy_summary.value == " ")
    {
      alert('Please enter summary for language consultancy');
      consultancy_summary.focus();
      return false;
    }

    if(consultancy_heading.value == "" || consultancy_heading.value == " ")
    {
      alert('Please enter heading for language consultancy');
      consultancy_heading.focus();
      return false;
    }

    if(consultancy_summary2.value == "" || consultancy_summary2.value == " ")
    {
      alert('Please enter summary two for language consultancy');
      consultancy_summary2.focus();
      return false;
    }

    return true;
			
		}
		
				function lang_localisation_validate()
		{

    var localisation_heading = document.getElementById('lang_localisation_heading');
    var localisation_summary = document.getElementById('lang_localisation_summary');

    if(localisation_heading.value == "" || localisation_heading.value == " ")
    {
      alert('Please enter heading for language localisation');
      localisation_heading.focus();
      return false;
    }
    if(localisation_summary.value == "" || localisation_summary.value == " ")
    {
						alert('Please enter summary for language localisation');
      localisation_summary.focus();
      return false;
    }
    return true;



		}
		
		function lang_onlinetools_validate()
		{

			 var online_heading = document.getElementById('lang_online_tools_heading');
				var online_heading2 = document.getElementById('lang_online_tools_heading1');
    var online_summary = document.getElementById('lang_online_tools_summary');
    var online_summary2 = document.getElementById('lang_online_tools_summary1');
				
	    if(online_heading.value == "" || online_heading.value == " ")
    {
      alert('Please enter heading one for language online tools');
      online_heading.focus();
      return false;
    }
    if(online_summary.value == "" || online_summary.value == " ")
    {
						alert('Please enter summary one for language online tools');
      online_summary.focus();
      return false;
    }

    if(online_heading2.value == "" || online_heading2.value == " ")
    {
      alert('Please enter heading two for language online tools');
      online_heading2.focus();
      return false;
    }
    if(online_summary2.value == "" || online_summary2.value == " ")
    {
						alert('Please enter summary two for language online tools');
      online_summary2.focus();
      return false;
    }

    return true;			

		}
		
		/*	language block end*/
		
			/*	creative block start*/
		
		
	  function creative_validate()
  {
			 var h1 = document.getElementById('creative_heading1');
				var h2 = document.getElementById('creative_heading2');
    var s1 = document.getElementById('creative_summary1');
    var s2 = document.getElementById('creative_summary2');
				
    if(h1.value == "")
    {
      alert('Please enter heading one for creative');
      h1.focus();
      return false;
    }
    if(s1.value == "")
    {
						alert('Please enter summary one for creative');
      s1.focus();
      return false;
    }

    if(h2.value == "")
    {
      alert('Please enter heading two for creative');
      h2.focus();
      return false;
    }
    if(s2.value == "")
    {
						alert('Please enter summary two for creative');
      s2.focus();
      return false;
    }

    return true;
  }	
		
		function creative_design_validate()
		{
			
			var creative_design = document.getElementById('creative_design_summary');
    if(creative_design.value == "")
    {
						alert('Please enter summary for creative web design');
      creative_design.focus();
      return false;
    }

    return true;			
		}
		
			function creative_adv_validate()
		{
			
			var creative_adv = document.getElementById('creative_advertising');
    if(creative_adv.value == "")
    {
						alert('Please enter summary for creative advertising');
      creative_adv.focus();
      return false;
    }

    return true;			
		}
	
				function creative_artwork_validate()
		{
			
			var creative_art = document.getElementById('creative_summary_artwork');
    if(creative_art.value == "")
    {
						alert('Please enter summary for creative artwork');
      creative_art.focus();
      return false;
    }

    return true;			
		}
	
					function creative_copywrite_validate()
		{
			
			var copywrite_summary = document.getElementById('copywrite_summary');
			var copywrite_heading = document.getElementById('copywrite_heading');
			var copywrite_summary2 = document.getElementById('copywrite_summary2');
			
    if(copywrite_summary.value == "")
    {
						alert('Please enter summary for creative copywriting');
      copywrite_summary.focus();
      return false;
    }

    if(copywrite_heading.value == "")
    {
						alert('Please enter heading for creative copywriting');
      copywrite_heading.focus();
      return false;
    }

    if(copywrite_summary2.value == "")
    {
						alert('Please enter summary two for creative copywriting');
      copywrite_summary2.focus();
      return false;
    }


    return true;			
		}
		
	/*	creative block end*/
	
	
	
		
	  function tech_validate()
  {

    var theading = document.getElementById('tech_heading');
    var tsummary = document.getElementById('tech_summary');
    if(theading.value == "")
    {
      alert('Please enter heading');
      theading.focus();
      return false;
    }
    if(tsummary.value == "")
    {
						alert('Please enter summary');
      tsummary.focus();
      return false;
    }
    return true;
  }	
		
		
	function banner_validate(option_value)
	{
			 var bone_title = document.getElementById('bone_title');
	   var bone_writer = document.getElementById('bone_writer');
					
				var btwo_title = document.getElementById('btwo_title');
	   var btwo_writer = document.getElementById('btwo_writer');
				
				var bthree_title = document.getElementById('bthree_title');
	   var bthree_writer = document.getElementById('bthree_writer');
				
				
    if(option_value == "banner_one" && bone_title.value == "")
    {
      alert('Please enter title for the languages banner');
      bone_title.focus();
      return false;
    }	

    if(option_value == "banner_one" && bone_writer.value == "")
    {
      alert('Please enter writer name for languages banner');
      bone_writer.focus();
      return false;
    }	


    if(option_value == "banner_two" && btwo_title.value == "")
    {
      alert('Please enter title for the creative banner');
      btwo_title.focus();
      return false;
    }		

    if(option_value == "banner_two" && btwo_writer.value == "")
    {
      alert('Please enter writer name for creative banner');
      btwo_writer.focus();
      return false;
    }	
				
	    if(option_value == "banner_three" && bthree_title.value == "")
    {
      alert('Please enter title for the technology banner');
      bthree_title.focus();
      return false;
    }		

    if(option_value == "banner_three" && bthree_writer.value == "")
    {
      alert('Please enter writer name for technology banner');
      bthree_writer.focus();
      return false;
    }				

      return true;		
		
	}