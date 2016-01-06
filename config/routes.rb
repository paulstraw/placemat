Rails.application.routes.draw do
  root 'home#index'

  get ':category' => 'images#from_category'
  # get 'colors/:hex_code' => 'images#color'
end
