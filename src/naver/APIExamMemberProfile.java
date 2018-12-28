package naver;

// 네이버 API 예제 - 회원프로필 조회
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class APIExamMemberProfile {

	public String temp;

	public APIExamMemberProfile(String inputToken) {

		String token = inputToken;// 네이버 로그인 접근 토큰;

		String[] a = token.split(",");
		String[] b = a[0].split(":");

		String header = "Bearer " + b[1]; // Bearer 다음에 공백 추가
		try {
			String apiURL = "https://openapi.naver.com/v1/nid/me";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			JsonParser jp = new JsonParser();

			JsonObject jo = (JsonObject) jp.parse(response.toString());

			JsonObject jo2 = (JsonObject) jo.get("response");

			System.out.println(jo2.get("id"));

			System.out.println(response.toString());
		} catch (Exception e) {
			System.out.println(e);

		}
	}

}
