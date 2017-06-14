import org.approvaltests.Approvals;
import org.junit.Test;
import pageobjects.WelcomePage;

public class MenuLayoutTest extends TestSetup{

    @Test
    public void approveCustomFooter(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        String footerHtml = welcome.returnFooterHtml();

        Approvals.verifyHtml(footerHtml);
    }

    @Test
    public void approveContentMenu(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        welcome.clickContent();
        String menuHtml = welcome.returnContentMenuPopupHtml();

        Approvals.verifyHtml(menuHtml);
    }

    @Test
    public void approveMembersMenu(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        welcome.clickMembers();
        String menuHtml = welcome.returnMembersMenuPopupHtml();

        Approvals.verifyHtml(menuHtml);
    }

    @Test
    public void approvePlacesMenu(){
        driver.navigate().to(baseUrl + "/community/support/user-feedback");
        driver.navigate().to(baseUrl + "/community/support/user-guidance");
        driver.navigate().to(baseUrl + "/community/faq");
        driver.navigate().to(baseUrl + "/community/support");

        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        welcome.clickCommunityAndNodes();
        String menuHtml = welcome.returnCommunityAndNodesPopupHtml();

        Approvals.verifyHtml(menuHtml);
    }
}
