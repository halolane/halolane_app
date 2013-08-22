$(document).ready(function(){
	

	//=================================== Sticky nav ===================================//
	$("nav").sticky({topSpacing:0});


 	//=================================== Nav Responsive ===================================//
    $('#menu').tinyNav({
       active: 'selected'
    });
	
	
	//=================================== Newsletter form ===================================//
	$("#newsletter").submit(function() {
		$.ajax({
			type : "POST",
			url : "newsletter.php",
			dataType : "html",
			data : $(this).serialize(),
			beforeSend : function() {
				$("#loadingNews").show();
			},
			success : function(response) {
				$("#responseNews").html(response);
				$("#loadingNews").hide();
			}
		})
		return false;
	});
	
	//=================================== Contact form ===================================//

	$("#contact2").submit(function() {
		$.ajax({
			type : "POST",
			url : "send_mail.php",
			dataType : "html",
			data : $(this).serialize(),
			beforeSend : function() {
				$("#loading").show();
			},
			success : function(response) {
				$("#response").html(response);
				$("#loading").hide();
			}
		})
		return false;
	});


	//=================================== Lightbox  ===================================//
	
    jQuery("a[class*=fancybox]").fancybox({
		'overlayOpacity'	:	0.7,
		'overlayColor'		:	'#000000',
		'transitionIn'		: 'elastic',
		'transitionOut'		: 'elastic',
		'easingIn'      	: 'easeOutBack',
		'easingOut'     	: 'easeInBack',
		'speedIn' 			: '700',
		'titlePosition'		: 'over',
		'centerOnScroll'	: true

	});
	
	jQuery("a[class*='video_lightbox']").click(function(){
		var et_video_href = jQuery(this).attr('href'),
			et_video_link;

		et_vimeo = et_video_href.match(/vimeo.com\/(.*)/i);
		if ( et_vimeo != null )	et_video_link = 'http://player.vimeo.com/video/' + et_vimeo[1];
		else {
			et_youtube = et_video_href.match(/watch\?v=([^&]*)/i);
			if ( et_youtube != null ) et_video_link = 'http://youtube.com/embed/' + et_youtube[1];
		}
		
		jQuery.fancybox({
			'overlayOpacity'	:	0.7,
			'overlayColor'		:	'#000000',
			'autoScale'		: true,
			'transitionIn'	: 'elastic',
			'transitionOut'	: 'elastic',
			'easingIn'      : 'easeOutBack',
			'easingOut'     : 'easeInBack',
			'type'			: 'iframe',
			'centerOnScroll'	: true,
			'speedIn' 			: '700',
			'href'			: et_video_link
		});
		return false;
	});

	
	//=================================== Tooltips =====================================//
	
	if( $.fn.tooltip() ) {
		$('[class="tooltip_hover"]').tooltip();
	}

	//=================================== Scroll =====================================//

 	function scrollTo(target){
          var targetPosition = $(target).offset().top;
          $('html,body').animate({ scrollTop: targetPosition}, 'slow');
        }

    //=================================== Carousel Services =====================================//

    $('.flexslider').flexslider({
	   	animation: "slide",
	   	animationLoop: false,
	   	itemWidth: 200,
	   	slideshow: false, 
	   	itemMargin: 0,
	   	minItems: 1,
	   	maxItems: 3
  	});
	

    //=================================== Princing Tables =====================================//

  	$(function() {
         $('#dg-container').gallery();
    });

  	//=================================== Efect Image Gallery =====================================//

    var $portfolioItem = jQuery('.resalt');
        $portfolioItem.hover(function(){             
            jQuery(this).find('.resalte').stop(true, true).animate({right: 0, top: 0},600);            
         }); 

                 
});
	


	