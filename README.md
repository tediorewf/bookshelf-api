[![Application Workflow](https://github.com/tediore-wf/bookshelf-api/actions/workflows/application.yaml/badge.svg)](https://github.com/tediore-wf/bookshelf-api/actions/workflows/application.yaml)

# Bookshelf API

Backend for Bookshelf project

## Prerequisites

Before start development process you have to install these tools on your machine:

- [Git](https://git-scm.com/downloads)
- [Ruby 2.7.4](https://www.ruby-lang.org/en/news/2021/07/07/ruby-2-7-4-released/)
- [Bundler 2.2.30](https://rubygems.org/gems/bundler/versions/2.2.30)

To ensure you have them installed you may run these commands:

```bash
git --version
ruby --version
bundler --version
```

## Development

#### 1. Clone the repository

```bash
git clone https://github.com/tediore-wf/bookshelf-api.git
```

#### 2. Move to the project directory

```bash
cd bookshelf-api
```

#### 3. Install dependencies

```bash
bundle install
```

#### 4. Prepare the database

```bash
bundle exec rake db:prepare
```

#### 5. Run Rails server

```bash
bundle exec rails s
```
