# Make me a Scala

> Build native Scala apps, fast.

## What are the prerequisites?
- `make` (available on every Linux/macOS)
- Coursier: https://get-coursier.io/docs/cli-overview
- entr for TDD: http://eradman.com/entrproject/
- GraalVM `native-image`: https://www.graalvm.org/docs/reference-manual/native-image/

## What is this?
It is a template that lets you build Scala ___apps___ with [test-driven-development](http://www.agiledata.org/essays/tdd.html) (TDD)
 and create independent ___native executables___ swiftly.
 
## Why did you build it?

I need Scala, I need TDD, I need command-line utilities (like [sed](https://www.gnu.org/software/sed/),
   [grep](https://www.gnu.org/software/grep/),
   [awk](https://www.gnu.org/software/gawk/manual/gawk.html),
   [tr](https://www.gnu.org/software/coreutils/manual/html_node/tr-invocation.html#tr-invocation),
   [jq](https://stedolan.github.io/jq/))
and I need workflow management. In particular, for:
- Data science - see lovely article on Medium: [Makefiles are easy. Makefiles will change your life. Every data scientist should be using Makefiles. You need Makefiles.
](https://medium.com/@davidstevens_16424/make-my-day-ta-science-easier-e16bc50e719c)
- Finance accounting - see [hledger](https://hledger.org/).
- Static website generation.

## How did you build it?

GNU Make, coursier, GraalVM and entr to achieve this. There is **no** Scala code.

## How does a build file look?

It's a standard `Makefile` that most Linux users will be familiar with.

```makefile
APP_NAME = MakeMeAScala

SCALA_VERSION = 2.13.1

DEPS = \
org.scala-lang:scala-library:2.13.1 \
org.jsoup:jsoup:1.12.1 \

NATIVE_OPTIONS = \
--no-fallback \
--no-server \
--initialize-at-build-time \

include Makefile.base

NATIVE_OPTIONS += -H:EnableURLProtocols=http
```

Main sources are all `*.scala` files in the root,
except for test sources which are all `*Test.scala`.

#### How does the build process look?

```
$ make clean test
rm -rf target/
rm -rf target/classes
mkdir -p target/classes
java -cp /Users/william/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.1/scala-compiler-2.13.1.jar:.../Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.1/scala-library-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.1/scala-reflect-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/fusesource/jansi/jansi/1.12/jansi-1.12.jar: scala.tools.nsc.Main -cp /Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.1/scala-library-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/jsoup/jsoup/1.12.1/jsoup-1.12.1.jar: -d target/classes MakeMeAScala.scala SecondMainScala.scala
rm -rf target/MakeMeAScala.jar
jar cf target/MakeMeAScala.jar -C target/classes .
rm -rf target/test-classes
mkdir -p target/test-classes
java -cp /Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-compiler/2.13.1/scala-compiler-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.1/scala-library-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.1/scala-reflect-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/fusesource/jansi/jansi/1.12/jansi-1.12.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.jar: scala.tools.nsc.Main -cp /Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.1/scala-library-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/jsoup/jsoup/1.12.1/jsoup-1.12.1.jar::target/MakeMeAScala.jar -d target/test-classes MakeMeAScalaTest.scala
rm -rf target/MakeMeAScala.test.jar
jar cf target/MakeMeAScala.test.jar -C target/test-classes .
java -cp target/MakeMeAScala.jar:target/MakeMeAScala.test.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.1/scala-library-2.13.1.jar:/Users/me/.coursier/cache/v1/https/repo1.maven.org/maven2/org/jsoup/jsoup/1.12.1/jsoup-1.12.1.jar: MakeMeAScalaTest
Tests passed.
```

##### Isn't it slow?
Slow to compile; fast to understand, get started and build out workflows.

### Why would you use it?

- Independent command-line applications developed with fast test cycles (Love TDD and composing apps!).
- Introduce your friends to Scala, ***FAST***. Scala's Achilles heel is the amount of time it takes to set up an enterprise build tool to get coding.

#### For larger projects
For enterprise apps, or publishing libraries, use SBT or Maven.

## How do you use it?
Here are some essential commands, in order of frequency of usage.

### `make tdd`
Run tests continously when files (including the Makefile) are changed. Install entr: http://eradman.com/entrproject/

### `make native`
Will create a native binary in `./test/MakeMeAScala`.

### `make test`
Run the tests. No framework is used, it's just a simple app.

### `make fmt`
Format Scala sources using (scalafmt)[https://scalameta.org/scalafmt/].

### `make jar`
Compile a JAR file from your sources.

