package macrotest;

class TestResult {
	public var runs(default, null): Int;
	public var fails(default, null): Int;
	public var errors(default, null): Int;

	public function new() {
		this.runs = 0;
		this.fails = 0;
		this.errors = 0;
	}

	public function testStarted(): Void {
		++this.runs;
	}

	public function testFailed(): Void {
		++this.fails;
	}

	public function errorOccured(): Void {
		++this.errors;
	}

	public function summary(): String {
		return '${runs} run(s), ${fails} failed, ${errors} error(s)';
	}

	public function concat(r: TestResult): TestResult {
		var result = new TestResult();
		result.runs = this.runs + r.runs;
		result.fails += this.fails + r.fails;
		result.errors += this.errors + r.errors;

		return result;
	}
}
