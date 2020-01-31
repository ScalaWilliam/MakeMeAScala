.PHONY: \
native \
run \
test \
clean \
run-jar \

default: native

DEPS := \
org.scala-lang:scala-library:2.13.1 \
org.jsoup:jsoup:1.12.1 \

MAIN_CLASS := F
NATIVE_OPTIONS := \
--no-fallback \
--no-server \
--initialize-at-build-time \
 

CP := $(shell coursier fetch $(DEPS) | tr '\n' ':')

run: target/f.jar
	java -cp target/f.jar:$(CP) F
test: f.test.scala target/f.jar
	scala -cp $(CP):target/f.jar f.test.scala
target/classes/F.class: f.scala Makefile
	rm -rf target/classes/
	mkdir -p target/classes/
	scalac -cp $(CP) -d target/classes/ f.scala
target/f.jar: target/classes/F.class
	rm -rf target/f.jar
	jar cf target/f.jar -C target/classes . 
target/test-classes/FTest.class: f.test.scala target/f.jar
	rm -rf target/test-classes/
	mkdir -p target/test-classes/
	scalac -cp $(CP):target/f.jar -d target/test-classes/ f.test.scala
target/f.test.jar: target/test-classes/FTest.class Makefile
	rm -rf target/f.test.jar
	jar cf target/f.test.jar -C target/test-classes .
run-jar: target/f.jar
	java -cp target/f.jar:$(CP) $(MAIN_CLASS)
target/f: target/f.jar
	native-image $(MAIN_CLASS) $(NATIVE_OPTIONS) --class-path $(CP):target/f.jar -H:Name=target/f
clean:
	rm -rf target/
native: target/f

