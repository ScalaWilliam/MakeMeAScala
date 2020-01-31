
DEPS := \
org.scala-lang:scala-library:2.13.1 \
org.jsoup:jsoup:1.12.1 \

APP_NAME := F

NATIVE_OPTIONS := \
--no-fallback \
--no-server \
--initialize-at-build-time \

TEST_FILTER := Test.scala
MAIN_CLASS := $(APP_NAME)
TEST_CLASS := $(APP_NAME)Test

.PHONY: \
native \
run \
test \
clean \
tdd \
run-jar \

default: native

MAIN_SOURCES := $(shell ls *.scala | grep -v -F $(TEST_FILTER))
MAIN_TEST_SOURCES := $(shell ls *.scala | grep -F $(TEST_FILTER))

TARGET := target
TARGET_CLASSES_DIR := $(TARGET)/classes
TARGET_TEST_CLASSES := $(TARGET)/test-classes
TARGET_NATIVE := $(TARGET)/$(APP_NAME)
TARGET_JAR := $(TARGET)/$(APP_NAME).jar
TARGET_TEST_JAR := $(TARGET)/$(APP_NAME).test.jar

CP := $(shell coursier fetch $(DEPS) | tr '\n' ':')

run: $(TARGET_JAR)
	java -cp $(TARGET_JAR):$(CP) $(MAIN_CLASS)

test: $(TARGET_JAR) $(TARGET_TEST_JAR)
	java -cp $(TARGET_JAR):$(TARGET_TEST_JAR):$(CP) $(TEST_CLASS)

tdd: $(TARGET_JAR) $(TARGET_TEST_JAR)
	ls $(MAIN_SOURCES) $(MAIN_TEST_SOURCES) Makefile | entr make test

$(TARGET_JAR): $(MAIN_SOURCES) Makefile
	rm -rf $(TARGET_CLASSES_DIR)
	mkdir -p $(TARGET_CLASSES_DIR)
	scalac -cp $(CP) -d $(TARGET_CLASSES_DIR) $(MAIN_SOURCES)
	rm -rf $(TARGET_JAR)
	jar cf $(TARGET_JAR) -C $(TARGET_CLASSES_DIR) .

$(TARGET_TEST_JAR): $(MAIN_TEST_SOURCES) $(TARGET_JAR) Makefile
	rm -rf $(TARGET_TEST_CLASSES)
	mkdir -p $(TARGET_TEST_CLASSES)
	scalac -cp $(CP):$(TARGET_JAR) -d $(TARGET_TEST_CLASSES) $(MAIN_TEST_SOURCES)
	rm -rf $(TARGET_TEST_JAR)
	jar cf $(TARGET_TEST_JAR) -C $(TARGET_TEST_CLASSES) .

run-jar: $(TARGET_JAR)
	java -cp $(TARGET_JAR):$(CP) $(MAIN_CLASS)

$(TARGET_NATIVE): $(TARGET_JAR)
	native-image $(MAIN_CLASS) $(NATIVE_OPTIONS) --class-path $(CP):$(TARGET_JAR) -H:Name=$(TARGET_NATIVE)

clean:
	rm -rf $(TARGET)/

native: $(TARGET_NATIVE)

