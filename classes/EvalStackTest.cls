@isTest class EvalStackTest {

	@isTest static void testNewStackIsEmpty() {
		EvalStack s = new EvalStack();
		System.assert(s.empty());
		System.assertEquals(0, s.size());
	}
	
	@isTest static void testPushesToEmptyStack() {
		EvalStack s = new EvalStack();
		Integer numberOfPushes = 6;
		Object o;
		for (Integer i = 0; i < numberOfPushes; i++) {
			System.assertEquals(o = 'foo', s.push(o));
		}
		System.assertEquals(false, s.empty());
		System.assertEquals(numberOfPushes, s.size());
	}
	
	@isTest static void testPushThenPop() {
		EvalStack s = new EvalStack();
		Object o = 'foo';
		System.assertEquals(o, s.push(o));
		System.assertEquals(o, s.pop());
	}
	
	@isTest static void testPushThenPeek() {
		EvalStack s = new EvalStack();
		Object o = 'foo';
		System.assertEquals(o, s.push(o));
		Integer size = s.size();
		System.assertEquals(o, s.peek());
		System.assertEquals(size, s.size());
	}
	
	@isTest static void testPopToEmpty() {
		EvalStack s = new EvalStack();
		Integer numberOfPushes = (Integer)(Math.random() * 20 + 1);
		Object o;
		for (Integer i = 0; i < numberOfPushes; i++) {
			System.assertEquals(o = 'foo', s.push(o));
		}
		for (Integer i = 0; i < numberOfPushes; i++) {
			System.assertEquals('foo', s.pop());
		}
		System.assert(s.empty());
		System.assertEquals(0, s.size());
	}
	
	@isTest static void testPopEmptyStackThrows() {
		EvalStack s = new EvalStack();
		try {
			s.pop();
			System.assert(false);
		}
		catch (EvalStack.EmptyStackException e) {}
	}
	
	@isTest static void testPeekEmptyStackThrows() {
		EvalStack s = new EvalStack();
		try {
			s.peek();
			System.assert(false);
		}
		catch (EvalStack.EmptyStackException e) {}
	}
	
	@isTest static void testSearch() {
		EvalStack s = new EvalStack();
		s.push(null);
		s.push('foo');
		s.push('bar');
		s.push(null);
		s.push('foo');
		s.push('bar');
		System.assertEquals(6, s.size());
		System.assertEquals(1, s.search('bar'));
		System.assertEquals(2, s.search('foo'));
		System.assertEquals(3, s.search(null));
		System.assertEquals(-1, s.search('qux'));
	}
}