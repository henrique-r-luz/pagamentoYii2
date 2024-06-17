<?php

namespace app\lib\behaviorController;

use yii\base\Behavior;
use yii\web\Controller;

class DisableCsrfBehavior extends Behavior
{
    public $actions = [];

    public function events()
    {
        return [
            Controller::EVENT_BEFORE_ACTION => 'beforeAction',
        ];
    }

    public function beforeAction($event)
    {
        $action = $event->action->id;
        if (in_array($action, $this->actions)) {
            $this->owner->enableCsrfValidation = false;
        }
    }
}
