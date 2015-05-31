$(document).ready(function() {
    $('#show_location_form').click(function (e) {
        e.preventDefault();
        show_location_form();
    });

    function show_location_form() {
        $(".current_location").hide();
        $(".location_form").slideDown(600);
    }
});