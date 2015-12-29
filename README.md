# Shell Auto-Completion Helper for Crystal

Completion is a Shell Completion Helper built on Crystal. It allows you to have completion muscle for your CLI apps.

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

# [detected program] <action> <remote> <suboption>

# You should define the pattern
completion :action, :suboption do |comp|

  # The first parameter will be one of init, build, deps, help, version
  comp.reply :action, ["init", "build", "deps", "help", "version"]

  # Second one is one of --release or --development
  comp.reply :suboption, ["--release", "--development"]
end
```

### Changing Program Name

It detects program name automatically. If you want to change it or you have problems with
detection, you should set the first argument to program name.

```crystal
require "completion"

# myprogram <action> <remote> <suboption>
completion "myprogram", :action, :remote, :suboption do |comp|
  # ...
end
```

### Last Word and Whole Line

The first parameter of the block you give has `last_word`, `line` and `fragment` parameters. So you can make
your parameters more dynamic.

```crystal
completion :action, :user, :remote do |comp|
  comp.reply :action, [:push, :pull]
  comp.reply :user, ["f", "crystal"]
  comp.reply :remote, ["github/#{comp.last_word}/", "bitbucket/#{comp.last_word}/"]
end
```

This will run as:

```
$ completion
pull  push

$ completion pull
crystal  f

$ completion pull crystal
bitbucket/crystal  github/crystal
```

## Installation

*(You should add these instructions to your project's README)*

```
yourapp --completion >> ~/.yourapp.completion.sh
echo 'source ~/.yourapp.completion.sh' >> .bash_profile
```

## TODO

 - [ ] Add ZSH Support

## Contributing

1. Fork it ( https://github.com/f/completion/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [f](https://github.com/f) Fatih Kadir Akın - creator, maintainer

> It's acutally a port of [`omelette`](http://github.com/f/omelette) package of Node.
