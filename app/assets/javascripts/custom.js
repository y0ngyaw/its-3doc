$(document).ready(function() {
	if ( $('.proposal-wrapper').children().length == 0 ){
		$('.proposal-wrapper').hide();
	}

	$('#small-screen-btn').click(function() {
		var width = window.screen.width;
		console.log(width);
		$('.middle-panel').toggle();
		$('.right-panel').toggle();
	})
})