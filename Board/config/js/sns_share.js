addJs('https://developers.kakao.com/sdk/js/kakao.js');

/*
og 태그의 이미지가 썸네일로 사용됨
*/

function addJs(js) {
	var hd = document.getElementsByTagName('head')[0];
	var s = document.createElement('script');
	s.setAttribute('type','text/javascript');
	s.setAttribute('src',js);
	hd.appendChild(s);
}

function facebook() {
	var u = encodeURIComponent($(location).attr('href'));
	var t = encodeURIComponent(document.title);
	var url = "http://www.facebook.com/sharer.php?u="+u+"&t="+t;
	var wo = window.open(url,'ofacebook','width=400,height=400,top=100,left=200');
	wo.focus();
}

function twitter() {
	var url = encodeURIComponent($(location).attr('href'));
	var text = encodeURIComponent(document.title);
	var url = "http://www.twitter.com/share?url="+url+"&text="+text;
	var wo = window.open(url,'otwitter','width=400,height=400,top=100,left=200');
	wo.focus();
}

function googlePlus() {
	var url = encodeURIComponent($(location).attr('href'));
	var url = "https://plus.google.com/u/0/share?url="+url;
	var wo = window.open(url,'ogooglePlue','width=400,height=400,top=100,left=200');
	wo.focus();
}

function kakaoStory() {
	var url = encodeURIComponent($(location).attr('href'));
	var url = "https://story.kakao.com/share?url="+url;
	var wo = window.open(url,'okakaoStory','width=500,height=500,top=100,left=200');
	wo.focus();
}

function kakaoTalk() {
	Kakao.init('c089c8172def97eb00c07217cae17495'); //각 업체에 맞게 코드 변경 및 개발자센터에서 홈페이지 주소등 설정 변경
	Kakao.Link.sendScrap({
		requestUrl: location.href
	});
};

function naverLine() {
	var title = encodeURIComponent(document.title);
	var summary = encodeURIComponent($("#contents").text());
	var sns_br = "\n";
	var link = encodeURIComponent($(location).attr('href'));
	//var img = ""; ????
	var url = "http://line.me/R/msg/text/?"+title+sns_br+summary+sns_br+link;
	var wo = window.open(url,'onaverLine','width=500,height=500,top=100,left=200');
	wo.focus();
}

function naverBlog() {
	var title = encodeURIComponent(document.title);
	var url = encodeURIComponent($(location).attr('href'));
	var url = "http://blog.naver.com/openapi/share?title="+title+"&url="+url;
	var wo = window.open(url,'onaverBlog','width=500,height=500,top=100,left=200');
	wo.focus();
}

function naverBand() {
	var title = encodeURIComponent(document.title);
	var url = encodeURIComponent($(location).attr('href'));
	var url = "http://band.us/plugin/share?body=" + title + "  " + url + "&route=" + url;
	var wo = window.open(url,'onaverBand','width=500,height=500,top=100,left=200');
	wo.focus();
}

function naverPholar() {
	var title = encodeURIComponent(document.title);
	var url = encodeURIComponent($(location).attr('href'));
	var url = "http://www.pholar.co/spi/rephol?url=" + url + "&title=" + title;
	var wo = window.open(url,'opholar','width=500,height=500,top=100,left=200');
	wo.focus();
}


function pinterest() {
	var description = encodeURIComponent(document.title);
	var media = "http://gigatera.co.kr/myimg/love/myhoyalove.jpg"; //각 업체에 맞게
	var url = encodeURIComponent($(location).attr('href'));
	var url = "http://www.pinterest.com/pin/create/button/?url=" + url + "&media=" + media + "&description=" + description;
	var wo = window.open(url,'opinterest','width=500,height=500,top=100,left=200');
	wo.focus();
}