package failtest;

@TestFixture
class FailTearDownTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@TearDown
	public function tearDown() {
		throw "Error occured at tear down";
	}

	@Test
	public function testMethod() {
		this.logs.push("testMethod");
	}
}