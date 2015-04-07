$(function() {
  $(".nav_scrollspy").addClass("nav");
  $(".nav_scrollspy ul").addClass("nav");
  $(window).on('load', function() {
    setTimeout(function() {
      $('body').scrollspy({ target: '.offcanvas_nav', offset: getInitialScrollTopAdjustment() + 1 }); 
      $(window).scroll();
    }, 1000);
  });

  function getInitialScrollTopAdjustment() {
    var scrollTop = 0;
    if ($('.sticky_header_container').css('position') === 'fixed') {
        //documentation header height is 46 + 44 + 10
        scrollTop = 100;
    } else {
        //account for the global nav since it is still visible.
        if ($("#header_desktop").height() !== 0) {
            scrollTop = 110 + 20 + ($("#header_desktop").height());
        } else {     
            scrollTop = 100;
        }
    }
    return scrollTop;
  }
});
  

