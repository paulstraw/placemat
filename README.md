# placem.at

Probably neat placeholder stuff. Right now, I'm just dumping some thoughts in here.

All HTTPS, because internet.

Should there be an `/images/colors` endpoint, or something like `overlay_color` + `overlay_opacity` params instead? I'm leaning towards the overlay params + maybe a shortcut URL at `/images/colors/:hex_code`

`rake db:seed_fu`

http://localhost:3000/images/places?w=200&h=300&txt=hellotherefriend&overlay_color=ff0000&overlay_opacity=40
http://localhost:3000/images/places?w=600&h=300&txt=hellotherefriend&overlay_color=007777&overlay_opacity=42

## Image Endpoints

### /images/people

Example URL: https://placem.at/images/people?w=200&h=300

### /images/places

Example URL: https://placem.at/images/places?txt_size=20&text=what

### /images/things

Example URL: https://placem.at/images/things?txt_colorbg_color=ff0000&txt_color=0000ff&txt=hmm

### /images/ideas

Example URL: https://placem.at/images/ideas?txt=helloworld

## Text Endpoints

Honestly, I'm not sure if I want to do this part, at least for launch. It'd be quite a bit of work to get all the text needed to build up n-grams for these.

https://placem.at/ipsums/seinfeld?mode=words&count=20
https://placem.at/ipsums/star_trek?mode=sentences&count=5
https://placem.at/ipsums/shakespeare?mode=paragraphs&count=2


```
rails g model placeholder_image native_width:integer native_height:integer image_category:integer
rails g paperclip placeholder_image image
```

``` ruby
class PlaceholderImage < ActiveRecord::Base
  enum image_category: { people: 0, places: 1, things: 2, ideas: 3 }

  scope :person, -> { where(image_category: PlaceholderImage.image_categories[:people]) }
  scope :place, -> { where(image_category: PlaceholderImage.image_categories[:places]) }
  scope :thing, -> { where(image_category: PlaceholderImage.image_categories[:things]) }
  scope :idea, -> { where(image_category: PlaceholderImage.image_categories[:ideas]) }

  def self.closest_to_size(w:, h:)
    order('ABS(native_width - ?) + ABS(native_height - ?)', w, h).limit(1)
  end
end

PlaceholderImage.person.closest_to_size(w: 200, h: 300)
```
