[![Run tests](https://github.com/compassionprojects/socialchange/actions/workflows/test.yml/badge.svg)](https://github.com/compassionprojects/socialchange/actions/workflows/test.yml) [![Ruby Code Style](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/standardrb/standard)

# Social Change Stories

An effort to collect all social change stories where NVC is a part of. Along side, it offers a community to run and support many of these projects.

## Requirements

- ruby 3.2.2 (use [rbenv](https://github.com/rbenv/rbenv) to manage ruby versions)
- postgres 14.5

## Development

Clone the repo

```sh
bundle install
rake db:create
rake db:migrate
cp .env.development.local.template .env.development.local # replace necessary values
# also create a copy for .env.test.local
bin/dev
```

To seed the database

```sh
rake db:seed
```

We use [standardrb](https://github.com/standardrb/standard) for code linting and formatting.

Install the editor extension so that code is formatted as you type

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

## File uploads

We are using digitalocean with rails active_storage to store attachments in the cloud. Credentials can be obtained from Madhu

## RBAC

We use a simple role based authorization system with permissions. Inspired by [this article](https://ngaunhien.net/blog/simple-rbac-implementation-with-rails). This gives us fine grained control on which user can do what.

## Deployment

The app is deployed to [fly.io](https://fly.io).

To deploy:

```sh
fly deploy --build-secret SECRET_KEY_BASE=secret_value
```
