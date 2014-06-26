package ;

import haxe.macro.Context;


@TestFixture
class FooTest {
	public function new() { 
		this.startupCalled = false;
	}

	public var startupCalled(default, null): Bool;
	public var methodCalled(default, null): Bool;

	@StartUp
	public function startup() {
		this.methodCalled = false;
		this.startupCalled = true;
	}

	@Test
	public function testMethod() {
		this.methodCalled = true;
	}
}
