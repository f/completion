# Easy Command Line Autocompletion Helper

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

# [detected program] <action> <user> <remote>

completion :action, :user, :remote do |comp|

  # When Program requested :action, reply the availables.
  comp.on(:action) do
    comp.reply ["pull", "push"]
  end

  # When Program requested :user, reply the availables.
  comp.on(:user) do
    comp.reply ["f", "sdogruyol", "askn"]
  end

  # When Program requested :remote, reply the availables with defined variables.
  comp.on(:remote) do
    comp.reply ["github/#{comp.values[:user]}", "bitbucket/#{comp.values[:user]}"]
  end

  # When all parameters finished, reply always...
  # It is `Dir.entries Dir.current` by default.
  comp.end do
    comp.reply ["--force"]
  end
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

### Defined Values, Last Word and Whole Line

The first parameter of the block you give has `last_word`, `line` and `fragment` parameters. So you can make
your parameters more dynamic.

```crystal
completion :searchengine, :url do |comp|

  comp.on(:searchengine) do
    comp.reply ["google", "bing"]
  end

  comp.on(:url) do
    comp.reply ["#{comp.values[:searchengine]}.com/search", "#{comp.values[:searchengine]}.com/images"]
  end
end
```

This will run as:

```
$ completion<tab>
google bing

$ completion goog<tab>
google

$ completion google <tab>
google.com/search google.com/images
```

### End of Arguments

You can define what to show when arguments are finished:

```crystal
completion :first do |comp|
  comp.on(:first) do
    comp.reply ["any", "option"]
  end
  comp.end do
    comp.reply ["--force", "--prune"]
  end
end
```

### Concatting Replies

You can reply more than one time. It will concat all of these.

```crystal
completion :first do |comp|
  comp.on(:first) do
    comp.reply ["any", "option"]
    comp.reply ["other", "awesome"]
    comp.reply ["options", "to", "select"]
  end
end
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
