// So the file recognizes jQuery and Stripe
/* global $, Stripe */

//Document ready using turbolinks, supposedly faster?
$(document).on('turbolinks:load', function()
{
    var theForm = $('#pro-form');
    var signUpBtn = $('form-signup-btn');
    
    //Get public key from application html file meta tag
    //This way Stripe knows what account the request is from
    Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );
    
    signUpBtn.click(function(event)
    {
        //Prevent default submission behavior
        event.preventDefault();
        
        //Disable the sign up button TODO: Gray it out
        signUpBtn.val('0Processing').prop('disabled', true);
        
        //Collect the credit card info
        var creditCardNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expirationMonth = $('#card_month').val(),
            expirationYear = $('#card_year').val();
            
        //Validate card info using Stripe.js lib
        var error = false;
        
        if (!Stripe.card.validateCardNumber(creditCardNum))
        {
            error = true;
            alert("Invalid ccNum");
        }
        
        if (!Stripe.card.validateCVC(cvcNum))
        {
            error = true;
            alert("Invalid CVC");
        }
        
        if (!Stripe.card.validateExpiry(expirationMonth, expirationYear))
        {
            error = true;
            alert("Invalid exp date");
        }
            
        if (error)
        {
            signUpBtn.prop('disabled', false).val('Sign Up'); //Re-enable the button
        } else
        {
            //Info to Stripe
            Stripe.createToken(
            {
                number: creditCardNum,
                cvc: cvcNum,
                exp_month: expirationMonth,
                exp_year: expirationYear
            }, stripeResponseHandler);
        }
        return false;
    });
    
    function stripeResponseHandler(status, response)
    {
        var token = response.id; //The token from the response
        
        //Inject the card token into a new hidden field
        theForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
        
        //Submit the form to the Rails app, with the Stripe token.
        //Card info will not be submitted, because the fields have name: nil 
        //attribute in _pro_form.html.erb (maybe?)
        theForm.get(0).submit();
    }
});