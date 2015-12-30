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
$ myapp<tab>
google bing

$ myapp goog<tab>
google

$ myapp google <tab>
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

## Integrating into `OptionParser`

Completion can parse `OptionParser` arguments and it's very easy to integrate with.

Simply use `complete_with` macro with the instance of `OptionParser`. It will automatically
parse all the flags and add them to the suggestion list.

```crystal
OptionParser.parse! do |parser|
  parser.banner = "Usage: salute [arguments]"
  parser.on("-u", "--upcase", "Upcases the sallute") { }
  parser.on("-t NAME", "--to=NAME", "Specifies the name to salute") { }
  parser.on("-h", "--help", "Show this help") { puts parser }

  # Just add this macro to the OptionParser block.
  complete_with parser
end
```

It will run as:

```
$ myapp<tab>
--help    --to      --upcase  -h        -t        -u

$ myapp --<tab>
--help --to --upcase

$ myapp --help --<tab>
--help --to --upcase
```

## Installation

*(You should add these instructions to your project's README)*

```
# Add this line to your .bashrc file.
source <(yourapp --completion)
```

# Examples

Examples are here to show you how to make it more functional.

## Branched Autocompletion

This is how you can branch options and suboptions by using `values` parameter.

```crystal
completion :action, :subaction, :subsubaction do |comp|
  comp.on(:action) do
    comp.reply ["pull", "log", "commit", "remote"]
  end

  comp.on(:subaction) do
    case comp.values[:action]
      when "pull"
        comp.reply ["origin", "upstream"]

      when "log"
        comp.reply ["HEAD", "master", "develop"]

      when "commit"
        comp.reply ["--amend", "-m", "-am"]
    end
  end

  comp.on(:subsubaction) do
    case comp.values[:subaction]
      when "origin"
        comp.reply ["origin/master", "origin/upstream", "origin/patch"]

      when "HEAD"
        comp.reply ["~1", "~2", "~3"]
    end
  end
end
```

## Remote Autocompletion

You can make a remote autocompletion using `HTTP::Client`.

```crystal
require "json"
require "http/client"

completion :repos do |comp|
  comp.on(:repos) do
    request = HTTP::Client.get "https://api.github.com/users/f/repos"
    repos = JSON.parse(request.body)
    repo_names = [] of JSON::Any
    repos.each {|repo| repo_names << repo["name"] }

    comp.reply repo_names
  end
end
```

This will run as:

```
$ mygit c<tab>
cards     coffeepad     completion    cryload     crystal-kemal-todo-list     crystal-weekly
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
