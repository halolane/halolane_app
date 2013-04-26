$(document).ready(function(){



	$('a').tooltip({
  	placement : 'bottom'
  });
  $('img').tooltip({
  	placement : 'top'
  });
	$(".tooltip").tooltip();
  $("a[rel=tooltip]").tooltip();

 


	$(".iconaddcontributor, .playslideshow").fadeTo("fast", 0.6);
	$(".iconaddcontributor, .playslideshow").hover(function() {
		$(this).fadeTo('fast',1);
	}, function() {
   	$(this).fadeTo("fast", 0.6);
 	});
	$(".iconaddcontributor, .playslideshow").click(function() {
		$(this).fadeTo('fast',1);
	});

	$(".playslideshow").click(function() {
		$('#slideshow').removeClass("hide");
	 	$('.flexslider').flexslider({
	    	animation: "slide"
		});
	});


	$('#newmemory').collapse("hide");

	$(".composerBox").click(function(e) {
		
		if($('.messageBoxContainer').hasClass('collapsed')){   
			$('.messageBox').removeClass("withphoto");
		$('.messageSection').removeClass ("withphoto");
	    	$('.messageBoxContainer').addClass("expanded");
			$('.messageBoxContainer').removeClass("collapsed");
			$('.btn-post').removeClass("hidden");
			$('.addphoto-icon').removeClass("hidden");
			$('.messageTools').removeClass("hidden");
			if ($('#memory_content').val() == ""){
				$('#memorycounter').text('250');
			}
		}
	});

	$('.messageBoxContainer').bind('clickoutside', function (event) {
		$('.messageBox').removeClass("withphoto");
		$('.messageSection').removeClass ("withphoto");
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
 		$('.messageSection').toggleClass ("withphoto");
 		$('.messageBox').toggleClass ("withphoto");
 	});

	$('#memory_content').keypress(function (e) {
		if((e.which == 13) || (e.which < 0x20)) {
      e.preventDefault();
      return false;
    }
    
    var left = 250 - $(this).val().length;
    if (left < 0) {
        $('#memorycounter').addClass("text-error");
    }
    $('#memorycounter').text(left);
	    
	});


	var $container = $('#content');

  $container.imagesLoaded( function() {
    $container.isotope({
      itemSelector : '.newbox', 
     /* filter: '*',*/
      layoutMode: 'masonryHorizontal',
      animationEngine: 'jquery',
      animationOptions: {
         easing: 'linear',
         queue: false,
       }
    });
  });

});
