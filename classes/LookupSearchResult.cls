/**
* Class used to serialize a single Lookup search result item
* The Lookup controller returns a List<LookupSearchResult> when sending search result back to Lightning
*/
public class LookupSearchResult {

    public enum IconType {SLDS, DOC}

    private String id;
    private String sObjectType;
    // Depending on IconType enum, this will either be the image URL, or an SLDS icon definition
    private String icon;
    private String title;
    private String subtitle;
    private IconType iconType;

    public LookupSearchResult(String id, String sObjectType, String icon, String title, String subtitle, IconType iconType) {
        this.id = id;
        this.sObjectType = sObjectType;
        this.icon = icon;
        this.title = title;
        this.subtitle = subtitle;
        this.iconType = iconType;
    }

    @AuraEnabled
    public String getId() {
        return id;
    }

    @AuraEnabled
    public String getSObjectType() {
        return sObjectType;
    }

    @AuraEnabled
    public String getIcon() {
        return icon;
    }

    @AuraEnabled
    public String getIconType() {
        return iconType != null ? iconType.name() : null;
    }

    @AuraEnabled
    public String getTitle() {
        return title;
    }

    @AuraEnabled
    public String getSubtitle() {
        return subtitle;
    }
}