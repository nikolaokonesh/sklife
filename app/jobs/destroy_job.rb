class DestroyJob < ActiveJob::Base
  queue_as :default

  def perform(post)
    post.destroy
  end
end
