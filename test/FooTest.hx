package ;

import haxe.macro.Context;


@TestFixture
class FooTest {
	public function new() { 
		this.called = false;
	}

	public function run() {
		Reflect.callMethod(this, Reflect.field(this, 'testMethod'), []);
	}

	public function testMethod() {
		this.called = true;
	}

	@Test
	public var called(default, null): Bool;
}