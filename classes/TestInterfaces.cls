public class TestInterfaces 
{
	// @isSetup
	public Interface ITest 
	{
		void SetupData();
	}

	// Object Default Values
	public interface IFieldDefaults 
	{
		Map<String, Object> getFieldDefaults();
	}
}