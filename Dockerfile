ARG ELIXIR_VERSION=1.14.1
ARG OTP_VERSION=25.1.2
ARG DEBIAN_VERSION=bullseye-20221004-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

RUN apt-get update -y && apt-get install -y build-essential git && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs ./
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

COPY lib lib

# Compile the release
RUN mix compile

# Generate a release
RUN mix release

#---------------------------
# prepare release image
FROM ${RUNNER_IMAGE}

EXPOSE 5001

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8

ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/remote_scan ./

USER nobody

CMD ["bin/remote_scan", "start"]
