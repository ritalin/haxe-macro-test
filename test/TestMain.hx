package ;

import FooTest;

class TestMain {
	static function main() {
		runAtMacro();
	}

	macro
	private static function runAtMacro() {
		var foo = new FooTest();

		trace(foo.called);
		foo.testMethod();
		trace(foo.called);

		return macro null;
	}
}