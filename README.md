# Make(file) me a Scala

> Build native Scala apps, fast.

## Key dependency
Install Coursier: https://get-coursier.io/docs/cli-overview

## Features

MakeMeAScala's features are based on a need to develop
many small data transformation utilities (for data science and finance accounting)
with TDD and have them available as native command line applications
so that we can compose them with other utilities
(like [sed](https://www.gnu.org/software/sed/),
[grep](https://www.gnu.org/software/grep/),
[awk](https://www.gnu.org/software/gawk/manual/gawk.html),
[tr](https://www.gnu.org/software/coreutils/manual/html_node/tr-invocation.html#tr-invocation),
[jq](https://stedolan.github.io/jq/)
) easily and swiftly.

We use coursier, GraalVM and entr to achieve this. There is **no** Scala code.

### Lightweight and magic-free

This is your build file. It's a Makefile.

You get control back because you can see exactly how your build is done (nature of `make`),
and so will millions of other people,
because of [GNU Make](https://www.gnu.org/software/make/manual/make.html)'s wide adoption.

GNU Make gives us dependency management and caching for free, I did not need to build it from scratch.

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

#### Example run

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

Yes and no.
Slow to compile; fast to understand and get started

### Use cases

- Get started with Scala, FAST (this is Scala's Achilles heel as the first step to getting started with Scala is an overwhelming one - to download an enterprise build system like Maven or SBT).
- Independent end-user utilities developed with fast test cycles (Love TDD and composing apps!).

For enterprise apps, or publishing libraries, use SBT or Maven.

### Commands

Here are some essential commands, in order of frequency of usage.

#### `make tdd`
Run tests continously when files (including the Makefile) are changed. Install entr: http://eradman.com/entrproject/

#### `make native`
Build a native image of your JAR with dependencies using GraalVM's `native-image` builder.
You will need to install `native-image` using their instructions: https://www.graalvm.org/docs/reference-manual/native-image/

#### `make test`
Run tests. No framework is used, it's just a simple app.

#### `make fmt`
Format Scala sources using scalafmt: https://scalameta.org/scalafmt/

#### `make jar`
Compile a JAR file from your sources.

