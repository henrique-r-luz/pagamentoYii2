<?php

namespace app\models\admin;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\admin\User;
use Yii;

/**
 * UserSearch represents the model behind the search form of `app\models\admin\User`.
 */
class UserSearch extends User
{

    public $pessoa_nome;
    public $plano_nome;
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'pessoa_id'], 'integer'],
            [['pessoa_nome', 'plano_nome'], 'string'],
            [['username', 'password', 'authkey'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = self::find()
            ->select([
                'user.id',
                'username',
                'pessoa.nome as pessoa_nome',
                'plano_tipo.nome as plano_nome'
            ])
            ->innerJoin('auth_assignment', 'auth_assignment.user_id::INTEGER = "user".id')
            ->innerJoin('auth_item', 'auth_item.name = auth_assignment.item_name')
            ->innerJoin('plano_tipo', 'plano_tipo.auth_item_name = auth_item.name')
            ->joinWith(['pessoa'])
            ->where(['<>', 'auth_assignment.item_name', Yii::$app->params['grupoAdmin']]);

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'pessoa_id' => $this->pessoa_id,
        ]);

        $query->andFilterWhere(['ilike', 'username', $this->username])
            ->andFilterWhere(['ilike', 'password', $this->password])
            ->andFilterWhere(['ilike', 'authkey', $this->authkey])
            ->andFilterWhere(['ilike', 'plano_tipo.nome', $this->plano_nome])
            ->andFilterWhere(['ilike', 'pessoa.nome', $this->pessoa_nome]);

        return $dataProvider;
    }
}
