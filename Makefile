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
TEST_CLASS := FTest
MAIN_SOURCE_FILE := f.scala
MAIN_TEST_FILE := f.test.scala
NATIVE_OPTIONS := \
--no-fallback \
--no-server \
--initialize-at-build-time \

TARGET_CLASSES_DIR := target/classes
TARGET_TEST_CLASSES := target/test-classes
TARGET_NATIVE := target/f
TARGET_JAR := target/f.jar
TARGET_TEST_JAR := target/f.test.jar

CP := $(shell coursier fetch $(DEPS) | tr '\n' ':')

run: $(TARGET_JAR)
	java -cp $(TARGET_JAR):$(CP) $(MAIN_CLASS)

test: $(TARGET_JAR) $(TARGET_TEST_JAR)
	java -cp $(TARGET_JAR):$(TARGET_TEST_JAR):$(CP) $(TEST_CLASS)

$(TARGET_CLASSES_DIR)/$(MAIN_CLASS).class: $(MAIN_SOURCE_FILE) Makefile
	rm -rf $(TARGET_CLASSES_DIR)
	mkdir -p $(TARGET_CLASSES_DIR)
	scalac -cp $(CP) -d $(TARGET_CLASSES_DIR) $(MAIN_SOURCE_FILE)

$(TARGET_JAR): $(TARGET_CLASSES_DIR)/$(MAIN_CLASS).class
	rm -rf $(TARGET_JAR)
	jar cf $(TARGET_JAR) -C $(TARGET_CLASSES_DIR) .

$(TARGET_TEST_CLASSES)/$(TEST_CLASS).class: $(MAIN_TEST_FILE) $(TARGET_JAR)
	rm -rf $(TARGET_TEST_CLASSES)
	mkdir -p $(TARGET_TEST_CLASSES)
	scalac -cp $(CP):$(TARGET_JAR) -d $(TARGET_TEST_CLASSES) $(MAIN_TEST_FILE)

$(TARGET_TEST_JAR): $(TARGET_TEST_CLASSES)/$(TEST_CLASS).class Makefile
	rm -rf $(TARGET_TEST_JAR)
	jar cf $(TARGET_TEST_JAR) -C $(TARGET_TEST_CLASSES) .

run-jar: $(TARGET_JAR)
	java -cp $(TARGET_JAR):$(CP) $(MAIN_CLASS)

$(TARGET_NATIVE): $(TARGET_JAR)
	native-image $(MAIN_CLASS) $(NATIVE_OPTIONS) --class-path $(CP):$(TARGET_JAR) -H:Name=$(TARGET_NATIVE)

clean:
	rm -rf target/

native: $(TARGET_NATIVE)

