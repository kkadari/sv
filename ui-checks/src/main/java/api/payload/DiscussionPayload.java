package api.payload;

public class DiscussionPayload {

//    {
//        "subject": "asdasdasads",
//        "markAsQuestion": false,
//        "body": "<body><p>asdasdasdasdasasdas</p></body>",
//        "handlingLevel": "2",
//        "publishBar": {
//            "visibility": "all"
//        },
//        "notAttributable": false,
//    }

    private String subject;
    private Boolean markAsQuestion;
    private String body;
    private String handlingLevel;
    private PublishPayload publishBar;
    private boolean notAttributable;

    public DiscussionPayload(String subject, Boolean markAsQuestion, String body, String handlingLevel, boolean notAttributable) {
        this.subject = subject;
        this.markAsQuestion = markAsQuestion;
        this.body = body;
        this.handlingLevel = handlingLevel;
        this.publishBar = new PublishPayload();
        this.notAttributable = notAttributable;
    }

    public String getSubject() {
        return subject;
    }

    public Boolean getMarkAsQuestion() {
        return markAsQuestion;
    }

    public String getBody() {
        return body;
    }

    public String getHandlingLevel() {
        return handlingLevel;
    }

    public PublishPayload getPublishBar() {
        return publishBar;
    }

    public boolean isNotAttributable() {
        return notAttributable;
    }
}
