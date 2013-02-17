$(document).ready(function(){

	$('a').tooltip({
  	placement : 'bottom'
  });
  $('img').tooltip({
  	placement : 'top'
  });
	$(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();

	$(".iconaddcontributor").fadeTo("fast", 0.6);
	$('.iconaddcontributor').hover(function() {
		$(this).fadeTo('fast',1);
	}, function() {
   	$(this).fadeTo("fast", 0.6);
 	});
	$('.iconaddcontributor').click(function() {
		$(this).fadeTo('fast',1);
	});

	$('#newmemory').collapse("hide");

	$(".composerBox").click(function(e) {
		$('.messageBoxContainer').toggleClass("expanded");
		$('.messageBoxContainer').toggleClass("collapsed");
		$('.btn-post').toggleClass("hidden");
		$('.addphoto-icon').toggleClass("hidden");
		$('.messageTools').toggleClass("hidden");
		$('#memorycounter').text("250");
	});

	$('.messageBoxContainer').bind('clickoutside', function (event) {
		if($('.messageBoxContainer').hasClass('expanded')){    
	    $('.messageBoxContainer').removeClass("expanded");
			$('.messageBoxContainer').addClass("collapsed");
			$('.btn-post').addClass("hidden");
			$('.addphoto-icon').addClass("hidden");
			$('.messageTools').addClass("hidden");
		}
		if(!$('.addphoto').hasClass('hidden')){
			$('.addphoto').addClass("hidden");
		}
  })


	$('.addphoto-icon ').hover(function() {
		$(this).fadeTo('fast',1);
	}, function() {
   	$(this).fadeTo("fast", 0.6);
 	});

 	$('.addphoto-icon').click(function() {
 		$('.addphoto-icon').fadeTo('fast',1);
 		$('.addphoto').toggleClass("hidden");
 	});

	$('#memory_content').keyup(function () {
    var left = 250 - $(this).val().length;
    if (left < 0) {
        left = 0;
    }
    $('#memorycounter').text(left);
	});
	

});
