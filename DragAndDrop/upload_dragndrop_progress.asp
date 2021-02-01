<%@CodePage="65001" Language="VBScript"%>
<!--#include file="./config/common/var.asp"-->
<!--#include file="./config/common/const.asp"-->
<!--#include file="./config/common/proc.asp"-->
<!--#include file="./config/common/dbconf.asp"-->

<!--
made by gigatera
드래그 앱 드롭 방식 업로드 (프로그레스바 처리)
익스10이상
-->

<%
Session.CodePage = "65001"    
Response.CharSet="utf-8"
Response.codepage="65001"
Response.ContentType="text/html;charset=utf-8"

'error message for euc-kr
'Response.CharSet="euc-kr"  
'Response.codepage="949"    
'Response.ContentType="text/html;charset=euc-kr"
%>

<%   
Response.Expires = 0   
Response.AddHeader "Pragma","no-cache"   
Response.AddHeader "Cache-Control","no-cache,must-revalidate"   
%> 

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>drag and drop upload</title>
  <script language="javascript" type="text/javascript" src="./config/js/jquery-3.1.0.js"></script>
  <script language="javascript" type="text/javascript" src="./config/js/extend.js"></script>
  <script language="javascript" type="text/javascript">
	$(document).ready(function(){
		
		var uploadFiles = [];

		$("#drop").addClass('drag_orig');	
		$("#drop").on("dragenter", function(e) { 
			$(this).addClass('drag_over');
		}).on("dragleave", function(e) { 
			$(this).removeClass('drag_over');
		}).on("dragover", function(e) {
			e.stopPropagation();
			e.preventDefault();
		}).on('drop', function(e) {
			e.preventDefault();
			$(this).removeClass('drag_over');

			var files = e.originalEvent.dataTransfer.files;
			for(var i = 0; i < files.length; i++) {
				var file = files[i];
				var size = uploadFiles.push(file);
				//console.log(file.name);
				//preview(file, size - 1);
				$("#thumbnails").append('<li>' + file.name + '</li>');
			}

			groupUpload();
		});


		function groupUpload() {
			var formData = new FormData();
			$.each(uploadFiles, function(i, file) {
				if(file.upload != 'disable')
					formData.append('files', file, file.name);
			});

			$.ajax({
				url: 'upload_dragndrop_ok.asp',
				data : formData,
				type : 'post',
				contentType : false,
				processData: false,
				xhr: function() { 
					var xhr = $.ajaxSettings.xhr();
					xhr.upload.onprogress = function(e) { //progress 이벤트 리스너 추가
						var percent = e.loaded * 100 / e.total;
						setProgress(percent);
					}
					return xhr;
				}
			}).fail(function(request,status,error) {  //error
				setProgress(0);
				$(this).removeClass('drag_over');
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}).done(function(msg) {
				//console.log(msg);
				if (msg==0) {
					alert("파일 업로드가 완료되었습니다");
				}
			});
		}

		function setProgress(percent) {
			$("#progressBar").val(percent);
		}

		function preview(file, idx) {

			var reader = new FileReader();
			reader.onload = (function(f, idx) {

				return function(e) {
					var $div = "";
					if ((/\.(jpe?g|png|gif)$/).test(f.name)) {
						$div = $('<div class="thumb"><div class="close" data-idx="' + idx + '">X</div><img src="' + e.target.result + '" title="' + escape(f.name) + '"/>'+unescape(f.name)+'</div>');
					} else {
						$div = $('<div class="thumb"><div class="close" data-idx="' + idx + '">X</div><img src="images/common/thumb_blank.png" title="' + escape(f.name) + '"/>'+unescape(f.name)+'</div>');
					}

					$("#thumbnails").append($div);
					//f.target = $div;

					//<progress value="0" max="100" ></progress> \
				};

			})(file, idx);

			reader.readAsDataURL(file);
		}



	});
  </script>

  <style type="text/css">
  #uploadBox {
	width:600px; 
  }
  #drop {
	
	height:300px; 
	line-height:300px;
	text-align:center;
  }
  .drag_orig {
	border:1px solid black; 
  }
  .drag_over {
	border:2px dotted red; 
	color:blue;
	font-weight:bold;
  }
  #progressBar {
	width:100%;
  }
	.thumb { width:100px; height:100px; padding:5px; float:left; }
	.thumb > img { width:100%; }
	/*.thumb > progress { width:100%; }*/
	.thumb > .close { position:absolute; background-color:red; cursor:pointer; }
  </style>
 </head>
 <body>

	
	<div id="uploadBox">
		<div id="drop">
			Drag&Drop for uploading
		</div>
		<div>
			<progress id="progressBar" value="0" max="100"></progress>
		</div>

		<div id="thumbnails">
			
		</div>
	</div>
		




 </body>
</html>