$body = $("body");

function dismissAlert(){
    $(".alert").animate({opacity:'0'}, 1500);
    $(".alert").remove();
}

$(document).ready(function() {
    $('.close-x').on('click', function() {
        var message = $(this).attr('data-dismiss');
        if(message == "alert") {
            $(this).closest(".alert").animate({opacity:'0'}, 1500);
            $(this).closest(".alert").remove();
        }
    })
});