## Mental Health Survey API

### Docker Setup

1. Build
```bash
docker build -t mental_health_survey_api .
```

2. Run
```bash
docker run -d -p 3000:3000 --name mental_health_survey_api -e SECRET_KEY_BASE=your_generated_secret_key_here mental_health_survey_api
```

### Dev Setup
1. Install dependencies:
```bash
bundle install
```

2. Set up the database:
```bash
rails db:migrate
```

3. Run the server:
```bash
rails server
```

4. Run the test:
```bash
rails db:migrate RAILS_ENV=test
bundle exec rspec
```

### Usage
To submit a survey, send a POST request to `http://localhost:3000/surveys` with JSON data in this format:
```json
{
  "survey": {
    "feeling": "Good",
    "stress": 3,
    "comments": "Doing well!"
  }
}
```
To read the analysis, send a GET request to `http://localhost:3000/analysis`. It returns a JSON data in this format:
```json
{
  "count": 0,
  "average": 0
}
```
