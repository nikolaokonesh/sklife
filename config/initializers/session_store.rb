Rails.application.config.session_store :cookie_store, key: Rails.application.credentials.dig(:session_store), domain: :all, tld_length: 2
