package pageobjects;

import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;

public class SearchPage extends PageObject {

    @FindBy(how = How.CSS, using = ".j-content-results")
    WebElement divMainResults;

    @FindBy(how = How.CSS, using = ".j-search-result-summary")
    WebElement divResultContent;

    public SearchPage(WebDriver driver){
        super(driver);
    }

    public String returnSearchResults(){
        return divMainResults.getAttribute("outerHTML");
    }

    public boolean returnResultIsDisplayed(){
        try {
            return divResultContent.isDisplayed();
        } catch (NoSuchElementException e){
            return false;
        }
    }

}
