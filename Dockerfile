# === Base Stage ===
FROM ruby:3.2-alpine AS base
WORKDIR /app
RUN apk add --no-cache build-base postgresql-dev tzdata

# === Dependencies Stage ===
FROM base AS deps
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# === Development Stage ===
FROM deps AS dev
COPY . .
CMD ["rails", "server", "-b", "0.0.0.0"]

# === Staging Stage ===
FROM deps AS stg
COPY . .
RUN RAILS_ENV=staging bundle exec rake assets:precompile
CMD ["rails", "server", "-e", "staging", "-b", "0.0.0.0"]

# === Production Stage ===
FROM deps AS prod
COPY . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]
