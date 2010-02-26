module RssHelper
  def rss_render(page)
    post_html = render(page)
    post_html.gsub!("src='/", "src='http://designaday.marshmalloo.com/")
    h(post_html)
  end
end

Webby::Helpers.register(RssHelper)