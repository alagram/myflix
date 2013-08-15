jQuery(function($) {
  $('#new_user').submit(function(event) {
    var $form = $(this);
    $form.find('.payment_submit').prop('disabled', true);
    Stripe.createToken({
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-year').val()
    }, stripeResponseHandler);
    return false;
  });

  var stripeResponseHandler = function(status, response) {
    var $form = $('#new_user');

    if(response.error) {
      $form.find('.payment-errors').text(response.error.message);
      $form.find('.payment_submit').prop('disabled', false);
    } else {
      var token = response.id;
      $form.append($('<input type="hidden" name="stripeToken" />').val(token));
      $form.get(0).submit();
    }
  };
});