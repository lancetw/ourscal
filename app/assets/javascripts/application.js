// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.cookie
//= require jquery_ujs
//= require turbolinks
//= require modernizr
//= require_tree .
//= require bootstrap



$(document).ready(function() {
    $('table.ourscal td').delay(100).animate({"opacity": "1"}, 500);

    $(document).on('page:fetch', function() {
        $('table.ourscal td').delay(100).animate({"opacity": "0"}, 500);
    });

    $(document).on('page:change', function() {

        if ($.cookie('s_direct') == 'next') {
            $('table.ourscal td').each(function() {
                if ( $(this).text() == $.cookie('s_day')) {
                    $(this).find('div').css('background-color', '#666');
                    return false;
                }
            });
        } else {
            $($('table.ourscal td').get().reverse()).each(function() {
                if ( $(this).text() == $.cookie('s_day')) {
                    $(this).find('div').css('background-color', '#666');
                    return false;
                }
            });
        }

        $('table.ourscal td').delay(100).animate({"opacity": "1"}, 500);

    })

     $(document).on('click', '.day', function(event) {
        var day = $(this).text();
        $.cookie('s_day', day);
        $('table.ourscal td').not('.not-current-month').not('.today').each(function() {
            $(this).find('div').css('background-color', '#eee');
        });
        $('table.ourscal td.today').find('div').css('background-color', '#fff');

        $(this).find('div').css('background-color', '#666');

        return false;
    });

    $(document).on('click', '.day:not(.not-current-month)', function(event) {
        $('.sidebar h2 span').text($.cookie('s_day'));

        $('.sidebar').show();
        $('.aside1').hide();

        if ( Modernizr.mq('screen and (max-width:979px)') ) {
            $('html, body').animate({ scrollTop: $(document).height() }, 'slow');
        }

        if ( Modernizr.mq('screen and (max-width:767px)') ) {
            $('.aside2').hide();
            $('.aside3').hide();
        }

        return false;
    });

    $(document).on('click', '.day.not-current-month', function(event) {
        var day = $(this).text();
        $.cookie('s_day', day);
        if (day >= 15) {
            $.cookie('s_direct', 'previous');
            var link = $('.previous-month').attr('href');
            Turbolinks.visit(link);

        } else {
            $.cookie('s_direct', 'next');
            var link = $('.next-month').attr('href');
            Turbolinks.visit(link);
        }

        return false;
    });

    $(document).on('click', '.sidebar .close-action', function(event) {
        $('.aside1').show();
        $('.sidebar').hide();

        if ( Modernizr.mq('screen and (max-width:979px)') ) {
            $('html, body').animate({ scrollTop: 0 }, 'slow');
        }

        if ( Modernizr.mq('screen and (max-width:767px)') ) {
            $('.aside2').show();
            $('.aside3').show();
        }

        return false;
    });

});

