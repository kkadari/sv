package api.api;

import io.restassured.response.Response;

import static io.restassured.RestAssured.given;

public class LoginApi {

    public static Response login(String baseUrl, String username, String password){
        return given()
                .params("username", username, "password", password)
               .when()
                .post(baseUrl + "/cs_login");
    }
}
