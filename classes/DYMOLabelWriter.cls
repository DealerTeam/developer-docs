public with sharing class DYMOLabelWriter {
	/**
	 * Queries and returns the info needed to create a part label
	 * @Param controller
	 * @test PartPhysicalIventoryServiceLayer.testDYMOLabelWriter
	 */
	public DYMOLabelWriter(ApexPages.StandardController controller) {}

	public class PaObject
	{
	    	public Integer labelQuantity { get; set;}
	        private dealer__Parts_Inventory__c m_part;
	        public dealer__FixedOperationsSettings__c settings = dealer__FixedOperationsSettings__c.getValues(UserInfo.getUserId());
	        public String defaultPrinterName { get; set; }
	        public PaObject()
	        {
	            Id id = System.currentPageReference().getParameters().get('id');
	            
	            m_part = id == null ? new dealer__Parts_Inventory__c() :
	                [SELECT Id, Name, dealer__Best_Stocking_Level__c, dealer__Bin_2__c, dealer__Bin__c, dealer__Comments__c, 
	                	dealer__Comp__c, dealer__Core__c, dealer__Cost__c, dealer__Description__c, 
	                	dealer__Detail__c, dealer__Entry_Date__c, dealer__Group__c, dealer__High_Days__c, dealer__High_Year__c, 
	                	dealer__Last_Sale_Date__c, dealer__List__c, dealer__Low_Days__c, dealer__Low_Year__c, dealer__MFG__c, 
	                	dealer__Max__c, dealer__Min__c, dealer__On_Back_Order__c, dealer__On_Hand__c, dealer__On_Order__c, 
	                	dealer__On_Special_Order__c, dealer__Pack_QTY__c, dealer__Part_No__c, dealer__Price_Update__c, 
	                	dealer__Re_Order_Point__c, dealer__Remarks__c, dealer__Reserved__c, dealer__Return_Code__c, dealer__Source__c, 
	                	dealer__Static_Price__c, dealer__Status__c, dealer__Trade__c, dealer__Warranty__c, dealer__Weight__c, 
	                	dealer__Company_Number__c, dealer__Parts_Master__c, dealer__Online_Store_Id__c, dealer__Jobber__c, 
	                	dealer__Stocking_Group__c, dealer__Gross_Margin__c, dealer__Source_List__c, dealer__Extended_Description__c, 
	                	dealer__Minimum_Margin__c, dealer__Kit__c, dealer__PNC__c, dealer__Extra_Days__c, dealer__Tax_Exempt__c, 
	                	dealer__Illustration__c, dealer__UPC__c, dealer__Raw_Part_Number__c
	                FROM dealer__Parts_Inventory__c 
	                WHERE Id =: id 
	                LIMIT 1];        
	           
	            printBarcode = 'true';
	            
	            formattedAddress = '';
	            labelQuantity = 1;

	            // Set Default Printer
	            if(settings!=null) {
	            	defaultPrinterName = settings.dealer__Label_Printer__c;
	            }
	        }
	        
	        public dealer__Parts_Inventory__c getPart()
	        {
	            return m_part;
	        }
	        
	        // part full name
	        public String getPartFullName()
	        {
	            if (m_part == null)
	            {
	                system.Debug(logginglevel.ERROR, 'PaObject.m_part is null');
	                return '';
	            }
	            
	            if(m_part.dealer__Raw_Part_Number__c!=null) {
	            	return m_part.dealer__Raw_Part_Number__c;
	            }
	            return m_part.Name;
	        }

	        public String setPartFullName() {
	        	return '';
	        }

	        public String getPartDescription() {
	        	if(m_part==null) {
	                system.Debug(logginglevel.ERROR, 'PaObject.m_part is null');
	                return '';	        		
	        	}
	        	return m_part.dealer__Description__c;
	        }
	        
	        public String printBarcode { get; set; }
	             
	        private String formattedAddress = '';
	       
	        public String getAddressLabelXml()
	        {
	            String template = '<?xml version="1.0" encoding="utf-8"?> <DieCutLabel Version="8.0" Units="twips"> <PaperOrientation>Landscape</PaperOrientation> <Id>Small30336</Id> <PaperName>30336 1 in x 2-1/8 in</PaperName> <DrawCommands> <RoundRectangle X="0" Y="0" Width="1440" Height="3060" Rx="180" Ry="180" /> </DrawCommands> <ObjectInfo> <TextObject> <Name>PARTNAME</Name> <ForeColor Alpha="255" Red="0" Green="0" Blue="0" /> <BackColor Alpha="0" Red="255" Green="255" Blue="255" /> <LinkedObjectName></LinkedObjectName> <Rotation>Rotation0</Rotation> <IsMirrored>False</IsMirrored> <IsVariable>False</IsVariable> <HorizontalAlignment>Left</HorizontalAlignment> <VerticalAlignment>Top</VerticalAlignment> <TextFitMode>ShrinkToFit</TextFitMode> <UseFullFontHeight>True</UseFullFontHeight> <Verticalized>False</Verticalized> <StyledText /> </TextObject> <Bounds X="130" Y="150" Width="2846" Height="345" /> </ObjectInfo> <ObjectInfo> <BarcodeObject> <Name>BARCODE</Name> <ForeColor Alpha="255" Red="0" Green="0" Blue="0" /> <BackColor Alpha="0" Red="255" Green="255" Blue="255" /> <LinkedObjectName></LinkedObjectName> <Rotation>Rotation0</Rotation> <IsMirrored>False</IsMirrored> <IsVariable>True</IsVariable> <Text>12345</Text> <Type>Code39</Type> <Size>Small</Size> <TextPosition>Bottom</TextPosition> <TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> <CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" /> <TextEmbedding>None</TextEmbedding> <ECLevel>0</ECLevel> <HorizontalAlignment>Center</HorizontalAlignment> <QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" /> </BarcodeObject> <Bounds X="130" Y="630" Width="2846" Height="720" /> </ObjectInfo> </DieCutLabel>';
	            return template;        
	        }
	      
	        private String imageSrc = 'data:image/png;base64';
	        
	        public void setImageSrc(String value)
	        {
	            imageSrc = value;
	        }
	        
	        public String getImageSrc()
	        {
	            return imageSrc;
	        }

	    }

	    private paObject m_paObject;
	   
	    public PaObject getPaObject()
	    {
	        if (m_paObject == null)
	        {
	            m_paObject = new PaObject();
	            System.debug(logginglevel.INFO, 'singleton PaObject is created');
	        }
	        return m_paObject;
	    }
		
		/**
		 * Sets provided string as default label printer in FixedOperationSettings
		 * @Param String printer name
		 * @returns Boolean always true
		 * @test PartPhysicalIventoryServiceLayer.testDYMOLabelWriter
		 */
	    @remoteAction
	    static public boolean setDefaultPrinter(String printerName) {

	    	dealer__FixedOperationsSettings__c settings = dealer__FixedOperationsSettings__c.getValues(UserInfo.getUserId());
	    	settings.dealer__Label_Printer__c = printerName;
	    	update settings;

	    	return true;
	    }
}