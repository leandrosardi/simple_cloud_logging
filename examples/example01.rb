require_relative '../lib/simple_cloud_logging'

# Testing a simple local log.

logger = BlackStack::LocalLoggerFactory.create('./example01.log')

logger.reset()

while (true)
  logger.logs("Declare variable... ")
  @n = 5
  logger.done
  
  logger.logs("Check if #{@n.to_s}>5... ")
  if @n>5
    logger.yes
  else
    logger.no
  end

  logger.logs("Sleep 60 seconds... ")
  sleep(60)
  logger.done
end

#BlackStack::LocalLoggerFactory.save('./example01.log', logger)
#BlackStack::LocalLoggerFactory.release('./example01.log')