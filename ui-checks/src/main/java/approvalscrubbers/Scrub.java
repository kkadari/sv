package approvalscrubbers;

import java.util.ArrayList;

public class Scrub {

    public static String scrub(ArrayList<String> scrubbers, String content){
        for(String scrubber : scrubbers){
            content = content.replaceAll(scrubber, "***scrubbed***");
        }

        return content;
    }

}
