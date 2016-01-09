class ImagesController < ApplicationController
  # def color

  # end

  def from_category
    placeholder_image = get_placeholder_image
    redirect_to ix_url(placeholder_image: placeholder_image), status: 301
  end

private
  def get_placeholder_image
    categorized_images = PlaceholderImage.send(params[:category].to_sym)

    if params[:random] == '1' || (params[:w].nil? && params[:h].nil?)
      categorized_images.order_by_rand.first
    elsif params[:random].present?
      random_seed = Digest::MD5.hexdigest(params[:random])[0..3].to_i(16)

      categorized_images.order_by_rand(seed: random_seed).first
    else
      categorized_images.closest_to_size(**requested_size).first
    end

  end

  def text
    if params[:txt] == '0' || (params[:w].nil? && params[:h].nil?)
      ''
    elsif params[:txt]
      params[:txt]
    else
      "#{params[:w]}×#{params[:h]}"
    end
  end

  def requested_size
    { w: params[:w], h: params[:h] }
  end

  def ix_text_params
    {
      txt: text,
      txtclr: params[:txtclr] || 'BFFF',
      txtalign: 'middle,center',
      txtfit: 'max',
      txtsize: 42,
      txtfont: 'Avenir Next Demi,Bold'
    }
  end

  def ix_mark_params
    # TODO currently adding any special characters (even stuff like `.`)
    # confuses either the ~text endpoint, or imgix-rb
    color = params[:txtclr] || '7FFF'
    mark_url = client.path('/~text').to_url({
      # txt: 'http://placem.at',
      txtalign: 'right',
      # txtfont: 'Avenir Next Demi,Bold',
      txtclr: color,
      txtsize: 12
    })

    {
      mark: mark_url,
      markalign: 'bottom,right'
    }
  end

  def ix_overlay_params
    {
      bm: params[:overlay_blend] || 'multiply',
      blend: params[:overlay_color] || 'ACACAC'
    }
  end

  def ix_params
    param_hash = {
      w: params[:w],
      h: params[:h],
      fm: 'auto',
      crop: 'faces,entropy',
      fit: 'crop'
    }

    param_hash.merge! ix_text_params
    param_hash.merge! ix_overlay_params

    param_hash
  end

  def client
    @client ||= Imgix::Client.new({
      host: ENV['ix_host'],
      secure_url_token: ENV['ix_secure_url_token']
    })
  end

  def ix_url(placeholder_image:)
    path = client.path(placeholder_image.image.path)
    path.to_url(ix_params)
  end
end
