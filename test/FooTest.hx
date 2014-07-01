package ;

import haxe.macro.Context;


@TestFixture
class FooTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@SetUp
	public function setUp() {
		this.logs.push("setUp");
	}

	@TearDown
	public function tearDown() {
		this.logs.push("tearDown");
	}

	@Test
	public function testMethod() {
		this.logs.push("testMethod");
	}
}
