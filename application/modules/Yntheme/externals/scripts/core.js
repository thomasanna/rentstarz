function yntheme_switch(e){
	var d = e.getAttribute('alt');
	Cookie.write('yntheme_skin',d,{duration:30,path : en4.core.baseUrl});
	window.location.href = window.location.href;
}