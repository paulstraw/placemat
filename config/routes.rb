Rails.application.routes.draw do
  root 'home#index'

  resources :images, only: [] do
    collection do
      get 'people' => 'images#person'
      get 'places' => 'images#place'
      get 'things' => 'images#thing'
      get 'ideas' => 'images#idea'
      get 'colors/:hex_code' => 'images#color'
    end
  end
end
