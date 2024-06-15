<?php

namespace app\models\admin;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\admin\PlanoTipo;

/**
 * PlanoTipoSearch represents the model behind the search form of `app\models\admin\PlanoTipo`.
 */
class PlanoTipoSearch extends PlanoTipo
{

    const SIM = 1;
    const NAO = -1;
    public $plano_descricao_id;
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'plano_descricao_id'], 'integer'],
            [['nome', 'auth_item_name'], 'string'],
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
                'plano_tipo.id',
                'plano_tipo.nome',
                'plano_tipo.auth_item_name',
                'plano_descricao.id as plano_descricao_id'
            ])
            ->joinWith(['planoDescricaos']);

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        //echo $query->createCommand()->getRawSql();
        //exit();

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'id' => $this->id,
        ]);

        $query->andFilterWhere(['ilike', 'nome', $this->nome]);
        $query->andFilterWhere(['ilike', 'auth_item_name', $this->nome]);

        if ($this->plano_descricao_id == self::SIM) {
            $query->andWhere(['is not', 'plano_descricao.id', null]);
        }
        if ($this->plano_descricao_id == self::NAO) {
            $query->andWhere(['is', 'plano_descricao.id', null]);
        }

        return $dataProvider;
    }
}
