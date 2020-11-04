public without sharing class TaskRelateNameControlHandler {

    /**
    * keyPrefix
    * @description holds the keyPrefix of the sales up object to compare with below
    */
    public static String keyPrefix = dealer__Sales_Up__c.sObjectType.getDescribe().getKeyPrefix();

    /**
    * statusMap
    * @description holds TaskStatus records to allow access to actual IsClosed value. IsClosed on the task is updated after Before Triggers so is not accurate in BEFORE context.
    */
    public static  Map<String, TaskStatus> statusMap = new Map<String, TaskStatus>();

    /**
    * markComplete
    * @description Runs before insert/update and updates Date_Completed__c the first time a closed status is selected
    */
    public static void markComplete(List<Task> triggerNew)
    {
        Map<String, TaskStatus> statusMap = new Map<String, TaskStatus>();
        //We have to query available statuses because the isClosed field is set by platform after this trigger executes
        if(statusMap.size() == 0){
            List<TaskStatus> statusList = [SELECT Id, MasterLabel, IsClosed FROM TaskStatus];
            for(TaskStatus s : statusList){
                statusMap.put(s.MasterLabel, s);
            }
        }
        
        for(Task t : triggerNew){
            if(t.dealer__Date_Completed__c == null && statusMap.get(t.Status) != null && statusMap.get(t.Status).IsClosed == true){
                t.dealer__Date_Completed__c = Datetime.now();
            }
        }
    }

    public static void setQuickNote(List<Task> triggerNew)
    {
        for(Task t : triggerNew){
            if(t.Description != null){
                t.Quick_Note__c = t.Description.left(255);
            }
        }    
    }

    /**
    * markComplete
    * @description Runs before update and clears Date_Completed__c if isClosed becomes false after being true
    */
    public static void clearComplete(List<Task> triggerNew, Map<Id, Task> triggerOldMap)
    {
        if(statusMap.size() == 0){
            List<TaskStatus> statusList = [SELECT Id, MasterLabel, IsClosed FROM TaskStatus];
            for(TaskStatus s : statusList){
                statusMap.put(s.MasterLabel, s);
            }
        }
        for(Task t : triggerNew){
            if(statusMap.get(t.Status) != null && statusMap.get(t.Status).IsClosed == false && triggerOldMap.get(t.Id).isClosed == true){
                t.dealer__Date_Completed__c = null;
            }
        }
    }

    /**
    * getRelatedSalesUps 
    * @description Runs after insert, update or delete and updates sales ups related by whatId
    */
    public static void getRelatedSalesUps(List<Task> triggerOld, System.TriggerOperation operation)
    {
        Map<Id, Task> supTaskMap = new Map<Id, Task>();
	    List<Id> tasks = new List<Id>();

        //Get tasks related to Sales Ups
        for(Task t : triggerOld) {
            String recordId = String.valueOf(t.WhatId);
            if(recordId==null) {
                recordId = '';
            }
            String recordKeyPrefix = recordId.left(3);

            if(keyPrefix == recordKeyPrefix) {
                tasks.add(t.WhatId);
                supTaskMap.put(t.WhatId, t);
            }
        }

		updateRelatedSalesUps(tasks, supTaskMap, operation);
    }

    /**
    * updateRelatedSalesUps
    * @description Handles updating task related fields on sales ups when task is inserted, updated, or deleted
    */
    private static void updateRelatedSalesUps(List<Id> taskId, Map<Id, Task> supIdToTask, System.TriggerOperation action)
    {
        Map<Id, Integer> idandTasks = new Map<Id, Integer>();
	    Map<Id, Boolean> idandOpen = new Map<Id, Boolean>();
        List<Task> taskList= [SELECT Id, WhatId, Status, isClosed FROM Task WHERE WhatId IN :taskId];
        for(Task k : taskList){
			if(idandTasks.get(k.WhatId) == null){
				idandTasks.put(k.WhatId,1);
			}
			else{
				idandTasks.put(k.WhatId, idandTasks.get(k.WhatId)+1);
			}
			if(k.isClosed == false){ 
				idandOpen.put(k.WhatId, true);
			}
		}

        List<dealer__Sales_Up__c> sups = [SELECT Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c FROM dealer__Sales_Up__c WHERE Id IN: idandTasks.keySet()];
		Map<Id, dealer__Sales_Up__c> updateSupsMap = new Map<Id, dealer__Sales_Up__c>();

		List<Id> supIds = new List<Id>(); // DR1 - Create List to store Sales Up Ids
	
		for(dealer__Sales_Up__c sup : sups){
			//Check if we need to update the number of related tasks or the boolean incomplete tasks
			if( (sup.dealer__Related_Tasks__c == null) ||
			( sup.dealer__Related_Tasks__c != null && sup.dealer__Related_Tasks__c != idandTasks.get(sup.Id) || 
			sup.dealer__Incomplete_Tasks__c != null && sup.dealer__Incomplete_Tasks__c != idandOpen.get(sup.Id) ) ) {
				sup.dealer__Related_Tasks__c = idandTasks.get(sup.Id);
				sup.dealer__Incomplete_Tasks__c = (idandOpen.get(sup.Id)==null ? false : true);
				updateSupsMap.put(sup.Id, sup);
			}

			// Start DR1a
			supIds.add(sup.Id); // Add Sales up Id to list so we can lookup all the Tasks by List
		}

        // Grab the other open tasks based on Sales Up Id List
		List<Task> otherOpenAll = [SELECT Id, ActivityDate, Status, WhatId FROM Task WHERE WhatId in:supIds AND isClosed = false AND ActivityDate >= TODAY];

		for(dealer__Sales_Up__c sup : sups){

			List<Task> otherOpen = new List<Task>();
			for(Task tsk : otherOpenAll){
				if(tsk.WhatId == sup.Id) {
					otherOpen.add(tsk);
				}
			}

			//Two actions. Either set NAD to null, or to earliest open date.
			if((String.valueOf(action) == 'AFTER_DELETE' || supIdToTask.get(sup.Id).isClosed == true) && otherOpen.size()==0){
				if(sup.dealer__NextActivityDate__c != null){
					sup.dealer__NextActivityDate__c = null;
                    updateSupsMap.put(sup.Id, sup);
				}
			}
			else{
				if(otherOpen.size()>0){
					Date fstDate = otherOpen[0].ActivityDate;
					for(Task t : otherOpen){
						if(t.ActivityDate < fstDate){
                            fstDate = t.ActivityDate;
                        }
					}
					if(sup.dealer__NextActivityDate__c != fstDate){
						sup.dealer__NextActivityDate__c = fstDate;
                        updateSupsMap.put(sup.Id, sup);
					}
				}
			}
		}

		if(updateSupsMap.size() > 0) {
			update updateSupsMap.values();
		}
    }

    
}