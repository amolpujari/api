module Api::Renderer
  extend ActiveSupport::Concern

  def render_json data
    gzip_response
    set_header_by_status_sym

    if envelope.present?
      @envelope[:data] = data
      render json: @envelope

    else
      render json: data
    end
  end

  def envelope
    @envelope ||= {}
  end

  def gzip_response
    #request.env['HTTP_ACCEPT_ENCODING'] = 'gzip'
  end

  def status
    response.status = @status ||= :ok
  end

  def status= val
    response.status = @status = envelope[:status] = val
  end

  def head status_sym
    self.status = status_sym if @status == nil || @status == :ok
    set_header_by_status_sym
    super self.status
  end

  def set_header_by_status_sym status_sym=nil
    status_sym ||= self.status
    return unless Rack::Utils::SYMBOL_TO_STATUS_CODE[status_sym]

    response.set_header "Status", "#{Rack::Utils::SYMBOL_TO_STATUS_CODE[status_sym]} #{status_sym.to_s.titleize}"
  end
end
