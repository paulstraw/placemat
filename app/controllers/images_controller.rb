class ImagesController < ApplicationController
  before_action :ensure_required_params

  def person
    img = PlaceholderImage.person.closest_to_size(**requested_size).first
    redirect_to ix_url(placeholder_image: img), status: 301
  end

  def place
    img = PlaceholderImage.place.closest_to_size(**requested_size).first
    redirect_to ix_url(placeholder_image: img), status: 301
  end

  def thing

  end

  def idea

  end

  def color

  end

private
  def ensure_required_params
    if params[:w].nil? || params[:h].nil?
      render text: 'Both the `w` and `h` params are required.', status: 422
    end
  end

  def requested_size
    { w: params[:w], h: params[:h] }
  end

  def ix_text_params
    {
      txt: params[:txt],
      txtclr: params[:txtclr] || 'fff',
      txtalign: 'middle,center',
      txtfit: 'max',
      txtsize: 2000,
      txtfont: 'Avenir Next Demi,Bold'
    }
  end

  def ix_overlay_params
    overlay_params = {
      bm: 'normal',
      blend: params[:overlay_color]
    }

    if params[:overlay_opacity].present?
      overlay_params[:balph] = params[:overlay_opacity]
    end

    overlay_params
  end

  def ix_params
    param_hash = {
      w: params[:w],
      h: params[:h],
      fm: 'auto',
      crop: 'entropy',
      fit: 'crop'
    }

    param_hash.merge! ix_text_params if params[:txt].present?
    param_hash.merge! ix_overlay_params if params[:overlay_color].present?

    param_hash
  end

  def ix_url(placeholder_image:)
    client = Imgix::Client.new({
      host: Rails.configuration.imgix['host'],
      secure_url_token: Rails.configuration.imgix['secure_url_token']
    })

    path = client.path(placeholder_image.image.path)
    path.to_url(ix_params)
  end
end
