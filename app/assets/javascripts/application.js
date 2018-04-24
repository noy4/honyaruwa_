// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
  $(".select-image, #post-image-preview, #post-image").click(function(){
    $("#post_image").click();
  });

  $('#post_image').change(function(e){
    //ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();

    //画像でない場合は処理終了
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }

    //アップロードした画像を設定する
    reader.onload = (function(file){
      return function(e){
        $(".select-image").hide();
        $("#post-image").hide();
        $("#post-image-preview").attr("src", e.target.result).show();
        $("#post-image-preview").attr("title", file.name);
      };
    })(file);
    reader.readAsDataURL(file);

  });

// ユーザー画像
  $("#user-image-preview").click(function(){
    $("#user_image").click();
  });

  $('#user_image').change(function(e){
    //ファイルオブジェクトを取得する
    var file = e.target.files[0];
    var reader = new FileReader();

    //画像でない場合は処理終了
    if(file.type.indexOf("image") < 0){
      alert("画像ファイルを指定してください。");
      return false;
    }

    //アップロードした画像を設定する
    reader.onload = (function(file){
      return function(e){
        $("#user-image-preview").attr("src", e.target.result);
      };
    })(file);
    reader.readAsDataURL(file);

  });

  // $('#post_form').submit(function(){
  //   if ($('#post_image').val() == ''){
  //     $('#img_error').text('写真を追加してください');
  //   }else{
  //     $('#img_error').text('');
  //   }
  //
  //   if ($('#text_title').val() == ''){
  //     $('#title_error').text('書名を入力してください');
  //   }else{
  //     $('#title_error').text('書名を入力してください');
  //   }

    // if($('#text_title').val() == ''){
    //   $('').text('');
    // }else{
    //   $('').text('');
    // }
    //
    // if($('#text_title').val() == ''){
    //   $('').text('');
    // }else{
    //   $('').text('');
    // }
  // });

});
