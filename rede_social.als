open util/boolean

sig RedeSocial {}

sig Usuario {
    amizade: set Usuario,
    ativo: one Bool
}

sig Perfil {
    dono: one Usuario,
    post: set Post,
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

run {}