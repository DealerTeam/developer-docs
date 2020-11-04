/**
 * reusable controller extension to generate a dynamic component for evaluating formulas
 */
public class FormulaRenderer {
	/** The string contains the formula we are attempting to evaluate */
    public String formulaValue {get;set;}
    
    /**
     * constructor
     * @description Constructor will look for get method arguments
     */
    public FormulaRenderer()
    {
        formulaValue = ApexPages.currentPage().getParameters().get('formula');
    }
    
    public Component.Apex.OutputText getevalFormula()
    {
        
        System.debug(formulaValue);
        
        Component.Apex.OutputText outText = new Component.Apex.OutputText();
        outText.expressions.value = formulaValue;
        return outText;
    }
    
}