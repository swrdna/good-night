![ruby](https://img.shields.io/badge/Ruby-%23CC342D?logo=ruby)
![rails](https://img.shields.io/badge/Rails-%23CC0000?logo=rubyonrails)
![psql](https://img.shields.io/badge/PostgreSQL-%234169E1?logo=postgresql&logoColor=%23ffffff)

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

## Installation

1. Clone the repository:

```bash
git clone https://github.com/swrdna/good-night.git
cd good-night
```

2. Install dependencies:

```bash
bundle install
```

3. Create .env file:

```bash
cp .env.example .env
```

4. Set up the database:

```bash
rails db:create
rails db:migrate
rails db:seed
```

5. Start the server:

```bash
rails server
```

## Documentation

### API

```bash
http://localhost:3000/docs/api
```
