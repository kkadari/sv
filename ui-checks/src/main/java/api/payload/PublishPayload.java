package api.payload;

public class PublishPayload {

    private String visibility;

    public PublishPayload() {
        this.visibility = "all";
    }

    public String getVisibility() {
        return visibility;
    }
}
