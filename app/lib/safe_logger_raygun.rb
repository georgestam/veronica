class SafeLoggerRaygun

  def self.error(raygun: true)
    message = yield
    Rails.logger.error message
    Raygun.track_exception(StandardError.new(message)) if raygun
    nil
  rescue => e
    (raise e) if test?
    nil
  end

end