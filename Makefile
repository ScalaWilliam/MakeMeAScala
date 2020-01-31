include Makefile.base

APP_NAME = F

DEPS = \
org.scala-lang:scala-library:2.13.1 \
org.jsoup:jsoup:1.12.1 \

NATIVE_OPTIONS = \
--no-fallback \
--no-server \
--initialize-at-build-time \
