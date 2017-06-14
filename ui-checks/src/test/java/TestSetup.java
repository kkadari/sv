import api.api.LoginApi;
import driverfactory.DriverFactory;
import io.restassured.http.Cookies;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import pageobjects.LoginPage;

public class TestSetup {

    protected static WebDriver driver;
    protected static String baseUrl;
    protected static Cookies cookies;

    @BeforeClass
    public static void setup(){
        driver = new DriverFactory().create();
        driver.manage().window().setSize(new Dimension(1280,720));
        baseUrl = "http://localhost:8080";

        driver.navigate().to(baseUrl + "/login.jspa");
        LoginPage login = new LoginPage(driver);
        login.setPassword("admin");
        login.setUsername("admin");
        login.clickSubmit();

        cookies = LoginApi
                    .login(baseUrl, "admin", "admin")
                    .getDetailedCookies();
    }

    @AfterClass
    public static void TearDown(){
        driver.quit();
    }

}
