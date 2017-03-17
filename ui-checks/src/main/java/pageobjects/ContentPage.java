package pageobjects;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.List;

public class ContentPage extends PageObject {

    @FindBy(how = How.CSS, using = ".j-td-title")
    List<WebElement> tableCellTitle;

    public ContentPage(WebDriver driver){
        super(driver);
    }

    public String returnTableRowContentHtml(){
        WebDriverWait wait = new WebDriverWait(driver, 10);
        wait.until(ExpectedConditions.visibilityOf(tableCellTitle.get(0)));

        String tableRowToReturn = "";

        for(WebElement row : tableCellTitle){
            tableRowToReturn += row.getAttribute("outerHTML");
        }

        return tableRowToReturn;
    }

}
