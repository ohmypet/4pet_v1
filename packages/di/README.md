# Dart  Dependency Injection	

**Getting Started**

1/ Binding:    
    
    class TestModule extends AbstractModule {
	    @override
	    void init() {
		    bind(String).to("A String Instance");
		    bind(int).to(404);
		    bind(TestClass).to(new TestClass(this.get(String)));
		    bind("AnotherTestClass").to(new TestClass("AnotherTestClass"));
	    }
    }

2/  Use your DI

    void main() {
	    DI.init([new TestModule()]);
	    String str = DI.get(String);
	    expect(str, equals("A String Instance"));
    }
