FROM elixir:slim

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mkdir /app
WORKDIR /app

RUN apt-get update
RUN apt-get install -y git curl bash libgcc

COPY . /app

RUN mix deps.get
RUN mix test
RUN MIX_ENV=prod mix compile

CMD bash docker-entrypoint.sh
