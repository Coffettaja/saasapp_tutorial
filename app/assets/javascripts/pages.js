// So the file recognizes jQuery and Stripe
/* global $, Stripe */

//Document ready using turbolinks, supposedly faster?
$(document).on('turbolinks:load', function() {
   $('.alert').delay(1000).fadeOut(4000); 
});