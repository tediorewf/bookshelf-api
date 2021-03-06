FROM ruby:2.7.4-alpine

WORKDIR /usr/src/app

RUN apk add --no-cache build-base postgresql-dev tzdata && \
    bundle config set without development test

COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

ENV RAILS_ENV production

CMD ["rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000

LABEL org.opencontainers.image.description="Server-side application for Bookshelf project."
