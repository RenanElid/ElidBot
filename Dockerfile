FROM elixir:1.18-alpine


RUN apk add --no-cache build-base git ca-certificates && update-ca-certificates

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix local.hex --force && mix local.rebar --force

RUN mix deps.get

COPY . .

RUN mix compile

CMD ["mix", "run", "--no-halt"]
