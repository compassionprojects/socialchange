
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
