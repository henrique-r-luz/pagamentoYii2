$(document).ready(function () {
    var caminho = window.location.pathname;


    //let vet = caminho.split("/");
    //let controler = vet.pop()

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
        },
        '/admin/plano-tipo': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-plano-tipo': 'collapse-item active'
        },
        '/admin/forma-pagamento': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-forma-pagamento': 'collapse-item active'
        },
        '/admin/user': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-user': 'collapse-item active'
        },
        '/admin/assinatura': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-assinatura': 'collapse-item active'
        },
        '/admin/plano-descricao': {
            'nav-admin': 'nav-item active',
            'adm': 'collapse show',
            'a-plano-tipo': 'collapse-item active'
        }
        //nav,collapse,item
    }

    for (var key in menu) {
        if (caminho.search(key) != -1) {
            for (var attributos in menu[key]) {
                $('#' + attributos).addClass(menu[key][attributos]);

            }
            return;
        }
    }

});
