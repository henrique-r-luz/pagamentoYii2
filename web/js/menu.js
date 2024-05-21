$(document).ready(function () {
    var caminho = window.location.pathname;
    let vet = caminho.split("/");
    let controler = vet.pop()

    /**
         * o vetor é formado pelas classes que marcam o menu
         * [0]=>nav
         * [1]=>collapse
         * [2]=>item menu
         */
    var menu = {

        'pessoa': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-pessoa': 'collapse-item active'
        }
        //nav,collapse,item
    }
    itenMenuSelecionado = menu[controler];
    for (var key in itenMenuSelecionado) {
        console.log(key + ": " + itenMenuSelecionado[key]);
        $('#' + key).addClass(itenMenuSelecionado[key]);

    }
});
