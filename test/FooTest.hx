package ;

@TestFixture
class FooTest {
	public function new() { 
		this.called = false;
	}

	public function testMethod() {
		this.called = true;
	}

	public var called(default, null): Bool;
}