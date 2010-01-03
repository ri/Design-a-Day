Rake.application.instance_eval do
  @tasks.delete('create:post')
end

namespace :create do
  desc "Generate a post"
  task :post do
    title = ENV["TITLE"] || abort(%Q{Run command like: 'webby create:post TITLE="My post title"})
    page  = title.strip.downcase.gsub(/[^a-z0-9_-]+/,'-') + ".haml"
    num   = Dir['content/posts/*'].sort.last.scan(/posts\/(\d+)-.*/).to_s.to_i rescue 0
    num   = '%03d' % (num + 1)
    
    page = "posts/#{num}-#{page}"
    
    Webby::Builder.create(page,
      :from => "#{Webby.site.template_dir}/post.erb",
      :locals => {:title => title, :day => num})
  end
end
