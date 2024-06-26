<?php

namespace app\models\admin;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\admin\Assinatura;

/**
 * AssinaturaSearch represents the model behind the search form of `app\models\admin\Assinatura`.
 */
class AssinaturaSearch extends Assinatura
{

    public $user_nome;
    public $plano_nome;
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id'], 'integer'],
            [['user_nome', 'plano_nome'], 'string'],
            [['data_inicio', 'data_fim'], 'safe'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'plano_nome' => 'Plano',
            'user_nome' => 'Usuário',
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
    public function search($params, $user_id = null, $order = false)
    {
        $query = self::find()
            ->select([
                'assinatura.id',
                'plano_tipo.nome as plano_nome',
                'user.username as user_nome',
                'assinatura.data_inicio',
                'assinatura.data_fim',
                'id_api_assinatura',
                'assinatura.status'
            ])
            ->joinWith(['planoTipo', 'user']);

        if ($order == true) {
            $query->orderBy(['assinatura.created_at' => \SORT_DESC]);
        }


        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $dataProvider->sort->attributes['plano_nome'] = [
            'asc' => ['plano_tipo.nome' => SORT_ASC],
            'desc' => ['plano_tipo.nome' => SORT_DESC],
        ];

        $dataProvider->sort->attributes['user_nome'] = [
            'asc' => ['user.username' => SORT_ASC],
            'desc' => ['user.username' => SORT_DESC],
        ];

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
            'data_inicio' => $this->data_inicio,
            'data_fim' => $this->data_fim,
        ]);


        $query->andFilterWhere(['user_id' => $user_id]);
        $query->andFilterWhere(['ilike', 'plano_tipo.nome', $this->plano_nome])
            ->andFilterWhere(['ilike', 'user.username', $this->user_nome]);


        return $dataProvider;
    }
}
