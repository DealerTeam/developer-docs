/**
 * DealerTrack_Vehicle
 * @description
 */
public abstract class DealerTrack_Vehicle 
{
	// Base Vehicle Properties
    
    /**
     * @description
     */
    public String Year { get; set; }
    
    /**
     * @description
     */
    public String Make { get; set; }
    
    /**
     * @description
     */
    public String Model { get; set; }
    
    /**
     * @description
     */
    public String Trim { get; set; }
    
    /**
     * @description
     */
    public String VIN { get; set; }
    
    /**
     * @description
     */
    public String Mileage { get; set; }
    
    /**
     * @description
     */
    public String ChromeStyleId { get; set; }    
    
    /**
     * @description
     */
    public String TransmissionType { get; set; }
    
    /**
     * @description
     */
    public String InteriorColor { get; set; }
    
    /**
     * @description
     */
    public String ExteriorColor { get; set; }
    
    /**
     * @description
     */
    public List<UrlListType> UrlForMoreInformation { get; set; }
    
    /**
     * @description New or Financed Vehicle
     */ 
    public class FinancedVehicle extends DealerTrack_Vehicle
    {
    	public String VehicleCondition { get; set; }
    	public String CertifiedUsed { get; set; }
    	public String StockNumber  { get; set; }
    	public String EngineType  { get; set; }   	
    }
    
    /**
     * @description 
     */
    public class TradeInVehicle extends DealerTrack_Vehicle
    {
    	public String LienHolder  { get; set; }
    	public String TradeInPaid  { get; set; }
    	public String AppraisalDate  { get; set; }
    	public String AppraisalValue  { get; set; }
    	public String AppraisalSource  { get; set; }
    	public String AmountOwed  { get; set; }
    }
    
    /**
     * @description
     */ 
    public class UrlListType
    {
    	public String Url { get; set; }
    }
}