# Simple Cloud Logging

Easy library to write log files in the cloud, watch them anywhere, and enbed the log in any website. 

This gem has been designed as a part of the **BlackStack** framework.

I ran tests in Windows environments only.

Email to me if you want to collaborate, by testing this library in any Linux platform.

## Installing

```
gem install simple_cloud_logging
```

## Running the tests

Here are some tests about how to use this gem properly, and how to avoid some common mistakes.

### Writing simple logs in the local host

```ruby
require 'simple_cloud_logging'

logger = BlackStack::LocalLogger.new('./example01.log')

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
C:\source>ruby example01.rb

20191105204211:Declare variable... done
20191105204211:Check if 5>5... no
```

### Writing nested logs in the local host

```ruby
require 'simple_cloud_logging'

logger = BlackStack::LocalLogger.new('./example03.log')

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
C:\source>ruby example03.rb

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


## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the last [ruby gem](https://rubygems.org/gems/simple_command_line_parser). 

## Authors

* **Leandro Daniel Sardi** - *Initial work* - [LeandroSardi](https://github.com/leandrosardi)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
