<?php

namespace app\models\admin;

use Yii;
use yii\db\ActiveRecord;
use app\models\admin\permissao\AuthAssignment;

class User extends ActiveRecord implements \yii\web\IdentityInterface
{

    public $authKey;

    public static function tableName()
    {
        return 'public.user';
    }


    public function rules()
    {
        return [
            [['username', 'password'], 'required'],
            [['password', 'authkey',], 'string'],
            [['username'], 'string', 'max' => 50],
            [['username'], 'unique'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'username' => 'Username',
            'password' => 'Password',
            'authkey' => 'Authkey',
        ];
    }

    public function attributeComments()
    {
        return [
            'id' => 'ID',
            'username' => 'Username',
            'password' => 'Password',
            'authkey' => 'Authkey',
        ];
    }



    /**
     * {@inheritdoc}
     */
    public static function findIdentity($id)
    {
        return self::findOne($id);
    }

    /**
     * {@inheritdoc}
     */
    public static function findIdentityByAccessToken($token, $type = null)
    {


        return null;
    }

    /**
     * Finds user by username
     *
     * @param string $username
     * @return static|null
     */
    public static function findByUsername($username)
    {
        return self::findOne(['username' => $username]);
    }

    /**
     * {@inheritdoc}
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * {@inheritdoc}
     */
    public function getAuthKey()
    {
        return $this->authKey;
    }

    /**
     * {@inheritdoc}
     */
    public function validateAuthKey($authKey)
    {
        return $this->authKey === $authKey;
    }

    /**
     * Validates password
     *
     * @param string $password password to validate
     * @return bool if password provided is valid for current user
     */
    public function validatePassword($password)
    {
        return Yii::$app->getSecurity()->validatePassword($password, $this->password);
    }

    public function beforeSave($insert)
    {
        $this->password = Yii::$app->getSecurity()->generatePasswordHash($this->password);
        return  parent::beforeSave($insert);
    }


    public function getAuthAssignment()
    {
        return  $this->hasMany(AuthAssignment::className(), ['user_id' => 'id']);
    }

    public function getPessoa()
    {
        return  $this->hasOne(Pessoa::className(), ['id' => 'pessoa_id']);
    }
}
