/**
 * CheckRecursiveMap
 * @description
 */ 
public with sharing class CheckRecursiveMap {

	/**
	 * @description
	 */
	public static boolean run = true;

	/**
	 * @description
	 */
    public static Map<String,Boolean> MapRunOnce;
	
	/**
	 * @description
	 */
	public static Map<String,Integer> MapRunTwice;
    
    /**
	 * RunOnce 
	 * @param  triggerName 
	 * @return  boolean
	 * @description           
	 */
	public static boolean RunOnce(string triggerName)
	{
	    
	    if(MapRunOnce == null){
	        MapRunOnce=new Map<String,Boolean>();
	    }
	    if(MapRunOnce.get(triggerName)==null){
	        MapRunOnce.put(triggerName,true);
	    }
	    else
	    {
	        MapRunOnce.put(triggerName,false);
	    }
	    return MapRunOnce.get(triggerName);   
    }

	/**
	 * RunTwice 
	 * @param  triggerName 
	 * @return  boolean
	 * @description  Allows for recursion prevention on triggers that must run twice. Example is SRO that calculates charges based on a Roll-Up summary fields, which occurs after triggers fire         
	 */
	public static boolean RunTwice(string triggerName)
	{
	    
	    if(MapRunTwice == null){
	        MapRunTwice=new Map<String,Integer>();
	    }
	    if(MapRunTwice.get(triggerName)==null){
	        MapRunTwice.put(triggerName,0);
	    }
	    else
	    {
	        MapRunTwice.put(triggerName, MapRunTwice.get(triggerName)+1);
	    }
		if(MapRunTwice.get(triggerName) < 2){
	    	return true;
		}
		else {
			return false;
		}   
    }
}