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
cp .env .env.production.local
bin/dev
```

## Tests

```sh
bin/rspec
```

or if you want to watch tests while developing

```sh
bin/guard
```

## Deployment

The app is deployed to heroku. Check with madhu@nomaddev.co in order to be invited to heroku.
