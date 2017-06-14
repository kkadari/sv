package pageobjects;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;

import java.util.List;

public class ActivityPage extends PageObject {

    @FindBy(how = How.CSS, using = ".j-act-title")
    List<WebElement> divTitles;

    public ActivityPage(WebDriver driver){
        super(driver);
    }

    public String returnStreamListHtml(){
        String streams = "";

        for(WebElement title : divTitles){
            streams += title.getAttribute("outerHTML");
        }

        return streams;
    }

}
