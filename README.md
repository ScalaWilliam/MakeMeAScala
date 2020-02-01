# Make(file) me a Scala

> Build native Scala apps, fast.

## Key dependency
Install Coursier: https://get-coursier.io/docs/cli-overview

## Features

MakeMeAScala's features are based on a need to develop
many small data transformation utilities (for data science and finance accounting)
with TDD and have them available as native command line applications
so that we can compose them with other applications easily and swiftly.

We use coursier, GraalVM and entr to achieve this. 

### Lightweight and magic-free

This is your buildfile. It's a Makefile, no strange syntax.

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

### `make fmt`
Run scalafmt to format sources.

### `make jar`
Compile a JAR file from your sources.

### `make test-jar`
Compile a Test JAR from your test and main sources.
### `make native`
Build a native image of your JAR with dependencies using GraalVM's `native-image` builder.
You will need to install `native-image` using their instructions: https://www.graalvm.org/docs/reference-manual/native-image/

### `make test`
Run tests. No framework is used, it's just a simple app.

### `make tdd`
Run tests continously when files (including the Makefile) are changed. Install entr: http://eradman.com/entrproject/

### `make fmt`

## Technology

We use `make` and Coursier. 

## Background



