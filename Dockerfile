ARG ALPINE_VERSION=3.12.0

FROM hexpm/elixir:1.11.0-erlang-23.1.1-alpine-3.12.0 as builder

# Replace `your_app` with your otp application name.
ENV APP_NAME=wave \
  MIX_ENV=prod

WORKDIR /opt/app

# Add required packages for building the application.
# If you're not running Phoenix LiveView
# remove the `nodejs` and `npm` lines.
RUN apk update && \
  apk upgrade --no-cache && \
  apk add --no-cache git \
  nodejs \
  npm --update \
  build-base && \
  mix local.rebar --force && \
  mix local.hex --force

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

# If you're not running Phoenix LiveView
# remove these next two instructions.
COPY ./assets ./assets

RUN cd assets && npm install

COPY . .

# Remove `phx.digest` if you're not using LiveView
RUN mix do compile, phx.digest, release

# Final build stage.
FROM alpine:${ALPINE_VERSION}

RUN apk update && \
  apk add --no-cache bash

WORKDIR /opt/app

RUN addgroup -S app
RUN adduser -S app -G app

COPY --from=builder /opt/app/_build/prod/rel .
RUN chown -R app:app /opt/app
USER app

# Run the pending migrations for your application then start it.
# Replace `your_app` and `YourApp` with the otp app name and module respectively.
CMD trap 'exit' INT; \
  ./wave/bin/wave eval "Wave.Release.migrate" && \
  ./wave/bin/wave start