# Crepe: Shell Completion Engine for Crystal

Crepe is a Shell Completion Engine built on Crystal. It allows you to have completion muscle for your CLI apps.

It's acutally a port of [`omelette`](http://github.com/f/omelette) package of Node.

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  completion:
    github: f/completion
```


## Usage


```crystal
require "completion"

complete = completion "githubber <module> <command> <suboption>"

complete.on :module do
  reply "push", "pull"
end

complete.on :command do |module|
  reply "origin", "upstream"
end

complete.on :suboption do |module, command|
  reply "master", "develop"
end
```


## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/[your-github-name]/completion/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [f](https://github.com/f) Fatih Kadir Akın - creator, maintainer
