package ;

import FooTest;
import macrotest.MacroTestRunner;

class TestMain {
	macro
	static function main() {
		runAtMacro();
	}

	static function runAtMacro() {
		var foo = new FooTest();
		var runner = new MacroTestRunner();

		trace('startupCalled: ${foo.startupCalled}');
		trace('methodCalled: ${foo.methodCalled}');
		trace('teardownCalled: ${foo.teardownCalled}');
		runner.run(FooTest, foo);
		trace('startupCalled: ${foo.startupCalled}');
		trace('methodCalled: ${foo.methodCalled}');
		trace('teardownCalled: ${foo.teardownCalled}');

		return macro null;
	}
}