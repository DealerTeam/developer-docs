/**
 * DMSImportsQueable
 * @description
 */
public class DMSImportsQueable implements Queueable {
    String type;
    String json;

    /**
     * DMSImportsQueable 
     * @param  objectType 
     * @param  objectJSON 
     * @description
     */
    public DMSImportsQueable(String objectType, string objectJSON)
    {
        type = objectType;
        json = objectJSON;
    }

    /**
     * execute 
     * @param  context 
     * @return void
     * @description
     */
    public void execute(QueueableContext context)
    {
        DMSImportsAPI.routeObject(type,json,context.getJobId());
    }
}