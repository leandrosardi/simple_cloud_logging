require_relative '../lib/simple_cloud_logging'

# Testing the RemoteLogger

logger = BlackStack::RemoteLogger.new(
  'example06.log',
  'https',
  '127.0.0.1',
  444,
  'E20CBAE0-A4D4-4161-8812-6D9FE67A2E47'
)

logger.logs("Declare array of array of numbers... ")
@a = [[1,2,3],[4,5,6],[7,8,9,10]] 
logger.done

logger.logs("Process array of array elements... ")
@a.each { |b|
  logger.logs("Process array of numbers... ")
  b.each { |n|
    logger.logs("Check if n>5... ")
    if n>5
      logger.yes
    else
      logger.no
    end
  }
  logger.done
}
logger.done

logger.release()
