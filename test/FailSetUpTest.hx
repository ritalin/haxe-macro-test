package ;

@TestFixture
class FailSetUpTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@SetUp
	public function failSetUp() {
		this.logs.push("failSetUp");

		throw "Set-up has failed";
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