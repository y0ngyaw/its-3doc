$(document).ready(function() {
	$('#small-screen-btn').click(function() {
		var width = window.screen.width;
		console.log(width);
		$('.middle-panel').fadeToggle();
		$('.right-panel').fadeToggle();
	})
})