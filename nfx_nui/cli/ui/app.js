$(document).ready(function(){
	var audioPlayer = null;

	window.addEventListener("message",function(event){
		
		if(event.data.type == "notify") {

			var html = "<div id='"+event.data.css+"'>"+event.data.mensagem+"</div>"
			$(html).appendTo("#notifications").hide().fadeIn(1000).delay(event.data.ms).fadeOut(1000);

		}else if(event.data.type == "progress") {

			if (event.data.display === true) {
				$("#tbody").show();
				var start = new Date();
				var maxTime = event.data.time;
				var text = event.data.text;
				var timeoutVal = Math.floor(maxTime/100);
				animateUpdate();

				$('#pbar_innertext').text(text);

				function updateProgress(percentage) {
					$('#pbar_innerdiv').css("width",percentage+"%");
				}

				function animateUpdate() {
					var now = new Date();
					var timeDiff = now.getTime() - start.getTime();
					var perc = Math.round((timeDiff/maxTime)*100);
					if (perc <= 100) {
						updateProgress(perc);
						setTimeout(animateUpdate, timeoutVal);
					} else {
						$("#tbody").hide();
					}
				}
			} else {
				$("#tbody").hide();
			}

		}else if(event.data.type == "sounds") {
			
			if (audioPlayer != null){ audioPlayer.pause(); }
			audioPlayer = new Audio("./sounds/"+event.data.transactionFile+".ogg");
			audioPlayer.volume = event.data.transactionVolume;
			audioPlayer.play();
			
		}		
	})
});