<?php

namespace app\models\admin;

use Yii;
use yii\helpers\ArrayHelper;
use app\lib\validator\CpfValidator;

/**
 * This is the model class for table "pessoa".
 *
 * @property int $id
 * @property string $nome
 * @property string $cpf
 * @property string $email
 *
 * @property Assinatura[] $assinaturas
 * @property User[] $users
 */
class Pessoa extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'pessoa';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['nome', 'cpf', 'email'], 'required'],
            [['nome', 'email'], 'string'],
            [['email'], 'email'],
            [['cpf'], CpfValidator::class],
            //[['cpf'], 'string', 'max' => 11],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
            'cpf' => 'Cpf',
            'email' => 'Email',
        ];
    }

    /**
     * Gets query for [[Assinaturas]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getAssinaturas()
    {
        return $this->hasMany(Assinatura::class, ['plano_tipo_id' => 'id']);
    }

    /**
     * Gets query for [[Users]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getUsers()
    {
        return $this->hasMany(User::class, ['pessoa_id' => 'id']);
    }


    public static function listaPessoa()
    {
        return ArrayHelper::map(self::find()->asArray()->all(), 'id', 'nome');
    }

    public function cpfFormat()
    {

        // Remove qualquer caractere que não seja número
        $cpf = preg_replace('/\D/', '', $this->cpf);

        // Verifica se o CPF tem 11 dígitos
        if (strlen($cpf) !== 11) {
            return ''; // Ou você pode lançar uma exceção ou retornar uma string vazia
        }

        // Formata o CPF
        $cpfFormatted = substr($cpf, 0, 3) . '.' .
            substr($cpf, 3, 3) . '.' .
            substr($cpf, 6, 3) . '-' .
            substr($cpf, 9, 2);

        return $cpfFormatted;
    }
}
