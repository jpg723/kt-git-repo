(function(){
    var msgs = {
        login: 'Login Your Account.',
        fail: 'There is no account or wrong password.',
    };
    var Event = {
        login: function() {
            $('#login-btn').on('click', function() {
                var params = {
                    id: $("#email").val(),
                    pw: $("#pw").val(),
                };
                if( params.id === 'admin@kt.com' && params.pw === '1234'){
                    $('.msg').text(msgs.login).show();
                } else {
                    $('.msg').text(msgs.fail).show();
                }        
            });
        }
    };
    Event.login();
})();