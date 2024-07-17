<?php

namespace app\models\admin;

use Yii;
use yii\base\Model;
use app\lib\helper\TrataImg;
use app\models\admin\Pessoa;
use yii\data\ActiveDataProvider;

/**
 * PessoaSearch represents the model behind the search form of `app\models\admin\Pessoa`.
 */
class PessoaSearch extends Pessoa
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id'], 'integer'],
            [['nome', 'cpf', 'email'], 'safe'],
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
        $query = $this->queryBase(TrataImg::MINI_WIDTH, TrataImg::MINI_HEIGHT);

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
        ]);

        $query->andFilterWhere(['ilike', 'nome', $this->nome])
            ->andFilterWhere(['ilike', 'cpf', $this->cpf])
            ->andFilterWhere(['ilike', 'email', $this->email]);

        return $dataProvider;
    }


    //->andWhere(['altura' => TrataImg::IMG_HEIGHT])
    public function perfil()
    {
        return $this->queryBase()
            ->select([
                'pessoa.id as pessoa_id',
                'pessoa.nome',
                'pessoa.cpf',
                'pessoa.email',

            ])
            ->leftJoin('user', '"user".pessoa_id = pessoa.id')
            ->andWhere(['user.id' => Yii::$app->user->id])
            ->asArray()->one();
    }


    public function perfilMini()
    {
        return null;
        /* $this->queryBase(TrataImg::MINI_WIDTH, TrataImg::MINI_HEIGHT)
            ->select([

                'arquivo.hash',
                'arquivo.mimetype',
                'arquivo.path'
            ])
            ->leftJoin('user', '"user".pessoa_id = pessoa.id')
            ->andWhere(['user.id' => Yii::$app->user->id])
            ->orderBy(['created_at' => \SORT_DESC])
            ->asArray()->one();*/
    }



    private function queryBase()
    {
        return  Pessoa::find();

        //->andWhere(['arquivo.model' => Pessoa::class]);
    }
}
