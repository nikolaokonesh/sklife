class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = <<-HTML
    <div class="flex nav-link mr-1 unread-notifications">
      <svg version="1.1" id="Bell" xmlns="http://www.w3.org/2000/svg" x="0px" y="0px"
      viewbox="0 0 20 20" enable-background="new 0 0 20 20" xmlns:xlink="http://www.w3.org/1999/xlink"
      xml:space="preserve" class="svg-white">
      <path d="M14.65,8.512c-2.28-4.907-3.466-6.771-7.191-6.693C6.132,1.846,6.45,0.857,5.438,1.232C4.428,1.607,5.295,2.156,4.261,3.005
        c-2.902,2.383-2.635,4.587-1.289,9.84c0.567,2.213-1.367,2.321-0.602,4.465c0.559,1.564,4.679,2.219,9.025,0.607
        c4.347-1.613,7.086-4.814,6.527-6.378C17.157,9.394,15.611,10.578,14.65,8.512z M10.924,16.595c-3.882,1.44-7.072,0.594-7.207,0.217
        c-0.232-0.65,1.253-2.816,5.691-4.463c4.438-1.647,6.915-1.036,7.174-0.311C16.735,12.467,14.807,15.154,10.924,16.595z
         M9.676,13.101c-2.029,0.753-3.439,1.614-4.353,2.389c0.643,0.584,1.847,0.726,3.046,0.281c1.527-0.565,2.466-1.866,2.095-2.904
        c-0.005-0.013-0.011-0.023-0.016-0.036C10.197,12.913,9.94,13.002,9.676,13.101z"></path>
      </svg>
    </div>
    HTML
    ActionCable.server.broadcast "notifications:#{notification.user.id}", html: html
  end
end
