<?php

namespace app\controllers\perfil;

use Yii;
use yii\web\Controller;
use app\lib\helper\TrataImg;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;
use app\models\admin\PessoaSearch;
use yii\web\NotFoundHttpException;
use app\service\perfil\EditaPerfilService;

class PerfilUserController extends Controller
{
    public function actionIndex()
    {
        Yii::$app->session->setFlash('danger', 'Teste');
        if (Yii::$app->user->isGuest) {
            throw new NotFoundHttpException('O usuário não está logado');
        }
        $pessoaSearch = new PessoaSearch();
        $model = $pessoaSearch->perfil();
        if (empty($model)) {
            throw new NotFoundHttpException('Dados do perfil não foram encontrados!!');
        }
        $path  = ($model['path'] == '') ? '' : '/' . $model['path'];
        $model['img'] = $path . '/' . $model['hash'] . '.' . $model['mimetype'];
        return $this->render('index', [
            'model' => $model,
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

    public function actionImagemPerfil($url)
    {
        $imagePath = Yii::getAlias('@arquivos') . $url;
        return $this->getImagem($imagePath);
    }


    public function actionImagemPerfilMini()
    {
        $pessoa = new PessoaSearch();
        $model = $pessoa->perfilMini();
        $path  = ($model['path'] == '') ? '' : '/' . $model['path'];
        $url = $path . '/' . $model['hash'] . '.' . $model['mimetype'];
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
}
