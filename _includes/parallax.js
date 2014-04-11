// detect mobile browsers
function mobileBrowser() {
    return (/Android|iPhone|iPad|iPod|BlackBerry/i).test(navigator.userAgent || navigator.vendor || window.opera);
}

// parallax header
if (!mobileBrowser()) { // parallax scrolling is janky on mobile, so we don't do it.
    jQuery(document).ready(function($) {
        $(window).scroll( function()
        {
            var scroll = $(window).scrollTop(), slowScroll = scroll/3;
            var headerheight = $('header').height();
            $('header').css({ transform: "translateY(" + slowScroll + "px)" });
            $('header .container').css({ opacity: Math.min(1, 1.2 - scroll/headerheight) });
        });
    });
}
