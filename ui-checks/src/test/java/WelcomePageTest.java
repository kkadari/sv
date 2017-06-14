import api.api.CreateContentApi;
import api.payload.DiscussionPayload;
import approvalscrubbers.Scrub;
import approvalscrubbers.Scrubbers;
import org.approvaltests.Approvals;
import org.junit.Before;
import org.junit.Test;
import pageobjects.WelcomePage;

import java.util.ArrayList;

public class WelcomePageTest extends TestSetup {

    @Before
    public void generateTestContent(){
        for(int i = 1; i <= 7; i++){
            DiscussionPayload discussionPayload = new DiscussionPayload("Check discussion", false, "Generated for automation", "1", false);

            CreateContentApi.createDiscussion(cookies, baseUrl, discussionPayload);
        }
    }

    @Test
    public void approveStaticCallToAction(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        String rawWidgetContainer = welcome.returnWidgetContainerHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubJiveId());
        }};

        String scrubbedWidgetContainer = Scrub.scrub(scrubbers, rawWidgetContainer);

        Approvals.verifyHtml(scrubbedWidgetContainer);
    }

    @Test
    public void approveWhatsHappening(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        String whatsHappeningContainer = welcome.returnWhatsHappeningHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubJiveId());
            add(Scrubbers.scrubThreadRef());
            add(Scrubbers.scrubDisplayObjectKeys());
        }};

        String scrubbedWhatsHappeningContainer = Scrub.scrub(scrubbers, whatsHappeningContainer);

        Approvals.verifyHtml(scrubbedWhatsHappeningContainer);
    }

    @Test
    public void approveWhatsHappeningPopularTab(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        welcome.clickFeedPopular();

        String whatsHappeningContainer = welcome.returnWhatsHappeningHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubJiveId());
            add(Scrubbers.scrubThreadRef());
            add(Scrubbers.scrubDisplayObjectKeys());
        }};

        String scrubbedWhatsHappeningContainer = Scrub.scrub(scrubbers, whatsHappeningContainer);

        Approvals.verifyHtml(scrubbedWhatsHappeningContainer);
    }

    @Test
    public void approveWhatsHappeningFollowingTab(){
        driver.navigate().to(baseUrl + "/welcome");

        WelcomePage welcome = new WelcomePage(driver);
        welcome.clickFeedFollowing();

        String whatsHappeningContainer = welcome.returnWhatsHappeningHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubJiveId());
            add(Scrubbers.scrubThreadRef());
            add(Scrubbers.scrubDisplayObjectKeys());
        }};

        String scrubbedWhatsHappeningContainer = Scrub.scrub(scrubbers, whatsHappeningContainer);

        Approvals.verifyHtml(scrubbedWhatsHappeningContainer);
    }

}
