package api.api;

import api.payload.DiscussionPayload;
import io.restassured.http.ContentType;
import io.restassured.http.Cookies;

import static io.restassured.RestAssured.given;

public class CreateContentApi {

    public static void createDiscussion(Cookies cookies, String baseUrl, DiscussionPayload discussionPayload){
        given()
            .contentType(ContentType.JSON)
            .cookies(cookies)
            .body(discussionPayload)
        .when()
            .post(baseUrl + "/__services/v2/rest/discussion");
    }
}
