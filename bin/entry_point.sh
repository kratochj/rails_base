#!/bin/sh
bundle install
bundle exec rake assets:precompile
bundle exec rake db:migrate
bin/wait_for_postgres.sh || exit 1
bundle exec rails server --binding=0.0.0.0
