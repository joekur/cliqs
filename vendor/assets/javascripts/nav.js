
$(document).ready( function() {
	
	/* SETTINGS DROPDOWN ------------------------------------------------------*/
	
	var mainSettingsDropdown = $('#mainSettingsDropdown');
	var mainSettingsLink = $('#mainSettingsLink');
	mainSettingsDropdown.hide();
	mainSettingsLink.click( function(){
		mainSettingsDropdown.toggle();
		mainSettingsLink.toggleClass('mainSettingsLinkActive');
	});
	
	
	/* SORT CLIQS -----------------------------------------------------------*/
	
	var save_container = $('.save_cliq_order_box');
	var save_button = $('a#save_cliq_order');
	
	$('a#edit_cliq_order').click( function() {
		console.log('start sorting!');
		$('ul.mainnav').sortable( {axis : 'x'} ).disableSelection();
		mainSettingsDropdown.trigger('click');
		save_container.slideDown('fast');
		
		return false;
	});
	
	
	save_button.click( function() {
		console.log('save order');
		var cliq_list = $('ul.mainnav li');
		var data = [];
		cliq_list.each( function() {
			var cliqmem_id = $(this).attr('id');
			cliqmem_id = cliqmem_id.substr(7); // id format is cliqnav1, cliqnav92
			data.push(parseInt(cliqmem_id));
		});
		
		console.log(data);
		
		var action = $(this).attr('action');
		$.ajax({
			type: "GET",
			url: action,
			data: {data :data}
		});
		
		save_container.slideUp('fast');
		return false;
	});
	
});