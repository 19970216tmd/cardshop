$(document).on('turbolinks:load', function() {
  var form = $("#charge-form"); //id”charge-form”のものをformに代入します。
  Payjp.setPublicKey('pk_test_c5359dae96a3961ed258e1d2'); //公開鍵を直書き、して参照できる様にします。
  $(document).on("click", "#token_submit", function(e) { //eが押されたときに作動します。
    e.preventDefault(); //まずrailsの処理を止めて、jsの処理を先に行います。
    form.find("input[type=submit]").prop("disabled", true);
    var card = { //card変数に、入力されたクレジットカード情報をidを元に取得して、card変数に代入します。。
        number: $("#card_number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val()
    };
    Payjp.createToken(card, function(s, response) {  // トークンを生成。先ほどのcard情報がトークンという暗号化したものとして返ってくる
      if (response.error) { //値がエラーであった場合
        alert('カード情報が正しくありません');
      }
      else { //エラーが出なかった場合
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name"); //DBに保存しないため値を削除。
        var token = response.id;
        alert("登録が完了しました"); 
        form.append($('<input type="hidden" name="payjpToken"/>').val(token)); //dbにトークンを保存するのでformにjsで作ったトークンを挿入している。
        form.get(0).submit(); //formの先ほど挿入したデータをgetsしています。
      }
    });
  });
});