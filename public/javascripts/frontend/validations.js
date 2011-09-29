// JavaScript Document
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