FROM ruby:2.3-slim

RUN apt-get update && apt-get install -y \
  nodejs \
  postgresql-client sqlite3 libpq-dev libsqlite3-dev \
  libxml2-dev libxslt1-dev build-essential patch \
  ruby-dev zlib1g-dev liblzma-dev libgmp-dev \
   --no-install-recommends && rm -rf /var/lib/apt/lists/*

# see http://guides.rubyonrails.org/command_line.html#rails-dbconsole
# RUN apt-get update && apt-get install -y postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y libxml2-dev libxslt1-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*
# RUN apt-get update && apt-get install -y build-essential patch ruby-dev zlib1g-dev liblzma-dev libgmp-dev libsqlite3-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV RAILS_VERSION '5.0.0.beta3'

RUN gem install rails --version "$RAILS_VERSION"

RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle config build.nokogiri --use-system-libraries \
 && bundle config build.therubyracer --use-system-libraries \
 && bundle config build.libv8 --with-system-v8 \
 && bundle install

ADD . /app

ENV SECRET_KEY_BASE '6c6fcfd14e507cdb59aed33a7e5f3bc356d992167bbf7e1aa55b7f0cdf4769b54fb8e7eb8de0debdffbd22bdac050808bb1664b56730253477b20bdd622f275b'
ENV RAILS_ENV 'production'


EXPOSE 3000

# CMD ["bundle", "exec", "unicorn", "-p", "8080", "-c", "./config/unicorn.rb"]
ENTRYPOINT "bin/entry_point.sh"

