jQuery(document).on('ready turbolinks:load', function(){
		jQuery(document).on('railsAutocomplete.select', '#material_name', function(event, data){
				jQuery('#material_id').val(data.item.id);
			});
		jQuery(document).on('railsAutocomplete.select', '#worker_name', function(event, data){
				jQuery('#worker_id').val(data.item.id);
			});
	});
