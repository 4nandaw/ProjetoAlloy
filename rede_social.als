sig RedeSocial {
    statusUser: set Usuario,
    statusPerfil: set Perfil
}

sig Usuario {
    dono: set Perfil,
    amizade: set Usuario
}

sig Perfil {
    post: set Post
}

sig Post {}

one sig Ativo, Inativo extends RedeSocial{}

fact "Usuário sem amizade com ele mesmo" {
    no u: Usuario | u in u.amizade
}

fact "Usuário ativo ou inativo" {

}

run {}







// abstract sig Usuarios {
//     dono: set Perfis,
//     amizade: set Usuarios,
//     ativo: set Status,
//     inativo: set Status
// }

// sig Perfis {
//     // dono: set Usuarios,
//     dono: set Post,
//     ativo: set Status,
//     inativo: set Status
// }

// sig Post {}

// abstract sig Status {}

// run {}
