# Use the official Ruby image as the base image
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  yarn

# Set the working directory
WORKDIR /myapp

# Install Rails dependencies (Gemfile & Gemfile.lock)
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Copy the rest of your application code
COPY . /myapp

# Expose the default Rails port
EXPOSE 3000

# Run Rails server when the container starts
CMD ["rails", "server", "-b", "0.0.0.0"]