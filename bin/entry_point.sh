#!/bin/sh
bin/wait_for_pg.sh || exit 1
bundle install
bundle exec rake assets:precompile
bundle exec rake db:migrate
bundle exec rails server --binding=0.0.0.0
