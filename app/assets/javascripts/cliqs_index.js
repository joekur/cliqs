$(document).ready(function() {
	
	//
	// ADD NEW POST
	//
	
	var newPostBtn = $('#new_post_btn');
	var newPostContainer = $('#new_post_container');
	var postBody = $('textarea.add_post_body');
	var newPostForm = $('form.new_post_form');
	
	function newPostClick() {
		newPostContainer.toggle(0, function() {
			if (newPostBtn.text() == 'New Post') {
				newPostBtn.text('Discard');
				postBody.focus().css("height", "");
			} else {
				newPostBtn.text('New Post');
			}
		});
		postBody.val('');
	}
	
	newPostBtn.click( newPostClick );
	
	newPostForm.bind("ajax:beforeSend", function(xhr, settings) {
		console.log('starting');
	});
	newPostForm.bind("ajax:complete", function(event, data, status, xhr) {
		data = $.parseJSON(data.responseText);
		console.log(data.success);
		console.log(data['success']);
	});
	
	
	//
	// COMMENTS
	//
	
	var new_comment_btns = $('button.add_comment_btn');
	var submit_comment_btns = $('button.submit_comment_btn');
	var new_comment_forms = $('form.new_comment_form');
	var cancel_comment_btn = $('button.cancel_comment_btn');
	var show_hidden_comments_link = $('.show_hidden_comments a')
	
	new_comment_btns.live(
		'click',
		function() {
			console.log('new comment desired');
			$(this).parent().next('.add_comment_container')
				.show(0, function(){
					console.log($(this).find('textarea'));
					$(this).find('textarea').focus().css("height", "");
				});
				
		}
	);
	
	cancel_comment_btn.live(
		'click',
		function() {
			var me = $(this).parent().parent().hide();
			me.find('textarea.add_comment_body').val('');
		}
	);
	
	show_hidden_comments_link.click(function() {
		var parent = $(this).parent();
		parent.hide();
		parent.next('.hidden_comments').children().unwrap();
		return false;
	});
	
	
	//
	// LOAD NEW CONTENT
	//
	
	
	
	//
	// TEXT AREAS
	//
	
	var expandables = $('textarea.expandable');
	
	expandables.live("keypress", function() {
		if ($(this).scrollTop() > 0) {
			var height = $(this).height();
			$(this).css('height', height + 50);
		}
	});
	
	
});
