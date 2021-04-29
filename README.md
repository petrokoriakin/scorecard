# scorecard

Dev team wants to track who did the most work each week for bragging rights. Using the GitHub API, create a maintainable API or interface that exposes a scorecard that shows the top contributors on a single GitHub repository in the past week. Assume the team uses GitHub flow and that the team only cares about pull request related events.

Score guidelines:
- Pull Request: 12 points
- Pull Request Comment: 1 point
- Pull Request Review: 3 points

## Software versions
- ruby 2.7.2
- rails 6.1.3

## Local installation

Clone the repo, run the bundler

```
git clone git@github.com:petrokoriakin/scorecard.git
cd scorecard
bundle install
```

Run dev server

```
rails s
```

## Samples

root endpoint shows results for [sample repo with few PRs, reviews and comments](https://github.com/petrokoriakin/scorecard-sample/pulls?q=is%3Apr+is%3Aclosed)
```
curl localhost:3000
```
Scorecard for some repo from last week
```
curl localhost:3000/github/petrokoriakin/scorecard-sample/scores

curl localhost:3000/github/rails/rails/scores
```

Scorecard for some repo contributor from last week
```
curl localhost:3000/github/petrokoriakin/scorecard-sample/scores/petrokoriakin

curl localhost:3000/github/rubocop/rubocop/scores/koic
```