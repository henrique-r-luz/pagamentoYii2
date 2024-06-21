<?php

namespace app\models\admin;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\admin\PlanoDescricao;

/**
 * PlanoDescricaoSearch represents the model behind the search form of `app\models\admin\PlanoDescricao`.
 */
class PlanoDescricaoSearch extends PlanoDescricao
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'plano_tipo_id', 'frequencia', 'tipo_frequencia', 'repeticao', 'dia_compra', 'dia_compra_proporcional'], 'integer'],
            [['back_url', 'currency_id', 'descricao_fatura'], 'safe'],
            [['plano_api_id'], 'string'],
            [['valor_plano'], 'number'],
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
    public function search($params, $plano_id = null)
    {
        $query = PlanoDescricao::find()
            ->andFilterWhere(['plano_tipo_id' => $plano_id]);

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
            'plano_tipo_id' => $this->plano_tipo_id,
            'frequencia' => $this->frequencia,
            'tipo_frequencia' => $this->tipo_frequencia,
            'repeticao' => $this->repeticao,
            'dia_compra' => $this->dia_compra,
            'dia_compra_proporcional' => $this->dia_compra_proporcional,
            'valor_plano' => $this->valor_plano,
        ]);

        $query->andFilterWhere(['ilike', 'back_url', $this->back_url])
            ->andFilterWhere(['ilike', 'currency_id', $this->currency_id])
            ->andFilterWhere(['ilike', 'plano_api_id', $this->plano_api_id])
            ->andFilterWhere(['ilike', 'descricao_fatura', $this->descricao_fatura]);

        return $dataProvider;
    }
}
