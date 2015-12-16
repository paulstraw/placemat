Rails.application.routes.draw do
  root 'home#index'

  get 'people' => 'images#person'
  get 'places' => 'images#place'
  get 'things' => 'images#thing'
  get 'ideas' => 'images#idea'
  get 'colors/:hex_code' => 'images#color'
end
