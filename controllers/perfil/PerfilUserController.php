<?php

namespace app\controllers\perfil;

use Yii;
use yii\web\Controller;
use app\lib\helper\TrataImg;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;
use app\models\admin\Assinatura;
use app\models\admin\PessoaSearch;
use yii\web\NotFoundHttpException;
use app\models\admin\AssinaturaSearch;
use app\models\admin\PlanoTipo;
use app\models\Arquivo;
use app\service\perfil\EditaPerfilService;
use app\service\perfil\CancelaAssinaturaService;

class PerfilUserController extends Controller
{
    public function actionIndex()
    {

        if (Yii::$app->user->isGuest) {
            throw new NotFoundHttpException('O usuário não está logado');
        }
        $pessoaSearch = new PessoaSearch();
        $model = $pessoaSearch->perfil();
        if (empty($model)) {
            throw new NotFoundHttpException('Dados do perfil não foram encontrados!!');
        }

        $searchModel = new AssinaturaSearch();
        $dataProvider = $searchModel->search($this->request->queryParams, Yii::$app->user->id, true);

        return $this->render('index', [
            'model' => $model,
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider
        ]);
    }


    public function actionEditar()
    {
        if (Yii::$app->user->isGuest) {
            throw new NotFoundHttpException('O usuário não está logado');
        }
        $user = Yii::$app->user->identity;
        /** @var Pessoa */
        $pessoa = $user->pessoa;
        if (Yii::$app->request->isPost) {

            try {
                $trataImg = new TrataImg();
                $editaPerfilService = new EditaPerfilService($pessoa, $this->request->post(), $trataImg);
                $editaPerfilService->save();
                $this->redirect(['index']);
            } catch (PagamentoException $e) {
                throw new NotFoundHttpException($e->getMessage());
            }
        }
        return $this->render('editar', [

            'model' => $pessoa
        ]);
    }

    public function actionImagemPerfil()
    {

        $arquivo = Arquivo::getArquivo(TrataImg::IMG_WIDTH, TrataImg::IMG_HEIGHT);
        if (empty($arquivo)) {
            header('Content-Type: png');
            return  readfile(Yii::getAlias('img') . '/img.png');
        }

        $path  = ($arquivo['path'] == '') ? '' : '/' . $arquivo['path'];
        $url = $path . '/' . $arquivo['hash'] . '.' . $arquivo['mimetype'];

        $imagePath = Yii::getAlias('@arquivos') . $url;
        return $this->getImagem($imagePath);
    }


    public function actionImagemPerfilMini()
    {
        $arquivo = Arquivo::getArquivo(TrataImg::MINI_WIDTH, TrataImg::MINI_HEIGHT);
        if (empty($arquivo)) {
            header('Content-Type: png');
            return  readfile(Yii::getAlias('img') . '/mini_img.png');
        }
        $path  = ($arquivo['path'] == '') ? '' : '/' . $arquivo['path'];
        $url = $path . '/' . $arquivo['hash'] . '.' . $arquivo['mimetype'];
        $imagePath = Yii::getAlias('@arquivos') . $url;
        return $this->getImagem($imagePath);
    }


    private function getImagem($imagePath)
    {

        if (file_exists($imagePath)) {

            // Obtém as informações sobre o arquivo
            $imageInfo = getimagesize($imagePath);
            $imageType = $imageInfo['mime'];

            // Define os cabeçalhos apropriados
            header('Content-Type: ' . $imageType);
            header('Content-Length: ' . filesize($imagePath));

            // Lê o arquivo e envia o conteúdo
            return  readfile($imagePath);
        } else {
            // Retorna um erro 404 se o arquivo não for encontrado
            throw new NotFoundHttpException('Imagen dp perfil não encontrada');
        }
    }

    public function actionCancelar(int $id)
    {
        try {
            $assinatura = Assinatura::findOne($id);;
            if ($assinatura->planoTipo->nome == PlanoTipo::PLANO_PADRAO) {
                Yii::$app->session->setFlash('danger', 'Plano Padrão não pode ser cancelado!');
                return $this->redirect(['/perfil/perfil-user']);
            }
            $cancelaAssinaturaService = new CancelaAssinaturaService($assinatura);
            $cancelaAssinaturaService->cancela();
            Yii::$app->session->setFlash('success', 'Cancelamento realizado com sucesso');
        } catch (PagamentoException $e) {
            Yii::$app->session->setFlash('danger', 'Erro ao cancelar assinatura : ' . $e->getMessage() . '!!');
        } finally {
            return  $this->redirect(['/perfil/perfil-user']);
        }
    }
}
