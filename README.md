# Simple Cloud Logging

Easy library to write log files in the cloud, watch them anywhere, and enbed the log in any website. 

Email to me if you want to collaborate, by testing this library in any Linux platform.

# Supported Operative Systems

I tested this library in the following operative systems:

- Ubuntu 18.4,
- Ubuntu 20.4,
- Windows Server 2008,
- Windows Server 2012.

## Installing

```
gem install simple_cloud_logging
```

## Writing simple log lines

```ruby
require 'simple_cloud_logging'

logger = BlackStack::BaseLogger.new(nil)

logger.logs("Declare variable... ")
@n = 5
logger.done

logger.logs("Check if #{@n.to_s}>5... ")
if @n>5
  logger.yes
else
  logger.no
end
```

```
ruby example01.rb

20191105204211:Declare variable... done
20191105204211:Check if 5>5... no
```

## Writing nested log lines

```ruby
require 'simple_cloud_logging'

logger = BlackStack::BaseLogger.new(nil)

logger.logs("Declare array of array of numbers... ")
@a = [[1,2,3],[4,5,6],[7,8,9,10]] 
logger.done

logger.logs("Process array of array elements... ")
@a.each { |b|
  logger.logs("Process array of numbers... ")
  b.each { |n|
    logger.logs("Check if #{n.to_s}>5... ")
    if n>5
      logger.yes
    else
      logger.no
    end
  }
  logger.done
}
logger.done
```

```
ruby example03.rb

20191105204410:Declare array of array of numbers... done
20191105204410:Process array of array elements...
 > Process array of numbers...
 >  > Check if 1>5... no
 >  > Check if 2>5... no
 >  > Check if 3>5... no
 > done

 > Process array of numbers...
 >  > Check if 4>5... no
 >  > Check if 5>5... no
 >  > Check if 6>5... yes
 > done

 > Process array of numbers...
 >  > Check if 7>5... yes
 >  > Check if 8>5... yes
 >  > Check if 9>5... yes
 >  > Check if 10>5... yes
 > done
done
```

## Saving Log in the Filesystem

Use the `LocalLogger` class instead `BaseLogger`.

```ruby
logger = BlackStack::LocalLogger.new('./example01.log')
```

## Dummy logging

The methods of the `DummyLogger` class just do nothing.

You can choose between `LocalLogger` or `DummyLogger` depending if you want to write log or not, dynamically.

Example: 

```ruby
class FooClass
    attr_accessor :logger

    def initialize(the_logger=nil)
        self.logger=the_logger
        self.logger = BlackStack::DummyLogger.new(nil) if self.logger.nil? # assign a dummy logger that just generate output on the screen
    end

    def do_something()
      self.logger.logs 'This log line will show up in the console only if the logger is not a DummyLogger instance...'
      self.logger.done
    end
end # class FooClass
```

## Change Log

| Version |                                                          |
|---------|----------------------------------------------------------|
| 1.1.x   | Supporting Ruby 2.2.4                                    |
| 1.2.x   | Supporting Ruby 3.1.2 (refer to https://github.com/leandrosardi/simple_cloud_logging/issues/3 for more information) |

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the last [ruby gem](https://rubygems.org/gems/simple_command_line_parser). 

## Authors

* **Leandro Daniel Sardi** - *Initial work* - [LeandroSardi](https://github.com/leandrosardi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Further Work

1. HTML/Javascript widget to connect any server via SSH and pull the log lines to a web dashboard. 
