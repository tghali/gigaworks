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



  function lang_validate()
  {

    var lheading = document.getElementById('lang_heading');
    var lsummary = document.getElementById('lang_summary');
    if(lheading.value == "")
    {
      alert('Please enter heading');
      lheading.focus();
      return false;
    }
    if(lsummary.value == "")
    {
						alert('Please enter heading');
      lheading.focus();
      return false;
    }
    return true;
  }
		
	  function creative_validate()
  {
			 var h1 = document.getElementById('cheading1');
				var h2 = document.getElementById('cheading2');
    var s1 = document.getElementById('csummary1');
    var s2 = document.getElementById('csummary2');
    if(h1.value == "")
    {
      alert('Please enter heading one');
      h1.focus();
      return false;
    }
    if(s1.value == "")
    {
						alert('Please enter summary one');
      s1.focus();
      return false;
    }

    if(h2.value == "")
    {
      alert('Please enter heading two');
      h2.focus();
      return false;
    }
    if(s2.value == "")
    {
						alert('Please enter summary two');
      s2.focus();
      return false;
    }


    return true;
  }	
		
		
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