require_relative '../lib/simple_cloud_logging'

# Testing a local log, with 1-level nesting.

logger = BlackStack::LocalLoggerFactory.create('./example02.log')

logger.logs("Declare array of numbers... ")
@a = [1,2,3,4,5,6,7,8,9,10] 
logger.done

logger.logs("Process array elements... ")
@a.each { |n|
  logger.logs("Check if n>5... ")
  if n>5
    logger.yes
  else
    logger.no
  end  
}
logger.done
