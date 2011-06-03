// JavaScript Document
//Dynamic Text Counter (Javascript) is Copyright TextMechanic.com All Rights Reserved

function cleartext(){
document.form_count.input.value = '';
document.form_count.char_count.value = '0';
document.form_count.c.value = '0';
document.form_count.s.value = '0';
document.form_count.line_count.value = '0';
document.form_count.custom_count.value = '0'}
function linecnt(){
setTimeout(linecnt2,100);}
function linecnt2(){
if(document.form_count.input.value.length > 0){
fc=document.form_count;
fc.line_count.value=fc.input.value.split(/\n/).length;}
else document.form_count.line_count.value = '0';}
function sentcnt(){
setTimeout(sentcnt2,100);}
function sentcnt2(){
var sentcont = document.form_count.input.value;
var belong2 = 'pbclevtug grkgzrpunavp.pbz';
sentcont = sentcont.replace(/\r/g,'');
sentcont = sentcont.replace(/  /g,' ');
sentcont = sentcont.replace(/ \n/g,'\n');
sentcont = sentcont + '\n';
sentcont1 = sentcont.split('. ').length -1;
sentcont1b = sentcont.split('.\n').length -1;
sentcont2 = sentcont.split('! ').length -1;
sentcont2b = sentcont.split('!\n').length -1;
sentcont3 = sentcont.split('? ').length -1;
sentcont3b = sentcont.split('?\n').length -1;
sentcontout = sentcont1 + sentcont1b + sentcont2 + sentcont2b + sentcont3 + sentcont3b;
document.form_count.s.value = sentcontout;}
function cuscnt(){
setTimeout(cuscnt2,100);}
function cuscnt2(){
if (document.form_count.case_sen.checked == true){var char=document.form_count.custom_count_query.value; var z=document.form_count.input.value;}
else {var char=document.form_count.custom_count_query.value.toLowerCase(); var z=document.form_count.input.value.toLowerCase();}
var charlen = char.length;
a=z.split(char);
if (charlen > 0) carcnt = a.length-1; else carcnt = "0";
document.form_count.custom_count.value = carcnt;}
function tolcnt(){
setTimeout(tolcnt2,100);}
function tolcnt2(){
if (document.form_count.no_spaces.checked == true){
var y=document.form_count.input.value;
var spacecnt=y.split(' ').length;
a=y.replace(/\n/g,'');
b=a.replace(/\r/g,'');
z=b.length-spacecnt;
document.form_count.char_count.value=z+1;} else{
var y=document.form_count.input.value;
a=y.replace(/\n/g,'');
b=a.replace(/\r/g,'');
z=b.length;
document.form_count.char_count.value=z;}}
function wrdcnt(){
setTimeout(wrdcnt2,100);}
function wrdcnt2(){
var y=document.form_count.input.value;
var r = 0;
a=y.replace(/[[A-Za-z]\s]/g,' ');
//a=y.replace(/\s/g,' ');
a=a.split(' ');
for (z=0; z<a.length; z++) {if (a[z].length > 0) r++;}
document.form_count.c.value=r;}
function SelectAll(id) {
document.getElementById(id).focus();
document.getElementById(id).select();}
function loadfile(ele){
var finput = document.getElementById(ele);
var textarea2load = document.getElementById('input');
textarea2load.value = 'Loading...';
var redr = new FileReader();
redr.readAsText(finput.files[0]);
redr.onload = function(asdfg){textarea2load.value = asdfg.target.result;}}