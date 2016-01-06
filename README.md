# Placemat

This is the code that powers https://placem.at. Unless you want to submit changes to the application itself, you probably don't need to worry too much about this. You can just head over to [the Placemat site](https://placem.at) and start loading in some images!

If you _do_ want to submit changes, the full list of source images is in `db/seeds.rb`, and there's an example imgix config at `config/imgix.yml.example`. That should theoretically be all you need to know to get up and running. The seeds are idempotent, so feel free to run `rake db:seed` whenever they're changed.

MIT-licensed, contributions welcome. Just fork and follow standard [GithHub Flow](https://guides.github.com/introduction/flow/).
