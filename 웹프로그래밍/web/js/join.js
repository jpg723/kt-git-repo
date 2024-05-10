(function(){
    var msgs = {
        join: 'Joined your account.',
        check: 'Check your password same.',
    }
    
    var Event = {
        join: function(){
            $('#join-btn').on('click', function(){
                var params = {
                    email: $('#email').val(),
                    pw: $('#pw').val(),
                    ckpw: $('#ckpw').val(),
                    addr: $('input[name="addr"]:checked').val(),
                    birth: $('#birth').val(),
                    subscription: $('#subscription').val(),
                }
                console.log(params);

                if(params.pw === params.ckpw){
                    $('.msg').text(msgs.join).show();
                }else{
                    $('.msg').text(msgs.check).show();
                }
            })
        }
    }
    Event.join();
})();