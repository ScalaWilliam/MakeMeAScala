import java.net.URL

import org.jsoup._

object MakeMeAScala extends App {
  val doc = Jsoup.parse(new URL("http://www.example.net/"), 1000)
  SecondMainScala.modify(doc)
  println(doc)
}
