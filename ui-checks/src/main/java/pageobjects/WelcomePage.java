package pageobjects;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class WelcomePage extends PageObject {

    @FindBy(how = How.CSS, using = ".content-small .widget-container")
    WebElement divWidgetContainer;

    @FindBy(how = How.CSS, using = "#whats-happening")
    WebElement divWhatsHappening;

    @FindBy(how = How.CSS, using = "#feed-popular")
    WebElement listFeedPopular;

    @FindBy(how = How.CSS, using = "#feed-following")
    WebElement listFeedFollowing;

    @FindBy(how = How.CSS, using = ".event-content")
    WebElement divContent;

    @FindBy(how = How.CSS, using = ".footer-main")
    WebElement divFooter;

    @FindBy(how = How.CSS, using = "#customBrowseMenuAnchor")
    WebElement linkContentMenu;

    @FindBy(how = How.CSS, using = "#customBrowseMenu")
    WebElement divBrowseMenu;

    @FindBy(how = How.CSS, using = "#customBrowseMenu .j-pop-desc")
    WebElement divContentMenuItem;

    @FindBy(how = How.CSS, using = "#customMembersMenuAnchor")
    WebElement linkMembersMenu;

    @FindBy(how = How.CSS, using = "#customMembersMenu")
    WebElement divMembersMenu;

    @FindBy(how = How.CSS, using = "#navCommunitiesAndNodes")
    WebElement linkCommunityMenu;

    @FindBy(how = How.CSS, using = "#menuCommunitiesAndNodes")
    WebElement divCommunityMenu;

    @FindBy(how = How.CSS, using = "#menuCommunitiesAndNodes .j-pop-desc")
    WebElement divCommunityMenuItem;

    private WebDriverWait wait = new WebDriverWait(driver, timeout);

    public WelcomePage(WebDriver driver){
        super(driver);
    }

    public String returnWidgetContainerHtml(){
        return divWidgetContainer.getAttribute("outerHTML");
    }

    public String returnWhatsHappeningHtml(){
        wait.until(ExpectedConditions.visibilityOf(divContent));

        return divWhatsHappening.getAttribute("outerHTML");
    }

    public void clickFeedPopular() {
        wait.until(ExpectedConditions.visibilityOf(listFeedPopular));

        listFeedPopular.click();
    }

    public void clickFeedFollowing() {
        wait.until(ExpectedConditions.visibilityOf(listFeedFollowing));

        listFeedFollowing.click();
    }

    public String returnFooterHtml() {
        return divFooter.getAttribute("outerHTML");
    }

    public void clickContent() {
        linkContentMenu.click();
    }

    public String returnContentMenuPopupHtml(){
        wait.until(ExpectedConditions.visibilityOf(divContentMenuItem));

        return divBrowseMenu.getAttribute("outerHTML");
    }

    public void clickMembers() {
        linkMembersMenu.click();
    }

    public String returnMembersMenuPopupHtml() {
        return divMembersMenu.getAttribute("outerHTML");
    }

    public void clickCommunityAndNodes() {
        linkCommunityMenu.click();
    }

    public String returnCommunityAndNodesPopupHtml() {
        wait.until(ExpectedConditions.visibilityOf(divCommunityMenuItem));

        return divCommunityMenu.getAttribute("outerHTML");
    }

}
