$(function() {
    // This slider-range-max is for DIFFICULTY
    $( "#slider-range-max" ).slider({
        range: "max",
        min: 0,
        max: 5,
        step: 0.5,
        value: 0,
        slide: function( event, ui ) {
            var displayText = ui.value;
            if (displayText === 0){
                displayText = "Easy peasy"
            } else if (displayText === 0.5 ){
                displayText = "Lemon squeezy"
            } else if (displayText === 1 ){
                displayText = "Effortless"
            } else if (displayText === 1.5 ){
                displayText = "Uncomplicated"
            } else if (displayText === 2 ){
                displayText = "Not bad"
            } else if (displayText === 2.5 ){
                displayText = "meh.."
            } else if (displayText === 3 ){
                displayText = "Took some effort"
            } else if (displayText === 3.5 ){
                displayText = "Challenging"
            } else if (displayText === 4 ){
                displayText = "Very difficult"
            }else if (displayText === 4.5 ){
                displayText = "Needed coffee to survive"
            }else {
                displayText = "No life, just studying"
            }
            $( "#amount" ).val( displayText);
            $( "#difficulty-rating-value" ).val( ui.value );

            $( "#slider-range-max" ).css("background","#d0e4f7");
            $( "#slider-range-max" ).css("-webkit-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-range-max" ).css("-moz-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-range-max" ).css("box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-range-max" ).css("border","none");
        }
    });

    var majorDifficultyTextPresetValue = $( "#slider-range-max" ).slider( "value" ).toString() === "[object Object]" ? "0" : $( "#slider-range-max" ).slider( "value" );
    $( "#amount" ).val( majorDifficultyTextPresetValue );
    $( "#difficulty-rating-value" ).val( $( "#slider-range-max" ).slider( "value" ) );

    $( "#slider-rating" ).slider({
        range: "max",
        min: 0,
        max: 5,
        step: 0.5,
        value: 0,
        slide: function( event, ui ) {
            $( "#school-rating-value" ).val( ui.value );
            var displayText = ui.value;
            if (displayText === 0){
                displayText = "Worst college ever"
            } else if (displayText === 0.5 ){
                displayText = "Couldn't wait to leave"
            } else if (displayText === 1 ){
                displayText = "Disliked most days"
            } else if (displayText === 1.5 ){
                displayText = "Wasn't a fan"
            } else if (displayText === 2 ){
                displayText = "meh.."
            } else if (displayText === 2.5 ){
                displayText = "Still kind of meh.."
            } else if (displayText === 3 ){
                displayText = "It was alright"
            } else if (displayText === 3.5 ){
                displayText = "I enjoyed most days"
            } else if (displayText === 4 ){
                displayText = "College was good"
            }else if (displayText === 4.5 ){
                displayText = "School was a blast"
            }else {
                displayText = "Best college ever!"
            }
            $( "#rating-amount" ).val( displayText );

            $( "#slider-rating" ).css("background","#d0e4f7");
            $( "#slider-rating" ).css("-webkit-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-rating" ).css("-moz-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-rating" ).css("box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-rating" ).css("border","none");

        }
    });
    var schoolRatingDisplayTextPresetValue = $( "#slider-rating" ).slider( "value" ).toString() === "[object Object]" ? "0" : $( "#slider-rating" ).slider( "value" );
    $( "#rating-amount" ).val( schoolRatingDisplayTextPresetValue );
    $( "#school-rating-value" ).val( $( "#slider-rating" ).slider( "value" ) );



    $( "#slider-party-school" ).slider({
        range: "max",
        min: 0,
        max: 5,
        step: 0.5,
        value: 0,
        slide: function( event, ui ) {
            var displayText = ui.value;
            if (displayText === 0){
                displayText = "Never partied :-("
            } else if (displayText === 0.5 ){
                displayText = "Didn't really have time"
            } else if (displayText === 1 ){
                displayText = "Partied a few times"
            } else if (displayText === 1.5 ){
                displayText = "Maybe once a month"
            } else if (displayText === 2 ){
                displayText = "meh.."
            } else if (displayText === 2.5 ){
                displayText = "Still kind of meh.."
            } else if (displayText === 3 ){
                displayText = "Partied occasionally"
            } else if (displayText === 3.5 ){
                displayText = "Partied often"
            } else if (displayText === 4 ){
                displayText = "Always something to do"
            }else if (displayText === 4.5 ){
                displayText = "Partied most days"
            }else {
                displayText = "Non-stop partying!"
            }
            $( "#amount-party-school" ).val( displayText );
            $( "#party-school-rating-value" ).val( ui.value );

            $( "#slider-party-school" ).css("background","#d0e4f7");
            $( "#slider-party-school" ).css("-webkit-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-party-school" ).css("-moz-box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-party-school" ).css("box-shadow","inset -2px 2px 4px 0px rgba(0,0,0,0.75)");
            $( "#slider-party-school" ).css("border","none");
        }
    });
    var displayTextPresetValue = $( "#slider-party-school" ).slider( "value").toString() === "[object Object]" ? "0" : $( "#slider-party-school" ).slider( "value" );
    $( "#amount-party-school" ).val( displayTextPresetValue );
    $( "#party-school-rating-value" ).val( $( "#slider-party-school" ).slider( "value" ) );

    $(window).load(function(){
        $('#myModal').modal('show');
    });
});