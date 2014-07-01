package ;

@TestFixture
class HogeTest {
	public var logs: Array<String>;

	public function new() { 
		this.logs = [];
	}

	@Test
	public function test1() { 
		this.logs.push("test1");
	}

	@Test
	public function test2() { 
		this.logs.push("test2");
	}

	@Test
	public function test3() { 
		this.logs.push("test3");
	}
}