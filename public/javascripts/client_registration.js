// JavaScript Document

function email_check(mail)
{
// alert("hey");
  //mail = document.getElementById('gigaclient_email');
  var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
  /*if(mail.value == "")
	{
		
		alert('Please enter email address');
		mail.focus();
                document.getElementById('check').style.display='none';
		return false;
		
	}*/
if (mail.value!="")
{
if(!mail.value.match(emailExp))
	{
			//alert("Invalid Email Format");
			//mail.focus();
                         document.getElementById('check').style.display='none';
			return false;
	}
	document.getElementById('check').style.display='block';
   return true;
}
if (mail.value=="")
{
   document.getElementById('check').style.display='none';
}
   
}
function passwd(pwd)
{
        var passExp =  /([A-Z])+([a-z])+([0-9])+/g;
//alert(pwd.value.match(passExp));
        if(!pwd.value.match(/([A-Z])+/))
        {
           alert("invalid password")
           //pwd.focus();
           return false;
          }
          if(!pwd.value.match(/([a-z])+/))
          {
                      alert("invalid password")
           //pwd.focus();
           return false;
          }
            if(!pwd.value.match(/([0-9]|[\~|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\+|\_])+/))
            {
           alert("invalid password")
           //pwd.focus();
           return false;
          }


return true;
}

function valid_register()
{
	f_name = document.getElementById('gigaclient_first_name');
	l_name = document.getElementById('gigaclient_last_name');
	mail = document.getElementById('gigaclient_email');
	//client_user = document.getElementById('gigaclient_username');
	pwd = document.getElementById('gigaclient_password');
	confirm_pwd = document.getElementById('gigaclient_password_confirmation');
		company = document.getElementById('gigaclient_company');
		industry = document.getElementById('gigaclient_industry');
		turnover = document.getElementById('gigaclient_turnover');
	
 
	card_no = document.getElementById('credit_card');
	verify_value = document.getElementById('card_card_expirty_date_1i');
	verification = document.getElementById('verification_number');
	card_verification = document.getElementById('card_type');
 
	zip = document.getElementById('billing_zip');
	
 
	
	var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/
	
	if(f_name.value == "")
	{
		
		alert('Please enter first name');
		f_name.focus();
		return false;
		
	}
	
		if(f_name.value.charAt(0) == ' ')
	{
		alert('First name should be in characters');
		f_name.focus();
		return false;
	}
	
	
	if(l_name.value == "")
	{
		
		alert('Please enter last name');
		l_name.focus();
		return false;
		
	}
	
		if(l_name.value.charAt(0) == ' ')
	{
		alert('Last name should be in characters');
		l_name.focus();
		return false;
	}
	
	if(mail.value == "")
	{
		
		alert('Please enter email address');
		mail.focus();
		return false;
		
	}
	

	if(!mail.value.match(emailExp))
	{
			alert("Invalid Email Format");
			mail.focus();
			return false;
	}
	

	
		/*if(client_user.value == "")
	{
		
		alert('Please enter username');
		client_user.focus();
		return false;
		
	}*/	
	
	
	if(pwd.value == "")
	{
		
		alert('Please enter password');
		pwd.focus();
		return false;
		
	}

	if(pwd.value.length < 6)
	{
		alert('Password must be 6 characters');
		pwd.focus();
		return false;
	}	
	
		if(confirm_pwd.value == "")
	{
		
		alert('Please enter confirmation password');
		confirm_pwd.focus();
		return false;
		
	}
	
	if(pwd.value != confirm_pwd.value)
	{
		alert('Password mismatch. Please retype correct password');
		confirm_pwd.value = "";
		confirm_pwd.focus();
		return false;
	}
        
        if(!pwd.value.match(/([A-Z])+/))
        {
           alert("invalid password must have a captial letter")
           pwd.focus();
           return false;
          }
          if(!pwd.value.match(/([a-z])+/))
          {
                      alert("invalid password must have a small letter")
           pwd.focus();
           return false;
          }
            if(!pwd.value.match(/([0-9]|[\~|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\+|\_])+/))
            {
           alert("invalid password must have a digit or a special character")
           pwd.focus();
           return false;
          }
	
	if(company.value == "")
	{
		
		alert('Please enter company name');
		company.focus();
		return false;
		
	}
	
		if(company.value.charAt(0) == ' ')
	{
		alert('Company should be in characters');
		company.focus();
		return false;
	}	
	
	
	
		if(industry.value == "")
	{
		
		alert('Please enter industry type');
		industry.focus();
		return false;
		
	}
	
			if(turnover.value == "")
	{
		
		alert('Please enter turnover');
		turnover.focus();
		return false;
		
	}
	
		if(card_no.value == "")
	{
		
		alert('Please enter valid credit card number');
		card_no.focus();
		return false;
		
	}
	
	if(verify_value.value == "")
	{
		
		alert('Please enter verification number');
		verify_value.focus();
		return false;
		
	}
	
		if(verification.value == "")
	{
		
		alert('Please enter verification number');
		verification.focus();
		return false;
		
	}
 
 		if(card_verificatio.value == "")
	{
		
		alert('Please enter card type');
		card_verificatio.focus();
		return false;
		
	}
	
	if(zip.value == "")
	{
		
		alert('Please enter billing zip');
		zip.focus();
		return false;
		
	}
	
	
	
	
	return true;
	
	
	
}
