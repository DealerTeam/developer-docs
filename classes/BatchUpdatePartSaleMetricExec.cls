/**
 * BatchUpdatePartSaleMetricExec
 * @test PartAnalyticsSystemLayer.testBatchScheduledEvent
 * @description
 */
global with sharing class BatchUpdatePartSaleMetricExec implements Schedulable {
	
	/**
	 * execute 
	 * @param  sc 
	 * @return void
	 * @description
	 */
	global void execute(SchedulableContext sc)
	{
		BatchUpdatePartSaleMetric b = new BatchUpdatePartSaleMetric();
		Id batchId = Database.executeBatch(b, 200);
	}
}