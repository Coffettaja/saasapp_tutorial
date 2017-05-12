// So the file recognizes jQuery and Stripe
/* global $, Stripe */

//Document ready using turbolinks, supposedly faster?
$(document).on('turbolinks:load', function()
{
    var theForm = $('#pro-form');
    var signUpBtn = $('form-signup-btn');
    
    //Get public key from application html file meta tag
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    signUpBtn.click(function(event)
    {
        //Prevent default submission behavior
        event.preventDefault();
        
        //Collect the credit card info
        var creditCardNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expirationMonth = $('#card_month').val(),
            expirationYear = $('#card_year').val();
            
        //Info to Stripe
        Stripe.createToken({
            number: creditCardNum,
            cvc: cvcNum,
            exp_month: expirationMonth,
            exp_year: expirationYear
        }, stripeResponseHandler)
    });
});