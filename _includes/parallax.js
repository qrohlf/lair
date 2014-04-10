// parallax header
jQuery(document).ready(function($) {
    $(window).scroll( function()
    {
        var scroll = $(window).scrollTop(), slowScroll = scroll/3;
        var headerheight = $('header').height();
        $('header').css({ transform: "translateY(" + slowScroll + "px)" });
        $('header .container').css({ opacity: Math.min(1, 1.2 - scroll/headerheight) });
    });
});