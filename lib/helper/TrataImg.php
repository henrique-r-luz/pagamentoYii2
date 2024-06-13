<?php

namespace app\lib\helper;

use Yii;
use Exception;

class TrataImg
{
    const IMG_WIDTH = 300;
    const IMG_HEIGHT = 300;
    const MINI_WIDTH = 32; //150
    const MINI_HEIGHT = 32; //150

    public function __construct()
    {
    }

    public function getNomeArquivoOriginal($upload)
    {

        return  hash_file('sha256', $upload->tempName);
    }

    public function redimencionaImg($filePath, $newWidth, $newHeight, $nome)
    {
        if (!file_exists($filePath)) {
            throw new Exception("Arquivo não encontrado: $filePath");
        }

        // Obtém as informações da imagem
        list($width, $height, $type) = getimagesize($filePath);
        $tipo = '';

        // Cria um recurso de imagem a partir do arquivo
        switch ($type) {
            case IMAGETYPE_JPEG:
                $source = imagecreatefromjpeg($filePath);
                $tipo = 'jpg';
                break;
            case IMAGETYPE_PNG:
                $source = imagecreatefrompng($filePath);
                $tipo = 'png';
                break;
            default:
                throw new Exception("Tipo de imagem não suportado: $filePath");
        }

        // Cria um recurso de imagem vazio com as novas dimensões
        $newImage = imagecreatetruecolor($newWidth, $newHeight);

        // Mantém a transparência para PNG e GIF
        if ($type == IMAGETYPE_PNG || $type == IMAGETYPE_GIF) {
            imagealphablending($newImage, false);
            imagesavealpha($newImage, true);
            $transparent = imagecolorallocatealpha($newImage, 255, 255, 255, 127);
            imagefilledrectangle($newImage, 0, 0, $newWidth, $newHeight, $transparent);
        }

        // Redimensiona a imagem
        imagecopyresampled($newImage, $source, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
        $outputPath =   Yii::getAlias('@arquivos') . '/' . $nome . '_' . $newWidth . '.' . $tipo;
        // Salva a imagem redimensionada
        switch ($type) {
            case IMAGETYPE_JPEG:
                imagejpeg($newImage, $outputPath);
                break;
            case IMAGETYPE_PNG:
                imagepng($newImage, $outputPath);
                break;
            case IMAGETYPE_GIF:
                imagegif($newImage, $outputPath);
                break;
        }

        // Libera a memória
        imagedestroy($source);
        imagedestroy($newImage);

        return $outputPath;
    }
}
