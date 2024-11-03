## Mental Health Survey API

### Setup
1. Install dependencies:
```bash
bundle install
```

2. Set up the database:
```bash
rails db:create
rails db:migrate
```

3. Run the server:
```bash
rails server
```

4. Run the test:
```bash
rails db:create RAILS_ENV=test 
rails db:migrate RAILS_ENV=test
bundle exec rspec
```

### Usage
Submit a survey: Send a POST request to `/surveys` with JSON data in the format:
```json
{
  "survey": {
    "feeling": "Good",
    "stress": 3,
    "comments": "Doing well!"
  }
}
```

### Docker Build
`docker build -t mental_health_survey_api .`

### Docker Run
`docker run -d -p 3000:3000 --name mental_health_survey_api -e SECRET_KEY_BASE=your_generated_secret_key_here mental_health_survey_api`

#### README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
