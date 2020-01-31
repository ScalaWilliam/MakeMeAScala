import java.net.URL

import org.jsoup._

object F extends App {
  val doc = Jsoup.parse(new URL("http://www.example.net/"), 1000)
  Lol.modify(doc)
  println(doc)
}
