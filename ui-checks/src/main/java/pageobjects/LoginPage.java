package pageobjects;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;

public class LoginPage extends PageObject {

    @FindBy(how = How.CSS, using = "#username01")
    WebElement txtUsername;

    @FindBy(how = How.CSS, using = "#password01")
    WebElement txtPassword;

    @FindBy(how = How.CSS, using = "#login-submit")
    WebElement inptSubmit;

    public LoginPage(WebDriver driver){
        super(driver);
    }

    public void setUsername(String username){
        txtUsername.sendKeys(username);
    }

    public void setPassword(String password){
        txtPassword.sendKeys(password);
    }

    public void clickSubmit(){
        inptSubmit.click();
    }

}
