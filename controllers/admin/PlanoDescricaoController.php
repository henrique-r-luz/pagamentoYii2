<?php

namespace app\controllers\admin;

use Throwable;
use yii\web\Controller;
use yii\filters\VerbFilter;
use app\lib\PagamentoException;
use yii\web\NotFoundHttpException;
use app\service\admin\PlanoService;
use app\models\admin\PlanoDescricao;
use app\models\admin\PlanoDescricaoSearch;

/**
 * PlanoDescricaoController implements the CRUD actions for PlanoDescricao model.
 */
class PlanoDescricaoController extends Controller
{
    /**
     * @inheritDoc
     */
    public function behaviors()
    {
        return array_merge(
            parent::behaviors(),
            [
                'verbs' => [
                    'class' => VerbFilter::className(),
                    'actions' => [
                        'delete' => ['POST'],
                    ],
                ],
            ]
        );
    }

    /**
     * Lists all PlanoDescricao models.
     *
     * @return string
     */
    public function actionIndex(int $plano_id)
    {
        $searchModel = new PlanoDescricaoSearch();
        $dataProvider = $searchModel->search($this->request->queryParams, $plano_id);
        if ($dataProvider->count == 0) {
            return $this->redirect(['create', 'plano_id' => $plano_id]);
        } else {
            return $this->render('index', [
                'searchModel' => $searchModel,
                'dataProvider' => $dataProvider,
            ]);
        }
    }

    /**
     * Displays a single PlanoDescricao model.
     * @param int $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new PlanoDescricao model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate(int $plano_id)
    {
        $model = new PlanoDescricao();
        $model->plano_tipo_id = $plano_id;
        if ($this->request->isPost && $model->load($this->request->post())) {
            $model->plano_tipo_id = $plano_id;
            try {
                $planoService = new PlanoService();
                if ($model->dia_compra_proporcional == -1) {
                    $model->dia_compra_proporcional = 0;
                }
                $planoService->criaPlano($model);
                return $this->redirect(['view', 'id' => $model->id]);
            } catch (PagamentoException $e) {
                throw new NotFoundHttpException($e->getMessage());
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
            'plano_id' => $plano_id
        ]);
    }

    /**
     * Updates an existing PlanoDescricao model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param int $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($this->request->isPost && $model->load($this->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing PlanoDescricao model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param int $id ID
     * @return \yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $planoDescricao = $this->findModel($id);
        $plano_id = $planoDescricao->plano_tipo_id;
        $planoDescricao->delete();

        return $this->redirect(['index', 'plano_id' => $plano_id]);
    }

    /**
     * Finds the PlanoDescricao model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param int $id ID
     * @return PlanoDescricao the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = PlanoDescricao::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('The requested page does not exist.');
    }
}
