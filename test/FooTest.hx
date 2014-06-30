package ;

import haxe.macro.Context;


@TestFixture
class FooTest {
	public function new() { 
		this.startupCalled = false;
		this.methodCalled = false;	
		this.teardownCalled = false;
	}

	public var startupCalled(default, null): Bool;
	public var methodCalled(default, null): Bool;
	public var teardownCalled(default, null): Bool;

	@StartUp
	public function startUp() {
		this.startupCalled = true;
	}

	@TearDown
	public function tearDown() {
		this.teardownCalled = true;
	}

	@Test
	public function testMethod() {
		this.methodCalled = true;
	}
}
