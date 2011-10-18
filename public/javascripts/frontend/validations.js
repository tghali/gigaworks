// JavaScript Document


function case_study_validate()
{
	
	var ptitle = document.getElementById('casestudy_title');
	var cap = document.getElementById('casestudy_caption');
 var psummary = document.getElementById('casestudy_summary');
	
	  if(ptitle.value == "")
  {
  alert('Please enter title for project case studies');
  ptitle.focus();
  return false;
  }

	  if(cap.value == "")
  {
  alert('Please enter caption for project case studies');
  cap.focus();
  return false;
  }

	  if(psummary.value == "")
  {
  alert('Please enter summary for project case studies');
  psummary.focus();
  return false;
  }
		
		return true;

}

function project_adv_tabs(tab_option)
{
	
			var pchallenge = document.getElementById('project_challenge');
			var psolution = document.getElementById('project_solution'); 
			var pbenefit = document.getElementById('project_benefits');

			
			 if(tab_option == "cstudies_challenge" && pchallenge.value == "")
    {
						alert('Please enter data for challenge');
      pchallenge.focus();
      return false;
    }		
			 if(tab_option == "cstudies_solution" && psolution.value == "")
    {
						alert('Please enter data for solution');
      psolution.focus();
      return false;
    }			
	
				 if(tab_option == "cstudies_benefits" && pbenefit.value == "")
    {
						alert('Please enter data for benefits');
      pbenefit.focus();
      return false;
    }			
				
				return true;
	
}

  function submit_brief_form()
  {
  var name = document.getElementById('briefdetail_name');
  var email = document.getElementById('briefdetail_email');
  var attachment = document.getElementById('briefdetail_attachment');
  var emailExp=/^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
  
  if(name.value == "")
  {
  alert('Please enter name');
  name.focus();
  return false;
  }
  
  
  if(email.value == "")
  {
  alert('Please enter email');
  email.focus();
  return false;
  }
  
  
  if(!email.value.match(emailExp))
  {
  alert("Invalid email format");
  email.focus();
  return false;
  }
  
  
  
  
  if(attachment.value == "")
  {
  alert('Please choose a file to upload');
  attachment.focus();
  return false;
  }
  
  return true;
  }



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
		
		
		function language_translation_tabs(tab_option)
		{
			var trans_technical = document.getElementById('technical_content');
			var trans_medical = document.getElementById('medical_content'); 
			var trans_marketing = document.getElementById('marketing_content');
			var trans_literary = document.getElementById('literary_content');
			var trans_legal = document.getElementById('legal_content');
			
			 if(tab_option == "lang_trans_technical" && trans_technical.value == "")
    {
						alert('Please enter data for technical');
      trans_technical.focus();
      return false;
    }		
				
				if(tab_option == "lang_trans_medical" && trans_medical.value == "")
    {
						alert('Please enter data for medical');
      trans_medical.focus();
      return false;
    }		
				
						    if(tab_option == "lang_trans_marketing" && trans_marketing.value == "")
    {
						alert('Please enter data for marketing and business');
      trans_marketing.focus();
      return false;
    }		
				
						    if(tab_option == "lang_trans_literary" && trans_literary.value == "")
    {
						alert('Please enter data for literary');
      trans_literary.focus();
      return false;
    }		
				
						    if(tab_option == "lang_trans_legal" && trans_legal.value == "")
    {
						alert('Please enter data for legal');
      trans_legal.focus();
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
		
		function language_localisation_tabs(tab_option)
		{
			
			var products = document.getElementById('local_products');
			var lang_website = document.getElementById('local_websites'); 
			var lang_software = document.getElementById('local_software');
			var  lang_mobile = document.getElementById('local_mobile');
			var title = document.getElementById('local_subtitle');
			
					    if(tab_option == "products" && products.value == "")
    {
						alert('Please enter data for products and documentation');
      products.focus();
      return false;
    }		
				
						    if(tab_option == "websites" && lang_website.value == "")
    {
						alert('Please enter data for websites');
      lang_website.focus();
      return false;
    }		
				
						    if(tab_option == "software" && lang_software.value == "")
    {
						alert('Please enter data for software');
      lang_software.focus();
      return false;
    }		
				
						    if(tab_option == "mobile" && lang_mobile.value == "")
    {
						alert('Please enter data for mobile interfaces');
      lang_mobile.focus();
      return false;
    }		
				
						    if(tab_option == "subtitle" && title.value == "")
    {
						alert('Please enter data for subtitling and debugging');
      title.focus();
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
      alert('Please enter heading one for technology online tools');
      online_heading.focus();
      return false;
    }
    if(online_summary.value == "" || online_summary.value == " ")
    {
						alert('Please enter summary one for technology online tools');
      online_summary.focus();
      return false;
    }

    if(online_heading2.value == "" || online_heading2.value == " ")
    {
      alert('Please enter heading two for technology online tools');
      online_heading2.focus();
      return false;
    }
    if(online_summary2.value == "" || online_summary2.value == " ")
    {
						alert('Please enter summary two for technology online tools');
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
			var creative_design_title = document.getElementById('creative_design_heading');
			

    if(creative_design_title.value == "")
    {
						alert('Please enter title for creative web design');
      creative_design_title.focus();
      return false;
    }


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
	
	
	function creative_adv_tabs(tab_option)
	{
		var press = document.getElementById('press_advertisement');
		var outdoor = document.getElementById('outdoor_advertisement');
		var online = document.getElementById('online_advertisement');
		var exb = document.getElementById('exhibition_advertisement');
		

		
			    if(tab_option == "press_adv" && press.value == "")
    {
						alert('Please enter data for press advertisement');
      press.focus();
      return false;
    }		

			    if(tab_option == "outdoor_adv" && outdoor.value == "")
    {
						alert('Please enter data for outdoor advertisement');
      outdoor.focus();
      return false;
    }		
				
			    if(tab_option == "online_adv" && online.value == "")
    {
						alert('Please enter data for online advertisement');
      online.focus();
      return false;
    }		
				
				    if(tab_option == "exhibition" && exb.value == "")
    {
						alert('Please enter data for exihibition');
      exb.focus();
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
						alert('Please enter summary for languages copywriting');
      copywrite_summary.focus();
      return false;
    }

    if(copywrite_heading.value == "")
    {
						alert('Please enter heading for languages copywriting');
      copywrite_heading.focus();
      return false;
    }

    if(copywrite_summary2.value == "")
    {
						alert('Please enter summary two for languages copywriting');
      copywrite_summary2.focus();
      return false;
    }


    return true;			
		}
		
		
		
		
		function creative_interactive_validate()
		{
			var interactive_summary = document.getElementById('creative_interactive_summary');
			
			    if(interactive_summary.value == "" || interactive_summary.value == " ")
    {
						alert('Please enter summary for creative interactive');
      interactive_summary.focus();
      return false;
    }
				    return true;			
		}
		
			function crative_interactive_tabs(tab_option)
		{
			var creative_mobdevelopment = document.getElementById('creative_mobiledevelopment');
			var creative_books = document.getElementById('creative_ebooks');
			var creative_media = document.getElementById('media_presentation');			
			

			
			    if(tab_option == "creative_mobile_development" && creative_mobdevelopment.value == "")
    {
						alert('Please enter data for mobile development');
      creative_mobdevelopment.focus();
      return false;
    }
				
				    if(tab_option == "creative_ebooks" && creative_books.value == "")
    {
						alert('Please enter data for ebooks');
      creative_books.focus();
      return false;
    }			
	
					    if(tab_option == "creative_media_presentations" && creative_media.value == "")
    {
						alert('Please enter data for media presentations');
      creative_media.focus();
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
      alert('Please enter heading for technology');
      theading.focus();
      return false;
    }
    if(tsummary.value == "")
    {
						alert('Please enter summary for technology');
      tsummary.focus();
      return false;
    }
    return true;
  }	
		

		function technology_learning()
		{

    var learn_summary = document.getElementById('tech_learning_summary');

    if(learn_summary.value == "")
    {
						alert('Please enter summary for technology learning');
      learn_summary.focus();
      return false;
    }
    return true;
		}


			function tech_learning_tabs(tab_option)
		{
			var block_title1 = document.getElementById('tech_learn_title1');
			var block_summary1 = document.getElementById('tech_learn_block1');
		
			var block_title2 = document.getElementById('tech_learn_title2');
			var block_summary2 = document.getElementById('tech_learn_block2');

			var block_title3 = document.getElementById('tech_learn_title3');
			var block_summary3 = document.getElementById('tech_learn_block3');
			
			var block_title4 = document.getElementById('tech_learn_title4');
			var block_summary4 = document.getElementById('tech_learn_block4');
			
			var block_title5 = document.getElementById('tech_learn_title5');
			var block_summary5 = document.getElementById('tech_learn_block5');
			
			    if(tab_option == "block1" && block_title1.value == "")
    {
						alert('Please enter title for block');
      block_title1.focus();
      return false;
    }
				
				    if(tab_option == "block1" && block_summary1.value == "")
    {
						alert('Please enter summary for block');
      block_summary1.focus();
      return false;
    }			
	
		
				    if(tab_option == "block2" && block_title2.value == "")
    {
						alert('Please enter title for block');
      block_title2.focus();
      return false;
    }
				
				    if(tab_option == "block2" && block_summary2.value == "")
    {
						alert('Please enter summary for block');
      block_summary2.focus();
      return false;
    }			
	
	
	
				    if(tab_option == "block3" && block_title3.value == "")
    {
						alert('Please enter title for block');
      block_title3.focus();
      return false;
    }
				
				    if(tab_option == "block3" && block_summary3.value == "")
    {
						alert('Please enter summary for block');
      block_summary3.focus();
      return false;
    }			
	
	
				    if(tab_option == "block4" && block_title4.value == "")
    {
						alert('Please enter title for block');
      block_title4.focus();
      return false;
    }
				
				    if(tab_option == "block4" && block_summary4.value == "")
    {
						alert('Please enter summary for block');
      block_summary4.focus();
      return false;
    }			
	
	
				    if(tab_option == "block5" && block_title5.value == "")
    {
						alert('Please enter title for block');
      block_title5.focus();
      return false;
    }
				
				    if(tab_option == "block5" && block_summary5.value == "")
    {
						alert('Please enter summary for block');
      block_summary5.focus();
      return false;
    }			
	
		
	
				    return true;			
		}	


		function tech_commerce()
		{

    var commercesummary = document.getElementById('commerce_summary');

    if(commercesummary.value == "")
    {
						alert('Please enter summary for technology commerce');
      commercesummary.focus();
      return false;
    }
    return true;
		}
		
			function tech_security()
		{

    var techsecurity = document.getElementById('security_summary');

    if(techsecurity.value == "")
    {
						alert('Please enter summary for online security');
      techsecurity.focus();
      return false;
    }
				
    return true;
		}	
		

			function tech_crm()
		{

    var techcrm = document.getElementById('crm_summary');

    if(techcrm.value == "")
    {
						alert('Please enter summary for technology CRM');
      techcrm.focus();
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