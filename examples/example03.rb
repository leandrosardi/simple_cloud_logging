require_relative '../lib/simple_cloud_logging'

# Testing a local log, with 2-levels of nesting.

logger = BlackStack::LocalLoggerFactory.create('./example03.log')

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
