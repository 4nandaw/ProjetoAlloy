open util/boolean

abstract sig RedeSocial {}

sig Usuario {
    amizade: set Usuario,
    ativo: one Bool
}

sig Perfil {
    dono: one Usuario,
    publicação: set Post,
    ativo: one Bool
}

sig Post {
    autor: one Usuario
}

fact "Usuário sem amizade com ele mesmo" {
    no u: Usuario | u in u.amizade
}

fact "Usuário ativo ou inativo" {
    all u: Usuario | u.ativo = True or u.ativo = False
}

fact "Perfil ativo ou inativo" {
    all p: Perfil | p.ativo = True or p.ativo = False
}

fact "Usuário inativo = Perfis do usuario inativos" {
    all u: Usuario | u.ativo = False implies all p: Perfil | p.dono = u and p.ativo = False
}

fact "Todo post está em exatamente um perfil" {
    all pst: Post | one p: Perfil | pst in p.publicação
}

fact "Usuários inativos não devem ter amizades" {
    all u: Usuario | u.ativo = False implies no u.amizade
}

fact "Postagens pertencem a um perfil ativo" {
    all pst: Post | one p: Perfil | pst in p.publicação and p.ativo = True
}

fact "Postagens associadas a usuários ativos" {
    all pst: Post | pst.autor.ativo = True
}

// pred usuarioPodeFazerPublicacao[u: Usuario, p: Perfil, pst: Post] {
//     (pst in p.publicacao and p.dono = u) or
//     (pst in u.amizade.dono.publicacao)
// }


run {}

check UsuariosInativosSemAmizades {
    all u: Usuario | u.ativo = False implies no u.amizade
}

check UsuarioNaoAmigoDeSiMesmo {
    all u: Usuario | not u in u.amizade
}

check PostagensEmPerfisAtivos {
    all pst: Post | one p: Perfil | pst in p.publicação and p.ativo = True
}

// check "Usuário pode fazer uma publicação em seu perfil ou no perfil de um amigo" {
//     all u: Usuario, p: Perfil, pst: Post |
//         usuarioPodeFazerPublicacao[u, p, p, pst]
// }