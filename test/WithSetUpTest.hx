package ;

@TestFixture
class WithSetUpTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@SetUp
	public function setUp() {
		this.logs.push("setUp");
	}

	@Test
	public function testMethod() {
		this.logs.push("testMethod");
	}
}