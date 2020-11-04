/**
*
*	Schedulable interface for the vehicle inventory syndication feed
*
*/
public class VehicleSyndicationScheduler implements Schedulable {
	public void execute(SchedulableContext SC) {
		VehicleInventorySyndication.publishFeed();
	}
}