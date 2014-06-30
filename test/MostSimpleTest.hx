package ;

@TestFixture
class MostSimpleTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@Test
	public function testMethod() {
		this.logs.push("testMethod");
	}
}