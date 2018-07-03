Rails.application.routes.draw do
  def api_resources(res)
    resources res, :only => [:index, :show, :create, :update, :destroy]
  end

  namespace :api, :defaults => { format: :json } do
    namespace :v1 do
      api_resources :resources
    end
  end
end
