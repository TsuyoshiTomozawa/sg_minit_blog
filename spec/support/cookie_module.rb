module CookieModule
  def cookie(key)
    page.driver.browser.rack_mock_session.cookie_jar[key]
  end

  def cookie_expires
    expires = nil

    page.driver.browser.rack_mock_session.cookie_jar.instance_variable_get(:@cookies).each do |cookie|
      if cookie.instance_variable_defined?(:@options) &&
        (options = cookie.instance_variable_get(:@options)).key?('expires')
        date = options['expires']
        expires = Time.parse(date) unless date.blank?
        break
      end
    end

    expires
  end
end