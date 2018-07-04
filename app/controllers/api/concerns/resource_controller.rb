module Api::ResourceController
  extend ActiveSupport::Concern

  included do
    before_action :resource
  end

  def resource_class_name
    @resource_class_name ||= controller_name.classify
  end

  def resource_name
    @resource_name ||= controller_name.singularize.to_sym
  end

  def resource_class
    @resource_class || resource_class_name.constantize
  end

  def order_by
    return @order_by if @order_by
    @order_by = params[:order_by].to_s.strip
    @order_by = nil if !@order_by.present? || @order_by.length > 20 ||
      !resource_class.order_by_columns.include?(@order_by.gsub(/DESC/i,"").gsub(/ASC/i,"").strip)

    @order_by ||= "id DESC"
  end

  def select
    #TODO: to filter out api result
  end

  def deselect
    #TODO: to filter out api result
  end

  def include
    #TODO: to include associated resources
  end

  def page
    @page ||= params[:page].to_i
    @page = 1 if @page < 1 || @page > 100000
    @page
  end

  def per_page
    @per_page ||= params[:per_page].to_i
    @per_page = 10 unless [10, 20, 50].include? @per_page
    @per_page
  end

  def resource_id
    @id ||= params[:id].to_s.strip.to_i
  end

  def resource
    return if resource_id == 0
    @resource = resource_class[resource_id]
    self.status = :not_found unless @resource
    @resource
  end

  def resources
    @resources ||= resource_class.dataset.order(order_by).paginate(page, per_page)
  end

  def total_resources_count
    @total_resources_count ||= resource_class.dataset.count
  end

  def resources_count
    @resources_count ||= resources.count # TODO: avoid nested SELECT during count on filtered dataset
  end

  def index
    @envelope = {
      total: total_resources_count,
      count: resources_count,
      page: page,
      per_page: per_page,
      order_by: order_by,
    }

    render_json resources
  end

  def show
    render_json resource
  end

  def save_resource
    if @resource.save
      self.status = :created
      @id = @resource.id
      @resource

    else
      self.status = :bad
      envelope[:error] = {
        message: "#{action_name} #{resource_name} failed",
        errors: @resource.errors,
      }

      nil
    end
  end

  def create
    @resource = resource_class.new resource_params
    save_resource
    render_json resource
  end

  def update
    @resource.set resource_params
    save_resource
    render_json resource
  end

  def destroy
    head resource&.destroy ? :ok : :internal_server_error
  end

  def resource_params
    params.require(resource_name).permit(resource_class&.permitted_columns || [])
  end
end
