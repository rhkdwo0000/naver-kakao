<%@page import="org.apache.tomcat.util.http.parser.Authorization"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="naver.APIExamMemberProfile"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>네이버로그인</title>
</head>
<body>


<%! String temp; %>



	<%
		String clientId = "e3FTvfu7uRnuSq28hSPF";//애플리케이션 클라이언트 아이디값";
		String clientSecret = "3nCsNI_Rxq";//애플리케이션 클라이언트 시크릿값";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://localhost:7777/naver/main.jsp", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;
		String access_token = "";
		String refresh_token = "";
		System.out.println("apiURL=" + apiURL);
		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.println("responseCode=" + responseCode);
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			String res = "";
			while ((inputLine = br.readLine()) != null) {
				res +=inputLine;
			}
			
			System.out.println("매개변수 주기 전 토근 "+res);
			APIExamMemberProfile b = new APIExamMemberProfile(res);
			br.close();
			if (responseCode == 200) {
				session.setAttribute("id", state);
				out.println(res.toString());
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		
	%>




</body>
</html>