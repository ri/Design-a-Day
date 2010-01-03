# tags.rb

module TagsHelper

  # find all blog posts
  def posts(limit=:all, find_options=nil, &block)
    options = {
                :recursive => true,
                :blog_post => true,
                :sort_by => "created_at",
                :reverse => true}
    options.merge!(find_options) if find_options
    ::Webby::Resources.pages.find(limit, options, &block)
  end
  
  def tags_hash
    return @tags_hash if @tags_hash
    @tags_hash = {}
    posts.each do |post|
      post.tags.each do |tag|
        @tags_hash[tag] ||=0
        @tags_hash[tag] += 1
      end if post.tags
    end
    @tags_hash
  end
  
  def write_tags(page)
    output = page.tags.collect do |t|
     "<a href='/tags/#{t}.html'>#{t}</a>"
    end
    
    output.join(', ')
  end
  
  def posts_with_tag(tag, limit=:all, find_options=nil)
    posts(limit, find_options) do |post|
      post.tags && post.tags.include?(tag)
    end
  end
end

Webby::Helpers.register(TagsHelper)

# EOF
