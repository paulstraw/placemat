place_images = [
  'https://images.unsplash.com/photo-1445754574409-bcd715e18017?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=cb38e88e8e9fd55ebd5b2d9f0b5c5926',
  'https://images.unsplash.com/photo-1442405740009-7b57cca9d316?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=8ad0e3579b66e754924530ded828521b',
  'https://images.unsplash.com/photo-1433832597046-4f10e10ac764?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=bdc08ca394410d95482816cdb957f078',
  'https://images.unsplash.com/photo-1430651717504-ebb9e3e6795e?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=2f05d41e59b349313fdf09c041a768af',
  'https://images.unsplash.com/photo-1428190318100-06790c8b2e5a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=0933721d1ecb217d4864800508317574',
  'https://images.unsplash.com/photo-1422504090664-c57eba84293f?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=301d0b3f6bf00431f999424312afaf7d',
  'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&s=21ce0991c656c3dc50f55b4ecc81d30d'
]

place_images.each do |url|
  PlaceholderImage.create_or_update_by_url_and_category! url, :places
end
