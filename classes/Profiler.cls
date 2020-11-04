/**
 * Profiler is a set of re-usable logic to assist in the profiling of your Apex Code
 */
public class Profiler {
	public Profiler() {}
	public static void limits() {
	    System.debug('~DMLStatements~'+Limits.getDMLStatements());
	    System.debug('~DMLRows~'+Limits.getDMLRows());
	    System.debug('~HeapSize~'+Limits.getHeapSize());
	    System.debug('~Queries~'+Limits.getQueries());		
	}
}