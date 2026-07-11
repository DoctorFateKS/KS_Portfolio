# app/helpers/blogs_helper.rb
#
# Remplace highlight_code(@blog.content) par render_markdown(@blog.content).

require "redcarpet"
require "rouge"

module BlogsHelper
  class MarkdownRenderer < Redcarpet::Render::HTML
    def block_code(code, language)
      lexer = Rouge::Lexer.find_fancy(language, code) || Rouge::Lexers::PlainText
      formatter = Rouge::Formatters::HTML.new
      highlighted = formatter.format(lexer.lex(code))
      lang_label = language.presence || lexer.tag

      <<~HTML
        <div class="code-block">
          <span class="code-block__lang">#{lang_label}</span>
          <pre class="code-block__pre"><code class="code-highlight">#{highlighted}</code></pre>
        </div>
      HTML
    end
  end

  def render_markdown(content)
    return "" if content.blank?

    # Isole entièrement chaque équation (délimiteurs ET contenu) avant
    # de passer le texte à Markdown : \( \) et \[ \] seraient sinon
    # interprétés comme des parenthèses/crochets échappés, et ^ ou _
    # à l'intérieur d'une équation seraient lus comme de la syntaxe
    # Markdown (exposant, italique...) au lieu de LaTeX. On les
    # remplace par des jetons opaques, on laisse Markdown faire son
    # travail sur le reste, puis on restitue les équations telles
    # quelles pour que KaTeX les reçoive intactes côté navigateur.
    math_expressions = []
    protected_content = content.gsub(/\\\[.*?\\\]|\\\(.*?\\\)/m) do |match|
      math_expressions << match
      "@@MATH#{math_expressions.size - 1}@@"
    end

    renderer = MarkdownRenderer.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(
      renderer,
      fenced_code_blocks: true,
      tables: true,
      autolink: true,
      strikethrough: true,
      superscript: true,
      no_intra_emphasis: true
    )

    html = markdown.render(protected_content)

    math_expressions.each_with_index do |expression, index|
      html = html.gsub("@@MATH#{index}@@", expression)
    end

    html.html_safe
  end
end
