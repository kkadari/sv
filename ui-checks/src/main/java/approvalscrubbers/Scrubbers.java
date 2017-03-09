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

}
