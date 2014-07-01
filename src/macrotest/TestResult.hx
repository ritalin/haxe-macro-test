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

	public function testStarted() {
		++this.runs;
	}

	public function testFailed() {
		++this.fails;
	}

	public function errorOccured() {
		++this.errors;
	}

	public function summary() {
		return '${runs} run(s), ${fails} failed, ${errors} error(s)';
	}
}
