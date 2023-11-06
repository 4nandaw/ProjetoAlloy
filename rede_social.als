open util/boolean

sig RedeSocial {}

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

// fact "Um usuário pode publicar um post em seu perfil ou nos perfis de seus amigos" {
//     all u: Usuario, p: Perfil, pst: Post |
//         (pst in p.publicação and pst.autor = p.dono) or
//         (pst in p.dono.amizade.publicação and u in p.dono.amizade)
// }


run {}

check UsuariosInativosSemAmizades {
    all u: Usuario | u.ativo = False implies no u.amizade
}

check UsuarioNaoAmigoDeSiMesmo {
    all u: Usuario | not u in u.amizade
}