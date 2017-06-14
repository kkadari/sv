package approvalscrubbers;

public class Scrubbers {

    public static String scrubJiveId(){
        return "id=\"jive-[0-9]*\"";
    }

    public static String scrubThreadRef(){
        return "\\/thread\\/[0-9]*";
    }

    public static String scrubDisplayObjectKeys(){
        return "name=\"displayedObjectKeys\" value=\"[0-9_,]*\"";
    }

    public static String scrubMessageId(){
        return "message(s?)\\/[0-9]*";
    }

    public static String scrubDates(){
        return "[0-9]{2}:[0-9]{2}:[0-9]{2}.[0-9]{3}";
    }

    public static String scrubSearchUrl(){
        return "href=\".*searchIndex.*\"";
    }

    public static String scrubActTitleId(){
        return "act-title-[0-9]*";
    }

    public static String scrubThreadId(){
        return "\\/thread\\/[0-9]*";
    }

    public static String scrubDataObjectId() {
        return "data-object(-?)id=\"[0-9]*\"";
    }
}
