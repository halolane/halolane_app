$(document).ready(function(){
	$('a').tooltip();
	$(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();
	$(".icon-add-contributor img").fadeTo("fast", 0.6);
	$('.icon-add-contributor img').hover(function() {
		$(this).fadeTo('fast',1);
	}, function() {
   	$(this).fadeTo("fast", 0.6);
 	});
	$('.icon-add-contributor img').click(function() {
		$(this).fadeTo('fast',1);
	});

	$('#newmemory').collapse("hide");

});
