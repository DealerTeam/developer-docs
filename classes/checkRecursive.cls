/**
 * checkRecursive
 * @description
 */
public Class checkRecursive{
    
    /**
     * @description
     */
    public static boolean run = true;
    
    /**
     * @description
     */
    private static boolean accRun = true;
    
    /**
     * @description
     */
    private static boolean runAgain = true;
    
    /**
     * @description
     */
    private static boolean oppRun = true;
    
    /**
     * @description
     */
    private static boolean supRun = true;
    
    /**
     * @description
     */
    private static boolean dealRun = true;
    
    /**
     * runOnce 
     * @return  boolean
     * @description
     */ 
    public static boolean runOnce()
    {
        if(run){
         run=false;
         return true;
        }else{
            return run;
        }
    }
    
    /**
     * accRunOnce 
     * @return  boolean
     * @description
     */
    public static boolean accRunOnce()
    {
        if(accRun){
            accRun=false;
            return true;
        }else{
            return accRun;
        }
    }

    /**
     * runOnceAgain 
     * @return  boolean
     * @description
     */ 
    public static boolean runOnceAgain()
    {
        if(runAgain){
            runAgain=false;
            return true;
        }else{
            return runAgain;
        }
    }

    /**
     * salesCloudOppRunOnce 
     * @return boolean
     * @description
     */
    public static boolean salesCloudOppRunOnce()
    {
        if(oppRun){
            oppRun=false;
            return true;
        }else{
            return oppRun;
        }
    } 

    /**
     * salesCloudSupRunOnce 
     * @return  boolean
     * @description
     */ 
    public static boolean salesCloudSupRunOnce()
    {
        if(supRun){
            supRun=false;
            return true;
        }else{
            return supRun;
        }
    }

    /**
     * salesCloudDealRunOnce 
     * @return  boolean
     * @description
     */ 
    public static boolean salesCloudDealRunOnce()
    {
        if(dealRun){
            dealRun=false;
            return true;
        }else{
            return dealRun;
        }
    } 
}