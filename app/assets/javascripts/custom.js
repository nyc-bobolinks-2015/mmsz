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

});