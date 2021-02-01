/*
extending function
gigatera
*/

(function($){

	$.fn.getRightPwd = function($pwd2){
		var pwdExpression = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		if (typeof $pwd2 === 'object') {
			return pwdExpression.test(this.val())&&(this.val()==$pwd2.val());
		} else {
			return pwdExpression.test(this.val());
		}
	}

	$.fn.isImage = function(){
		var expression = /\.(jpe?g|png|gif)$/;
		return expression.test(this.val().toLowerCase());
	}

	$.fn.ltrim = function(){
		return this.val().replace(/^\s+/,"");
	}

	$.fn.rtrim = function(){
		return this.val().replace(/\s+$/,"");
	}


})(jQuery);


/*
var regExpId = /^[0-9a-z]+$/; //숫자, 영문만 입력 가능
var regExpPw = /(?=.*\d{1,50})(?=.*[~`!@#$%\^&*()-+=]{1,50})(?=.*[a-zA-Z]{2,50}).{8,50}$/;  //숫자, 특문 각 1회 이상, 영문은 2개 이상 사용하여 8자리 이상 입력
var regExpEm = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i; //이메일주소 형식 체크 정규식
*/