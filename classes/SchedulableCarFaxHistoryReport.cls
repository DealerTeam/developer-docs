global class SchedulableCarFaxHistoryReport implements Schedulable {
  
    /**
     * execute 
     * @param  sc 
     * @return void
     * @description
     */ 
    global void execute(SchedulableContext sc) 
    {
        BatchCarfaxHistoryReport br = new BatchCarfaxHistoryReport();
        ID batchprocessID = Database.executeBatch(br, 1);
    }
  }
