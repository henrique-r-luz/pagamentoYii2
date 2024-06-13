<?php

namespace app\service\perfil;

use Yii;
use Throwable;
use app\models\Arquivo;
use yii\web\UploadedFile;
use app\lib\helper\TrataImg;
use app\models\admin\Pessoa;
use app\lib\PagamentoException;

class EditaPerfilService
{

    private string $nomeArquivoOriginal = '';
    private string $pathArquivoOriginal = '';
    public function __construct(
        private Pessoa $pessoa,
        private $post,
        private TrataImg $trataImg

    ) {
    }

    public function save()
    {
        try {
            $transaction = Yii::$app->db->beginTransaction();
            $this->atualizaPessoa();
            $this->uploadImagem();
            $nomeImagem = $this->redimenciona(TrataImg::IMG_WIDTH, TrataImg::IMG_HEIGHT);
            $this->savaArquivo($nomeImagem, TrataImg::IMG_WIDTH, TrataImg::IMG_HEIGHT);
            $nomeImagem = $this->redimenciona(TrataImg::MINI_WIDTH, TrataImg::MINI_HEIGHT);
            $this->savaArquivo($nomeImagem, TrataImg::MINI_WIDTH, TrataImg::MINI_HEIGHT);
            $this->removeImagensNaoUsada();
            $transaction->commit();
        } catch (PagamentoException $e) {
            $transaction->rollBack();
            throw new PagamentoException($e->getMessage());
        } catch (Throwable $e) {
            $transaction->rollBack();
            throw new PagamentoException("Ocorreu um erro inesperado!");
        }
    }

    private function uploadImagem()
    {
        $this->pessoa->imageFile = UploadedFile::getInstance($this->pessoa, 'imageFile');

        $this->nomeArquivoOriginal = $this->trataImg->getNomeArquivoOriginal($this->pessoa->imageFile);
        if (!$this->pessoa->upload($this->nomeArquivoOriginal)) {
            throw new PagamentoException('Erro no upload da Imagem!!!');
        }
        $this->pathArquivoOriginal = Yii::getAlias('@arquivos') . '/' . $this->nomeArquivoOriginal . '.' . $this->pessoa->imageFile->extension;
    }

    private function redimenciona($largura, $altura)
    {
        $output = $this->trataImg->redimencionaImg(
            $this->pathArquivoOriginal,
            $largura,
            $altura,
            $this->nomeArquivoOriginal
        );
        $hashName = hash_file('sha256', $output);
        rename($output, (Yii::getAlias('@arquivos') . '/' . $hashName . '.' . $this->pessoa->imageFile->extension));
        return  $hashName;
    }

    private function atualizaPessoa()
    {

        unset($this->post['Pessoa']['imageFile']);
        $this->pessoa->load($this->post);
        if (!$this->pessoa->save()) {
            throw new PagamentoException('Erro ao savar Pessoa!');
        }
    }

    private function savaArquivo($nomeImagem, $largura, $altura)
    {
        $objetoData = new \DateTime;
        $data = (int) $objetoData->getTimestamp();

        $arquivo = new Arquivo();
        $arquivo->hash = $nomeImagem;
        $arquivo->model = Pessoa::class;
        $arquivo->model_id = $this->pessoa->id;
        $arquivo->path = '';
        $arquivo->mimetype = $this->pessoa->imageFile->extension;
        $arquivo->largura = $largura;
        $arquivo->altura = $altura;
        $arquivo->created_at = $data;
        if (!$arquivo->save()) {
            throw new PagamentoException('Erro ao savar aquivo!');
        }
    }

    private function removeImagensNaoUsada()
    {

        if (file_exists($this->pathArquivoOriginal)) {
            if (unlink($this->pathArquivoOriginal)) {
                return true;
            }
        }
    }
}
