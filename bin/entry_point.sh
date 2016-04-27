#!/bin/sh
bundle install
bundle exec rake assets:precompile
bundle exec rake db:migrate
bundle exec rails server --binding=0.0.0.0
