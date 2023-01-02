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

To seed the database

```sh
rake db:seed
```

## Tests

```sh
bin/rspec
```

or if you want to watch tests while developing

```sh
bin/guard
```

## Search

We are using jsonb fields to store translated content. We use [mobility](https://github.com/shioyama/mobility) to make this happen. Along side this we use [mobility-ransack](https://github.com/shioyama/mobility-ransack) plugin to perform text search. We use gin expression indexes on jsonb fields to perform text search. If we add more languages, we must make sure to add a new index for the introduced language. See [this migration](/db/migrate/20221207193729_add_indexes_to_stories.rb) to check how it was done for currently supporting languages.

Ideally we'd like to use to_tsvector FTS but there needs to be some work done on upstream. See #23 for more info.

## RBAC

We use a simple role based authorization system with permissions. Inspired by [this article](https://ngaunhien.net/blog/simple-rbac-implementation-with-rails). This gives us fine grained control on which user can do what.

## Deployment

The app is deployed to heroku. Check with madhu@nomaddev.co in order to be invited to heroku.
