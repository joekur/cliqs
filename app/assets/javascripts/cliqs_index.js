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
        newPostContainer.hide();
        newPostBtn.text('New Post');
	});
	newPostForm.bind("ajax:complete", function(event, data, status, xhr) {
		data = $.parseJSON(data.responseText);
	});
	
	
	//
	// COMMENTS
	//
	
	var new_comment_btns = $('button.add_comment_btn');
	var submit_comment_btns = $('button.submit_comment_btn');
	var new_comment_forms = $('form.new_comment_form');
	var cancel_comment_btn = $('button.cancel_comment_btn');
	var show_hidden_comments_link = $('.show_hidden_comments a')

    // show new comment div
	new_comment_btns.live(
		'click',
		function() {
			$(this).parent().next('.add_comment_container')
				.show(0, function(){
					console.log($(this).find('textarea'));
					$(this).find('textarea').focus().css("height", "");
				});
				
		}
	);

    // if cancel a comment, hide div and clear comment textarea
	cancel_comment_btn.live(
		'click',
		function() {
			var me = $(this).parent().parent().hide();
			me.find('textarea.add_comment_body').val('');
		}
	);

    // expand and show comments that are hidden when a post has more than 2 comments
	show_hidden_comments_link.click(function() {
		var parent = $(this).parent();
		parent.hide();
		parent.next('.hidden_comments').children().unwrap();
		return false;
	});

    // after ajax call is prepared, hide div and clear textarea
    new_comment_forms.bind("ajax:beforeSend", function() {
        $(this).parents('.add_comment_container').hide().find('textarea').val('');
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
