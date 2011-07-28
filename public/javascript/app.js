$(function() {
	$("#search").click(function(){
		$.post("/search", $("#form").serialize(),function(data){
			$("#commits").html(data);
		});
	});
});