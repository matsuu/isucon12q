<?php

declare(strict_types=1);

namespace SQLTrace;

use Doctrine\DBAL\Driver as DriverInterface;
use Doctrine\DBAL\Driver\Middleware as MiddlewareInterface;
use Psr\Log\LoggerInterface;

/**
 * @see {\Doctrine\DBAL\Logging\Middleware}
 */
final class Middleware implements MiddlewareInterface
{
    public function __construct(private LoggerInterface $logger)
    {
    }

    public function wrap(DriverInterface $driver): DriverInterface
    {
        return new Driver($driver, $this->logger);
    }
}
