$(document).ready(function() {
	
	//
	// ADD NEW POST
	//
	
	var newPostBtn = $('#new_post_btn');
	var newPostContainer = $('#new_post_container');
	var postBody = $('textarea.add_post_body');
	var newPostForm = $('form.new_post_form');
	
	function newPostClick() {		
		if (newPostBtn.text() == 'New Post') {
			newPostBtn.text('Discard');
		} else {
			newPostBtn.text('New Post');
		}
		
		newPostContainer.toggle();
		postBody.val('');
	}	
	
	newPostBtn.click( newPostClick );
	
	
	
	function jsonResponse_AddPost(data) {
		console.log(data);
		if (data.success) {
			newPostContainer.hide();
			newPostBtn.text('New Post');
			
			// add new post to DOM
			$('#post_wall').prepend(data.html);
		} else {
			//TODO
			console.log('failure!');
		}
		
	}	
	
	newPostForm.submit( function() {
		if (!postBody.val()) { // if empty post, do nothing
			return false;
		}
		var submitTo = newPostForm.attr('action');
		console.log( submitTo );
		
		var options = {
			dataType:  'json',
			success: jsonResponse_AddPost,
			resetForm: true
		}
		
		$(this).ajaxSubmit(options); // from jquery_form.js
		
		return false; // prevent normal submit
	});
	
	
	//
	// COMMENTS
	//
	
	var new_comment_btns = $('button.add_comment_btn');
	var submit_comment_btns = $('button.submit_comment_btn');
	var new_comment_forms = $('form.new_comment_form');
	var cancel_comment_btn = $('button.cancel_comment_btn');
	
	new_comment_btns.live(
		'click',
		function() {
			console.log('new comment desired');
			console.log($(this).parent().next('.add_comment_container'));
			$(this).parent().next('.add_comment_container').show(); // new comment container
		}
	);
	
	cancel_comment_btn.live(
		'click',
		function() {
			var me = $(this).parent().parent().hide();
			me.find('textarea.add_comment_body').val('');
		}
	);
	
	function jsonResponse_AddComment(data, statusText, xhr, $form) {
		console.log('new comment response');
		if (data.success) {
			console.log($form.parent().parent().append(data.html));
		} else {
			//TODO
			console.log('new comment failure');
		}
	}
	
	new_comment_forms.live(
		'submit', 
		function() {
			var submitTo = $(this).attr('action');
			console.log( submitTo );
			
			var options = {
				dataType: 'json',
				success: jsonResponse_AddComment,
				resetForm: true
			}
			
			$(this).ajaxSubmit(options);
			
			$(this).parent().hide();
			
			return false;
		}
	);
	
	
	//
	// LOAD NEW CONTENT
	//
	
	
	
	
});
