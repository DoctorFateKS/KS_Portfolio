module CodeHelper
  def highlight_code(html)
    formatter = Rouge::Formatters::HTMLInline.new(Rouge::Themes::MonokaiSublime.new)

    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    doc.css("pre").each do |pre|
      code = pre.text

      lexer = Rouge::Lexer.guess_by_filename("file.rb") # ou force ruby
      highlighted = formatter.format(lexer.lex(code))

      pre.inner_html = highlighted
      pre.set_attribute("class", "code-block")
    end

    doc.to_s.html_safe
  end
end
