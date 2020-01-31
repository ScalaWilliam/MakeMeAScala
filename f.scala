import java.net.URL

import org.jsoup._
import org.jsoup.nodes.Document

object Lol {
  def modify(doc: Document): Unit = {
    doc.selectFirst("*").appendText("Works")
  }
}

object F extends App {
  val doc = Jsoup.parse(new URL("http://www.example.net/"), 1000)
  Lol.modify(doc)
  println(doc)
}
