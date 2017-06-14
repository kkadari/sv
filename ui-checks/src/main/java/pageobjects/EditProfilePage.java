package pageobjects;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;

public class EditProfilePage extends PageObject {

    @FindBy(how = How.CSS, using = "textarea")
    WebElement txtAreaProfessionalProfile;

    @FindBy(how = How.CSS, using = "input[name='save']")
    WebElement buttonSave;

    public EditProfilePage(WebDriver driver){
        super(driver);
    }

    public void setTxtAreaProfessionalProfile(String text){
        txtAreaProfessionalProfile.sendKeys(text);
    }

    public ProfilePage clickButtonSave(){
        buttonSave.click();

        return new ProfilePage(driver);
    }
}
