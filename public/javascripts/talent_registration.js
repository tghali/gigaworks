function email_check(mail)
{
// alert("hey");
  //mail = document.getElementById('gigaclient_email');
  var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
  alert("hello");
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
			alert("Invalid Email Format");
			mail.focus();
                         document.getElementById('check').style.display='none';
			return false;
	}
	document.getElementById('check').style.display='block';
}
if (mail.value!="")
{
   document.getElementById('check').style.display='block';
}
   return true;
   
}


function valid_talent_details()
{
	f_name = document.getElementById('talent_first_name');
	l_name = document.getElementById('talent_last_name');
	mail = document.getElementById('talent_email');
	//client_user = document.getElementById('talent_username');
	pwd = document.getElementById('talent_password');
	confirm_pwd = document.getElementById('talent_password_confirmation');
	//country = document.getElementById('talent_country');

	var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;

	if(f_name.value == "")
	{
		
		alert('Please enter first name');
		f_name.focus();
		return false;
		
	}
	
		if(f_name.value.charAt(0) == ' ')
	{
		alert('First name should be in characters');
		f_name.focus();as
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
	

	
	/*	if(client_user.value == "")
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

	if(pwd.value.length < 7)
	{
		alert('Password must be 7 characters');
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
            if(!pwd.value.match(/([0-9]|[\~|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\
+|\_])+/))
            {
           alert("invalid password must have a digit or a special character")
           pwd.focus();
           return false;
          }
	/*if(country.value == "")
	{
		
		alert('Please enter Country name');
		country.focus();
		return false;
		
	}*/
	
	return true;
	
	
	
}

function talent_validate()
{ 
	f_name = document.getElementById('talent_first_name');
	l_name = document.getElementById('talent_last_name');
	mail = document.getElementById('talent_email');
 phone = document.getElementById('talent_phone');
company=document.getElementById('talent_company');
f_line= document.getElementById('talent_first_line');
s_line= document.getElementById('talent_second_line');
city= document.getElementById('talent_city');
state=document.getElementById('talent_state');
z_code=document.getElementById('talent_zip_code');
	var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;

	if(f_name.value == ""  || f_name.value=="First")
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
	
	
	if(l_name.value == "" || l_nme.value=="Last")
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
       if(phone.value=="Phone")
       {
         phone.value="";
       }
       if(company.value=="Company")
       {
         company.value="";
       }
       if(f_line.value=="Street")
       {
          f_line.value="";
       }
       if(s_line.value=="Flat #")
       {
         s_line.value="";
       }
       if(city.value=="City")
       {
         city.value="";
       }
       if(state.value=="State")
       {
         state.value="";
       }
      if(z_code.value=="Post Code")
      {
        z_code.value="";
      }

       
	
	
	return true;
	
	
}
