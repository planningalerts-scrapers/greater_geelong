
This is a scraper that runs on [Morph](https://morph.io). To get started [see the documentation](https://morph.io/documentation)

Add any issues to https://github.com/planningalerts-scrapers/issues/issues

## To run the scraper

```
bundle exec ruby scraper.rb
```

Set `MORPH_AUSTRALIAN_PROXY` to the url for an Australian proxy

### Expected output

```
Saving 1339/2023...
Saving 872/2025...
(etc)
Saving 391/2023/A...
Saving 548/2025...
```

Execution time ~ 4 seconds.

## To run style and coding checks

```
bundle exec rubocop
```

## To check for security updates

```
gem install bundler-audit
bundle-audit
```
