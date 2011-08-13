/* javascript.js
* Javascript functions
* Author: David Anderson 2010
* dave@veodesign.co.uk
*/

/*******************************************
 *
 * CAROUSEL CODE 
 * Functions and Init for the carousel
 * 
 * Params:
 * 
 * wrapper - identifier to unique wrapper
 * controller - object holding next, 1,2,3,etc,prev links
 * duration - time between transitions
 *
**
*****************************************/

function initCarousel(idPrefix,duration){
	
	//convert the prefix into names
	wrapper='#'+idPrefix+'inner';
	controller='#'+idPrefix+'controller';
	
	//set initial active count and numbers
	$(wrapper).attr('active',1);
	$(wrapper).attr('queued',0);
	$(wrapper).attr('paused',0);
	$(wrapper).attr('animating',0);
	$(wrapper).attr('count',$(wrapper).children().length);
	
	//attach click handlers - next
	$('.next',controller).click(function(ev){
		ev.preventDefault();
		//stop the timer
		$(wrapper).stopTime(idPrefix);
		
		slideChange(idPrefix,1,duration);	
	});
	//attach click handlers - prev
	$('.prev',controller).click(function(){
		ev.preventDefault();
		//stop the timer
		$(wrapper).stopTime(idPrefix);
		
		slideChange(idPrefix,-1,duration);	
	});
	
	//attach click handlers - numbers
	$('li.slide-no',controller).each(function(){
		$(this).click(function(ev){
			ev.preventDefault();
			var newSlide=$('a',this).attr('class').replace('s','');
			
			if(newSlide!=$(wrapper).attr('active')){			
				//stop the timer
				$(wrapper).stopTime(idPrefix);
				gotoSlide(idPrefix,newSlide,duration);
			}
		});
	});
	//attach click handlers - play/pause
	$('.pause',controller).click(function(ev){
		ev.preventDefault();
		//pause
		if($(wrapper).attr('paused')=='0'){
			//stop the timer
			$(wrapper).stopTime(idPrefix);
			
			$(wrapper).attr('paused','1');
	
			$(this).addClass('play');
			$(this).text('play');
			
		}
		//play
		else{
			//change to the text slide already

			slideChange(idPrefix,1,duration);

			$(wrapper).attr('paused','0');
			
			$(this).removeClass('play');	
			$(this).text('pause');					
		}
	});
	
	//set the active item
	$('a.s1',controller).addClass('active');
	
	
	//start the timer
	$(wrapper).oneTime(duration,idPrefix,function(){
		slideChange(idPrefix,1,duration);
		});
}


function gotoSlide(idPrefix, newSlide,duration){
	
	wrapper='#'+idPrefix+'inner';
		
	//load variables
	var old=parseInt($(wrapper).attr('active'));	
	var count=parseInt($(wrapper).attr('count'));		
	
	if(newSlide<=0 && newSlide > count) newSlide=1;
	
	transitionCarousel(idPrefix,newSlide,old,duration);
	
	$('a.active',controller).removeClass('active');	
	$('a.s'+newSlide,controller).addClass('active');
	
}

/*function slideChange() 
 *calculates the new slide position and initiates the transition
*/
function slideChange(idPrefix, changeCount,duration){

	wrapper='#'+idPrefix+'inner';
	controller='#'+idPrefix+'controller';
		
	//load variables
	var old=parseInt($(wrapper).attr('active'));	
	var count=parseInt($(wrapper).attr('count'));	
	
	//calculate new slide
	var active= old+changeCount;
	
	if(active>count)
		{active-= (Math.floor(active / count) * count);
	}
	else if(active==0){
		active=count;
	}
	else if(active<1){
		active+= (Math.floor((-active) / count) * count);
	}
	
	transitionCarousel(idPrefix,active,old,duration);
	
	//change the active controller entry
	$('a.active',controller).removeClass('active');	
	$('a.s'+active,controller).addClass('active');
	
}

/*function transitionCarousel()
 *Transitions and animates the carousel
*/
function transitionCarousel(idPrefix,newSlideNo,oldSlideNo,duration){	
	
	wrapper='#'+ idPrefix +'inner';
	
	//check if already animating and queue if so
	if($(wrapper).attr('animating')=='1'){
		
		//set a queue
		$(wrapper).attr('queued',newSlideNo);
	}
	else{	
		//set the animation flag
		$(wrapper).attr('animating','1');
		$('#'+idPrefix+oldSlideNo).hide('fade',{easing: 'easeOutQuad'},1500,function(){
		});
		
		$('#'+idPrefix+newSlideNo).show('fade',{easing: 'easeInQuad'},2200,function(){		
			$(wrapper).attr('active',newSlideNo);
			$(wrapper).attr('animating','0');
			
			//check for a queue
			if($(wrapper).attr('queued')!='0'){
				//process the queue
				var queue=$(wrapper).attr('queued');
				$(wrapper).attr('queued','0');	
				
				//perform the transition
					
				transitionCarousel(idPrefix,queue,$(wrapper).attr('active'),textHandle,imageHandle);
			}
			else{
				//restart the timer
				if($(wrapper).attr('paused')!=1){
					$(wrapper).oneTime(duration,idPrefix,function(){
						slideChange(idPrefix,1,duration);
					});	
				}
			}
			
		});
	
	}	
}







