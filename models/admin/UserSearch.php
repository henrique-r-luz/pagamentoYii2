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
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'pessoa_id'], 'integer'],
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
        $query = User::find()
            ->innerJoin('auth_assignment', 'auth_assignment.user_id::INTEGER = "user".id')
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
            ->andFilterWhere(['ilike', 'authkey', $this->authkey]);

        return $dataProvider;
    }
}
