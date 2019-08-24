module Article::Blog
  def self.use_relative_model_naming?
    true
  end
  def self.table_name_prefix
    'blog_'
  end
end
