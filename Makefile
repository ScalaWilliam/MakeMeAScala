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