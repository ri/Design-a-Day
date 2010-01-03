require 'lib/tags.rb'
include TagsHelper
namespace :tags do
  desc "auto generate all tags page"
  task :generate do
    ::Webby.load_files
    tags_hash.keys.each do |tag|
      dir = Webby.site.tags_dir
      page = File.join(dir, File.basename(tag)) + ".haml"
      page = Webby::Builder.create(page, :from => "#{Webby.site.template_dir}/tag.erb",
                 :locals => {:tag => tag, :directory => dir})
    end
  end
  
  desc "remove all tags page"
  task :remove do
    rm_rf Webby.site.content_dir + "/" + Webby.site.tags_dir
  end
  
  desc "regenerate all tags page"
  task :regenerate => [:remove, :generate]
end
