<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<title>viewlocal</title>
		<meta id="viewport" name="viewport" content="initial-scale=1" />
		<script type="text/javascript">
		
		function resize(){
			document.getElementById('load').style.display='none';
			var frame=document.getElementById('frame');
			frame.style.display='';
			var width=frame.contentDocument.body.scrollWidth;
			if(width>320){
				frame.width=width;
				document.getElementById('viewport').content="initial-scale="+(320/width);
				var wh=width/320;
				document.getElementById('img1').width=56*wh;
				document.getElementById('img1').height=33*wh;
				document.getElementById('img2').width=56*wh;
				document.getElementById('img2').height=33*wh;
			}
			document.getElementById('body1').style.width=width;
		}
		</script>
	</head>
	<body bgcolor="#FFFFFF" id="body1" style="margin: 0px; padding: 0px">
		<table width="100%" style="margin: 0px; padding: 0px" cellpadding="0"
			cellspacing="0">
			<tr style="display:<%="true".equalsIgnoreCase(request.getParameter("showclose"))?"block":"none"%>">
				<td valign="middle" background="menu_bg.jpg" height="44"
					width="100%">
					&nbsp;&nbsp;&nbsp;
					<img id="img1" src="back.gif" style="border: 0px"
							onclick="window.location='dhmkey3g://123';window.close()"  >
				</td>
			</tr>
			<tr>
				<td>
					<div id="load">
						<span
							style="font-size: 50px; width: 100%; text-align: left; color: #333;">正在载入...</span>
					</div>
					<iframe id="frame" frameborder="0" scrolling="yes" width="320px"
						height="1%" style="display: none; margin: 0px; padding: 0px;"
						onload="javascript:resize()"
						src="../tmp/<%=request.getParameter("uid")%>/<%=request.getParameter("filename")%>"></iframe>
				</td>
			</tr>
			<tr style="display:<%="true".equalsIgnoreCase(request.getParameter("showclose"))?"block":"none"%>">
				<td valign="middle" background="menu_bg.jpg" height="44">
					&nbsp;&nbsp;&nbsp;
					<a><img id="img2" src="back.gif" style="border: 0px"
							onclick="window.location='dhmkey3g://123';window.close()"  > </a>
				</td>
			</tr>
		</table>

	</body>
</html>