$(document).ready(function () {
    var caminho = window.location.pathname;
    let vet = caminho.split("/");
    let controler = vet.pop()

    /**
         * o vetor é formado pelas classes que marcam o menu
         * [0]=>nav
         * [1]=>collapse
         * [2]=>item menu
         * nav-item active
         */
    var menu = {

        'pessoa': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-pessoa': 'collapse-item active'
        },
        'pago': {
            'nav-pago': 'nav-item active',
            'null': 'null',
            'null': 'null'
        },
        'gratuito': {
            'nav-gratuito': 'nav-item active',
            'null': 'null',
            'null': 'null'
        }
        //nav,collapse,item
    }
    itenMenuSelecionado = menu[controler];

    for (var key in itenMenuSelecionado) {
        $('#' + key).addClass(itenMenuSelecionado[key]);

    }
});
