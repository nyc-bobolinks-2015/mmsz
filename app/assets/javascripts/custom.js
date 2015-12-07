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

	$('#new_answer').on("submit", function(event){
		event.preventDefault();
		$.ajax({
			method:"post",
			url: $(event.target).attr('action'),
			data: $(event.target).serialize()
		}).done(function(result){
			$("#answerRow").append(result);
		}).fail(function(error){
			console.log(error);
		});
	});

	$('.addCommentButton').on("click", "a", function(event){
		event.preventDefault();

		$.ajax({
			method: "get",
			url: $(event.target).attr("href")
		}).done(function(result){
			$(event.target).prepend(result);
		}).fail(function(error){
			console.log(error);
		})
	});

	// $('.addCommentButton').on("click", function(event){
	// 	alert("hello")
	// 	event.preventDefault();

	// 	$.ajax({
	// 		method: "post",
	// 		url: $(event.target).attr("action"),
	// 		data: $(event.target).serialize
	// 	}).done(function(result){
	// 		console.log(result);
	// 	}).fail(function(error){
	// 		console.log(error);
	// 	})
	// });

});