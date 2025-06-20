![ruby](https://img.shields.io/badge/Ruby-%23CC342D?logo=ruby)
![rails](https://img.shields.io/badge/Rails-%23CC0000?logo=rubyonrails)
![psql](https://img.shields.io/badge/PostgreSQL-%234169E1?logo=postgresql&logoColor=%23ffffff)
![docker](https://img.shields.io/badge/Docker-white?logo=docker)

# Good Night - Sleep Tracking Application

API service for tracking sleep. Users can record their sleep sessions, follow other users and view following user's sleep activity

## Features

- Sleep session tracking
- Sleep duration
- User following system
- Sleep feed showing friends' sleep activity

## Prerequisites

- Ruby 3.3.3
- Rails 7.2
- PostgreSQL
- Docker (optional)

## Installation

1. Clone the repository

```bash
git clone https://github.com/swrdna/good-night.git
cd good-night
```

2. Install dependencies

```bash
bundle install
```

3. Create .env file

```bash
cp .env.example .env
```

4. Set up the database

```bash
rails db:create db:migrate db:seed
```

5. Start the server

```bash
rails s
```

## Running with Docker

1. Create .env file

```bash
cp .env.example .env
```

2. Run docker command

```bash
docker compose up
```

3. Setup database

```bash
docker compose exec api bin/rails db:create db:migrate db:seed
```

## Test

Run all test

```bash
  rspec
```

Run specific test

```bash
  rspec path/to/your/test.rb
```

## Documentation

### API

View the complete API documentation at [http://localhost:3000/docs/api](http://localhost:3000/docs/api) when the application is running.
