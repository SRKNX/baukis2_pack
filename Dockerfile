FROM ruby:3.3.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn

WORKDIR /baukis2_myapp
COPY Gemfile /baukis2_myapp/Gemfile
COPY Gemfile.lock /baukis2_myapp/Gemfile.lock
RUN bundle install
COPY . /baukis2_myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]
