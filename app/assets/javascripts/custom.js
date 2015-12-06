$(document).ready(function(){
	$('#questionUpvoteButton').on("click",function(event){
		var qid = $(event.target).data("qid");
		$.ajax({
			method:"post",
			url:"/questions/"+qid+"/votes",
			data:"upvote=true"
		}).done(function(result){
			$("#questionVote").replaceWith(result);
		}).fail(function(error){
			console.log(error);
		});
	});

	$('#questionDownvoteButton').on("click",function(event){
		var qid=$(event.target).data("qid");
		$.ajax({
			method:"post",
			url:"/questions/"+qid+"/votes",
			data:"upvote=false"
		}).done(function(result){
			$("#questionVote").replaceWith(result);
		}).fail(function(error){
			console.log(error);
		});
	});

	$('#answerRow').on("click",".glyphicon-triangle-top",function(event){
		var aid=$(event.target).data("aid");
		$.ajax({
			method:"post",
			url:"/answers/"+aid+"/votes",
			data:"upvote=true"
		}).done(function(result){
			$("#answerCount"+aid).replaceWith(result);
		}).fail(function(error){
			console.log(error);
		});
	});

	$('#answerRow').on("click",".glyphicon-triangle-bottom",function(event){
		var aid=$(event.target).data("aid");
		$.ajax({
			method:"post",
			url:"/answers/"+aid+"/votes",
			data:"upvote=false"
		}).done(function(result){
			$("#answerCount"+aid).replaceWith(result);
		}).fail(function(error){
			console.log(error);
		});
	});

	$('#answerRow').on("mouseenter",".glyphicon-triangle-bottom",function(event) {
		$(this).css("color", "orange");
	});

	$('#answerRow').on("mouseleave",".glyphicon-triangle-bottom",function(event) {
		$(this).css("color", "grey");
	});

	$('#answerRow').on("mouseenter",".glyphicon-triangle-top",function(event) {
		$(this).css("color", "orange");
	});

	$('#answerRow').on("mouseleave",".glyphicon-triangle-top",function(event) {
		$(this).css("color", "grey");
	});

	$('#questionUpvoteButton').on("mouseenter", function(event) {
		$(this).css("color", "orange");
	});

	$('#questionUpvoteButton').on("mouseleave", function(event) {
		$(this).css("color", "grey");
	});

	$('#questionDownvoteButton').on("mouseenter",function(event) {
		$(this).css("color", "orange");
	});

	$('#questionDownvoteButton').on("mouseleave", function(event) {
		$(this).css("color", "grey");
	});

});