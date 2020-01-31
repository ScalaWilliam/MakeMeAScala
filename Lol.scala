import org.jsoup.nodes.Document

object Lol {
  def modify(doc: Document): Unit = {
    doc.selectFirst("*").appendText("Works")
  }
}
