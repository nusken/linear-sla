# Setup

## Requisites

+ Redis

## How to run

### Configure Linear API Key

```
EDITOR=nano rails credentials:edit
```

Note: To modify the credentials, `master.key` must be provided separately

### Install all dependencies
```
bundle install
```

### Setup DB
```
rails db:setup
```

### Run server and sidekiq
```
./bin/dev

bundle exec sidekiq
```

# Supported SLA rules

Currently it supports filtering issues by the following criteria:

+ By Status (such as Todo, Doing, etc)

+ By Label

+ By Priority (such as Medium, High, Urgent, etc)

Statuses and Labels are loaded dynamically from the Linear

+ Inactive Duration is the period since the last time it was updated. For example, 2 means we are looking at issues which were updated before 2h ago.

For matching issues, we could perform the following actions:

+ Add a comment, with the comment content is specified via UI

+ Update issue status

+ Update issue priority


## How to support new criteria or actions?

### New criteria
+ Define how the new filter in the `generate_filter_object` method inside the `LinearApi` class

### New action

+ Define the mutation in the `Linear` module

+ Add corresponding method in `LinearApi` class

+ Update logic in `CheckSlaBreachesJob` to handle the corresponding action

### Web UI
When adding new filter or action, we also need to update the UI accordingly if we want users to be able to add these rules**