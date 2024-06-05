<?php

namespace app\lib;

use Exception;

class PagamentoException extends Exception
{
    // Construtor personalizado
    public function __construct($message, $code = 0, Exception $previous = null, $customData = null)
    {
        // Certifique-se de chamar o construtor pai
        parent::__construct($message, $code, $previous);
    }
}
