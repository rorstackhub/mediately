# Mediately

## Dependencies
* Ruby version : 2.5.1
* Rails Version : 5.2.0
* Redis Version : 5.0.8

## Configuration

```gem install bundler && bundle install```

## Environment Setup
##### Set environment variables
* REDIS_URL
* GITHUB_USERNAME
* GITHUB_PASSWORD
* GITHUB_REPO
* LOKALISE_API_KEY
* LOKALISE_PROJECT_ID
* GITHUB_WEBHOOK_SECRET

##### Specify spec folder location
Update `TOOL_SPEC_FOLDER` variable in constant.rb

## Set up webhook on GitHub
1. Navigate to your GitHub repository and select Settings.
2. Select Add webhook under Webhooks.
3. Paste the GitHub Webhook URL from ngrok to the Payload URL.
4. And on the same page, select Let me select individual events.
5. Select Pull request.

## Run the rails server

```rails s```

## Start sidekiq

```sidekiq```
