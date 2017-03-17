import api.api.CreateContentApi;
import api.payload.DiscussionPayload;
import approvalscrubbers.Scrub;
import approvalscrubbers.Scrubbers;
import org.approvaltests.Approvals;
import org.junit.Before;
import org.junit.Test;
import pageobjects.ActivityPage;
import pageobjects.ContentPage;
import pageobjects.SearchPage;

import java.util.ArrayList;

public class TLPViewsTest extends TestSetup {

    @Before
    public void generateNineEntries(){
        for(int i = 0; i < 9; i++){
            int tlp = (i % 4) + 1;
            DiscussionPayload discussionPayload = new DiscussionPayload("Check discussion", false, "Generated for automation", Integer.toString(tlp), false);

            CreateContentApi.createDiscussion(cookies, baseUrl, discussionPayload);
        }
    }

    @Test
    public void approveTlpPillsInAdvancedSearch() throws InterruptedException {
        SearchPage search = new SearchPage(driver);

        Boolean resultsShown = false;
        while (!resultsShown){
            driver.navigate().to(baseUrl + "/search.jspa?q=Check discussion");

            resultsShown = search.returnResultIsDisplayed();
        }

        String rawAdvancedSearch = search.returnSearchResults();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubSearchUrl());
            add(Scrubbers.scrubDates());
            add(Scrubbers.scrubMessageId());
        }};

        String scrubbedAdvancedSearch = Scrub.scrub(scrubbers, rawAdvancedSearch);

        Approvals.verifyHtml(scrubbedAdvancedSearch);
    }

    @Test
    public void approveTlpPillsInActivityFeed(){
        driver.navigate().to(baseUrl + "/news?channel=recent");

        ActivityPage activity = new ActivityPage(driver);
        String rawStreamList = activity.returnStreamListHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
           add(Scrubbers.scrubDates());
           add(Scrubbers.scrubActTitleId());
           add(Scrubbers.scrubThreadId());
        }};

        String scrubbedStreamList = Scrub.scrub(scrubbers, rawStreamList);

        Approvals.verifyHtml(scrubbedStreamList);
    }

    @Test
    public void approveTlpPillsInContentFeed(){
        driver.navigate().to(baseUrl + "/content?filterID=all&itemView=detail");

        ContentPage content = new ContentPage(driver);
        String rawRowContentList = content.returnTableRowContentHtml();

        ArrayList<String> scrubbers = new ArrayList<String>(){{
            add(Scrubbers.scrubDates());
            add(Scrubbers.scrubThreadId());
            add(Scrubbers.scrubDataObjectId());
        }};

        String scrubbedRowContentList = Scrub.scrub(scrubbers, rawRowContentList);

        Approvals.verifyHtml(scrubbedRowContentList);
    }

}
