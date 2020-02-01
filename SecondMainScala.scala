import org.jsoup.nodes.Document

object SecondMainScala {
  def modify(doc: Document): Unit = {
    doc.selectFirst("*").appendText("Works")
  }
}
