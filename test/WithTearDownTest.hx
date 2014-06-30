package ;

class WithTearDownTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
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