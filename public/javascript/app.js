$(function() {
	$("#search").click(function(e){
		e.preventDefault();
		$.post("/search", $("#form").serialize(),function(data){
			$("#commits").html(data);
		});
	});
});