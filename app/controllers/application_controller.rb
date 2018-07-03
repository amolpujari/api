class ApplicationController < ActionController::API
  before_action :skip_chrome_head_requests

  def skip_chrome_head_requests
    head :no_content if request.env["REQUEST_METHOD"]=="HEAD"
  end
end
