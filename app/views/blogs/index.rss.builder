xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Journal — Kevin Saison"
    xml.description "Notes techniques et retours d'expérience sur Ruby on Rails."
    xml.link blogs_url
    xml.language "fr"

    @blogs.each do |article|
      xml.item do
        xml.title article.title
        xml.description truncate(strip_tags(article.content), length: 300)
        xml.pubDate article.created_at.to_fs(:rfc822)
        xml.link blog_url(article)
        xml.guid blog_url(article)
      end
    end
  end
end
