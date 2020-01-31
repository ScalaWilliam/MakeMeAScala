.PHONY: \
run \
test \
clean \
run-jar \

default: target/f

DEPS := \
org.scala-lang:scala-library:2.13.1 \
org.jsoup:jsoup:1.12.1 \

MAIN_CLASS := F
NATIVE_OPTIONS := \
--no-fallback \
--no-server \
--initialize-at-build-time \
 

CP := $(shell coursier fetch $(DEPS) | tr '\n' ':')

run: f.scala
	scala -cp $(CP) f.scala
test: f.test.scala
	scala -cp $(CP) f.test.scala
target/f.jar: f.scala Makefile
	rm -rf target/f.jar
	rm -rf target/classes/
	mkdir -p target/classes/
	scalac -cp $(CP) -d target/classes/ f.scala
	jar cf target/f.jar -C target/classes . 
run-jar: target/f.jar
	java -cp target/f.jar:$(CP) $(MAIN_CLASS)
target/f: target/f.jar
	native-image $(NATIVE_OPTIONS) --class-path $(CP):target/f.jar -H:Name=target/f $(MAIN_CLASS)
clean:
	rm -rf target/
