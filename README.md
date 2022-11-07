# Social Change Stories

An effort to collect all social change stories where NVC is a part of. Along side, it offers a community to run and support many of these projects.

## Requirements

- ruby 3.1.2 (use [rbenv](https://github.com/rbenv/rbenv) to manage ruby versions)
- postgres 14.5

## Development

Clone the repo

```sh
bundle install
rake db:create
rake db:migrate
cp .env .env.development.local # replace necessary values
cp .env .env.test.local
bin/dev
```

## Tests

```sh
rails test
```

## Deployment

The app gets continuously deployed to heroku.
