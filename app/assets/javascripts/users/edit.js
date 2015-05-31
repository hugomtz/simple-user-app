
$(document).ready(function() {
    var validateFile = function(file, validTypes) {
        var checkType = new RegExp(".+\." + validTypes + "$", "i");

        var max_file_size = 1000000000 // ~1 GB

        if (!(checkType.test(file.type) || checkType.test(file.name))) {
            return 'File type not allowed';
        }
        if (file.size > max_file_size) {
            return 'File is too big';
        }

    }
    $('#file').change(function(e){
        e.preventDefault();
        var file = $("#file")[0].files[0];
        var name = file.name;
        var size = file.size;
        var type = file.type;
        if(!validateFile(file, "(png|jpg|jpeg)")) {
            var formData = new FormData($(".upload_photo_form")[0]);
            $.ajax({
                url: gon.url,
                type: 'POST',
                data: formData,
                success: completeHandler = function(data) {
                    $.ajax({
                        url: "/"+gon.user.slug+".json",
                        type: 'PUT',
                        data: { authenticity_token: $(".upload_photo_form")[0].authenticity_token.value,
                            "user[avatar_image_id]": data.public_id},
                        success: completeHandler = function(data) {
                            $('#user_photo').attr("src",data.url);
                            $('#avatar_thumb').attr("src",data.url);
                        }
                    });

                },
                error: errorHandler = function() {
                    alert("Invalid File");
                },
                cache: false,
                contentType: false,
                processData: false
            });
        }
        else{
            alert("Invalid File");
        }
    });
    $('.upload_photo_form').submit (function (e) {
        e.preventDefault();
        $('#file').click();
    });
});

$(document).ajaxStart(function() {
    $('.ajax-loader').show();
}).ajaxComplete(function() {
    $('.ajax-loader').hide();
});