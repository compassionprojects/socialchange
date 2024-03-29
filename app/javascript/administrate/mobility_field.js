// Field customisations for administrate mobility (translation) fields

import "trix";

$(document).ready(function() {
  // Styling
  // Make the field label appear on the same line as field value
  $('.mobility-tabs').parent('dd.attribute-data').prev().css("margin-top", "42px");

  $('.mobility-tab-item-link').click(function (e) {
    e.preventDefault();

    const locale = $(this).data('locale');

    // make the currently active locale inactive
    $('.mobility-tab-item.active').removeClass('active');
    $('.mobility-field-item.active').removeClass('active');

    // and then make the currently selected locale active
    $('.mobility-tab-item-' + locale).addClass('active');
    $('.mobility-field-item-' + locale).addClass('active');
  });
});
