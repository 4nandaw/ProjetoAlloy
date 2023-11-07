one sig RedeSocial {
    user: set Usuario
}

sig Usuario {
    status_usuario: one Ativo + Inativo,
    amizade: set Usuario,
    autor: set Post
}

sig Perfil {
    status_perfil: one Ativo + Inativo,
    dono: set Usuario,
}

sig Post {
    perfil: one Perfil
}

one sig Ativo {}
one sig Inativo {}


fact "todo usuário está na rede social" {
    all u: Usuario | u in RedeSocial.user
}

fact "usuário sem amizade com ele mesmo" {
    no u: Usuario | u in u.amizade
}

fact "todo post tem um autor" {
    all p: Post | one u: Usuario | p in u.autor
}

fact "todo perfil tem um dono" {
    all p: Perfil | one u: Usuario | u in p.dono
}

fact "usuário pode fazer publicações no seu perfil e no de amigos" {
    all u1, u2: Usuario, p: Post | (p.perfil.dono = u1 or u1 in u2.amizade) implies p in u1.autor or p in u2.autor
}

fact "apenas usuários que são amigos podem ter post no perfil um do outro" {
    all p: Post, u1, u2: Usuario | (p.perfil.dono = u1 and u2 in u1.amizade) implies (p in u2.autor)
}

fact "usuários podem ser autores de posts em seus próprios perfis" {
    all u: Usuario, p: Post | p.perfil.dono = u implies p in u.autor
}


fact "usuário inativo = Perfis do usuário inativos" {
    all u: Usuario | (u.status_usuario = Inativo) implies (all p: Perfil | p.dono = u implies p.status_perfil = Inativo)
}

fact "postagens pertencem a um perfil ativo" {
    all p: Post | p.perfil.status_perfil = Ativo
}

run {} for 3 but exactly 3 Usuario

check todoUsuarioEstaNaRedeSocial {
    all u: Usuario | u in RedeSocial.user
}

check usuarioSemAmizadeComEleMesmo {
    no u: Usuario | u in u.amizade
}

check todoPostTemUmAutor {
    all p: Post | one u: Usuario | p in u.autor
}

check todoPerfilTemUmDono {
    all p: Perfil | one u: Usuario | u in p.dono
}

check usuariosPodemPublicarEmPerfisDeAmigos {
    all u1, u2: Usuario, p: Post | (p.perfil.dono = u1 or u1 in u2.amizade) implies p in u1.autor or p in u2.autor
}

check usuariosInativosPerfisInativos {
    all u: Usuario | (u.status_usuario = Inativo) implies (all p: Perfil | p.dono = u implies p.status_perfil = Inativo)
}

check postagensEmPerfisAtivos {
    all p: Post | p.perfil.status_perfil = Ativo
}

check usuariosPodemSerAutoresDePostsEmSeusPerfis {
    all u: Usuario, p: Post | p.perfil.dono = u implies p in u.autor
}