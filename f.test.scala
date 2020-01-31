import org.jsoup.Jsoup

object FTest extends App {
  val doc = Jsoup.parse("<body>Test</body>")
  Lol.modify(doc)
  val gotText = doc.text()
  val expectedText = "Test Works"
  assert(gotText == expectedText, s"Expected '${expectedText}', got '${gotText}'")
}