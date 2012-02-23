$(document).ready(function() {
	
	var profPic = $('.profile_picture');
	var editPicLink = $('.profile_picture .edit_picture');
	
	profPic.hover(profPicHover, profPicUnhover);
	
	function profPicHover() {
		editPicLink.show();
	}
	
	function profPicUnhover() {
		editPicLink.hide();
	}
	
	
	
	// EDIT PROFILE PIC -----------------------------------------------//
	
	var profPicForm = $('form.edit_prof_pic');
	var rightContent = $('.right_half');
	var loadingGif = $('img.loading');
	var uploadBtn = $('form.edit_prof_pic .uploadPic');
	
	profPicForm.submit(function(){
		loadingGif.show();
		rightContent.show();
		uploadBtn.attr('disabled', 'disabled');
		uploadBtn.addClass('disabled');
	});
	
	
	
});


function prepareProfPicJcrop(pic) {
	console.log('jcrop!');
	console.log(pic);
	pic.Jcrop({
		onChange: updateCrop,
		onSelect: updateCrop,
		aspectRatio: 1,
		bgOpacity: 1
	});
}

function updateCrop(coords) {
	$('#crop_x').val(coords.x);
	$('#crop_y').val(coords.y);
	$('#crop_w').val(coords.w);
	$('#crop_h').val(coords.h);  
}
