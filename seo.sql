create database seo;

\c seo;

create sequence categorie_seq;
create table categorie(
    id serial primary key,
    idcategorie varchar(15) not null default 'CAT'||nextval('categorie_seq'),
    nomcategorie varchar(40)
);
insert into categorie(nomcategorie) values
('Jeux'),('Loisirs'),('Educatif'),('Science'),('Litterature'),('Mode')
;


create sequence sary_seq;
create table sary(
    id serial primary key,
    idsary varchar(15) not null default 'SAR'||nextval('sary_seq'),
    link varchar(100) not null,
    base_64 text not null
);


create sequence article_seq;
create table article(
    id serial primary key,
    idarticle varchar(15) not null default 'ART'||nextval('article_seq'),
    titre varchar(100) not null,
    idcategorie integer not null,
    resumee text not null,
    contenu text not null,
    idsary integer default null,
    FOREIGN KEY (id) REFERENCES sary(id),
    FOREIGN KEY (idcategorie) references categorie(id)
);

create sequence admin_seq;
create table administrateur(
    id serial primary key,
    idadmin varchar(15) not null default 'ADM'||nextval('admin_seq'),
    identifiant varchar(40) not null,
    mdp varchar(50) not null
);
insert into administrateur values(default,default,'admin@gmail.com','d033e22ae348aeb5660fc2140aec35850c4da997');

create table categorie_article(
    idarticle integer not null,
    idcategorie integer not null,
    FOREIGN KEY (idarticle) REFERENCES article(id),
    FOREIGN KEY (idcategorie) REFERENCES categorie(id)
);


create view article_info as
select article.*,nomcategorie,link,base_64 from article left join categorie on categorie.id=article.idcategorie
left join sary on sary.id=article.idsary;
create view article_sary as
select article.*,link,base_64 from article
left join sary on sary.id=article.idsary
;


PGPASSWORD=8sfyoS2QHjrqm3lbejwi psql -h containers-us-west-149.railway.app -U postgres -p 5996 -d railway
