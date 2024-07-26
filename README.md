# Simple Cloud Logging

Simple and Colorful log library for Ruby.

(screenshot here)

**Outline**

1. [Installation](#1-installation)
2. [Getting Started](#2-getting-started)

## 1. Installation

```
gem install simple_cloud_logging
```

## 2. Getting Started

Start an close a log line.

```ruby
require 'simple_cloud_logging'

l = BlackStack::LocalLogger.new("examples.log")

l.logs "Calculate 1+1... "
n = 1 + 1
l.done
```

```
2024-07-26 15:27:04: Calculate 1+1... done
```

## 3. Closing Lines with Details

```ruby
l.logs "Calculate 1+1... "
n = 1 + 1
l.done(details: n)
```

```
2024-07-26 15:27:04: Calculate 1+1... done (2)
```

## 4. Starting and Closing in One Line

```ruby
require 'simple_cloud_logging'

l = BlackStack::LocalLogger.new("examples.log")

l.log "Example 1:"
l.logs "Calculate 1+1... "
n = 1 + 1
l.done
```

```
2024-07-26 15:27:04: Example 1:
2024-07-26 15:27:04: Calculate 1+1... done
```

## 5. Writing Blank Lines

```ruby
require 'simple_cloud_logging'

l = BlackStack::LocalLogger.new("examples.log")

l.blank_line
l.logs "Calculate 1+1... "
n = 1 + 1
l.done
```

```
2024-07-26 15:27:04: 
2024-07-26 15:27:04: Calculate 1+1... done
```

## 6. Writing Errors

```ruby
l.logs "Calculate 4/0... "
begin
    n = 4/0
    l.done(details: n)
rescue => e
    l.error(e)
end
```

```
2024-07-26 15:27:04: Calculate 4/0... error: divided by 0
examples.rb:32:in `/'
examples.rb:32:in `<main>'.
```

## 7. Abbreviations

You can close a line with other `yes` or `no`.

```ruby
i = 0
while i < 6
    l.logs "Is #{i}==3?... "
    if i == 3
        l.yes
    else
        l.no
    end
    i += 1
end
```

You can close a line with other `ok` or `skip` too.


```ruby
i = 0
while i < 6
    l.logs "Only even numbers: #{i}... "
    if i % 2 == 0
        l.ok
    else
        l.skip
    end
    i += 1
end
```

## 8. Skipping With Details

```ruby
i = 0
while i < 6
    l.logs "#{i}... "
    if i % 2 == 0
        l.ok
    else
        l.skip(details: 'it is an odd number')
    end
    i += 1
end
```

----------------------------------------------------------------------

## 5. Dummy Logging

The methods of the `DummyLogger` class just do nothing.

You can choose between `LocalLogger` or `DummyLogger` depending if you want to write log or not, dynamically.

`DummyLogger` is used to pass or not a logger to a function, for deep-nested logging.

**Example:** 

```ruby
class FooClass
    attr_accessor :logger

    def initialize(the_logger=nil)
        self.logger=the_logger
        self.logger = BlackStack::DummyLogger.new(nil) if self.logger.nil? # assign a dummy logger that just generate output on the screen
    end

    def do_something()
      self.logger.logs 'This log line will show up in the console only if the logger is not a DummyLogger instance...'
      # do something here
      self.logger.done
    end
end # class FooClass
```

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the last [ruby gem](https://rubygems.org/gems/simple_command_line_parser). 

## Authors

* **Leandro Daniel Sardi** - *Initial work* - [LeandroSardi](https://github.com/leandrosardi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Further Work

1. HTML/Javascript widget to connect any server via SSH and pull the log lines to a web dashboard. 
