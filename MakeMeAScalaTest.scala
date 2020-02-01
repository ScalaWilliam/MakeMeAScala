import org.jsoup.Jsoup
import TestAdditions._

object TestAdditions {
  val ANSI_RESET = "\u001B[0m"
  val ANSI_BLACK = "\u001B[30m"
  val ANSI_RED = "\u001B[31m"
  val ANSI_GREEN = "\u001B[32m"
  val ANSI_YELLOW = "\u001B[33m"
  val ANSI_BLUE = "\u001B[34m"
  val ANSI_PURPLE = "\u001B[35m"
  val ANSI_CYAN = "\u001B[36m"
  val ANSI_WHITE = "\u001B[37m"

  def execute(c: => Unit): Unit = {
    try {
      c
      println(s"${ANSI_GREEN}Tests passed.${ANSI_RESET}")
    } catch {
      case e: Throwable =>
        println(s"${ANSI_RED}Tests failed:")
        e.printStackTrace()
        print(ANSI_RESET)
        System.exit(1)
    }
  }
}

object MakeMeAScalaTest extends App {
  execute {
    val doc = Jsoup.parse("<body>Test</body>")
    SecondMainScala.modify(doc)
    val gotText = doc.text()
    val expectedText = "Test Works"
    assert(
      gotText == expectedText,
      s"Expected '${expectedText}', got '${gotText}'"
    )
  }
}
