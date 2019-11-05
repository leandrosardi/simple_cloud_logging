require_relative '../lib/simple_cloud_logging'

# Testing the LocalLoggerFactory, getting the logger object before each log action.
# The log should keep congruent, like it happens in example03.rb

logger = BlackStack::LocalLoggerFactory.create('./example04.log')
logger.logs("Declare array of array of numbers... ")
@a = [[1,2,3],[4,5,6],[7,8,9,10]] 
BlackStack::LocalLoggerFactory.save('./example04.log', logger)
logger = BlackStack::LocalLoggerFactory.create('./example04.log')
logger.done

BlackStack::LocalLoggerFactory.save('./example04.log', logger)
logger = BlackStack::LocalLoggerFactory.create('./example04.log')
logger.logs("Process array of array elements... ")
@a.each { |b|
  BlackStack::LocalLoggerFactory.save('./example04.log', logger)
  logger = BlackStack::LocalLoggerFactory.create('./example04.log')
  logger.logs("Process array of numbers... ")
  b.each { |n|
    BlackStack::LocalLoggerFactory.save('./example04.log', logger)
    logger = BlackStack::LocalLoggerFactory.create('./example04.log')
    logger.logs("Check if #{n.to_s}>5... ")
    if n>5
      BlackStack::LocalLoggerFactory.save('./example04.log', logger)
      logger = BlackStack::LocalLoggerFactory.create('./example04.log')
      logger.yes
    else
      BlackStack::LocalLoggerFactory.save('./example04.log', logger)
      logger = BlackStack::LocalLoggerFactory.create('./example04.log')
      logger.no
    end
  }
  BlackStack::LocalLoggerFactory.save('./example04.log', logger)
  logger = BlackStack::LocalLoggerFactory.create('./example04.log')
  logger.done
}
BlackStack::LocalLoggerFactory.save('./example04.log', logger)
logger = BlackStack::LocalLoggerFactory.create('./example04.log')
logger.done
