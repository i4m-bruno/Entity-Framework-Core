IF OBJECT_ID(N'__EFMigrationsHistory') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [actor] (
    [actor_id] int NOT NULL IDENTITY,
    [first_name] varchar(45) NOT NULL,
    [last_name] varchar(45) NOT NULL,
    [last_update] datetime NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_actor] PRIMARY KEY ([actor_id])
);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20170928150159_Inicial', N'2.0.0-rtm-26452');

GO

CREATE TABLE [film] (
    [film_id] int NOT NULL IDENTITY,
    [release_year] varchar(4) NULL,
    [description] text NULL,
    [length] smallint NOT NULL,
    [title] varchar(255) NOT NULL,
    [last_update] datetime NOT NULL,
    CONSTRAINT [PK_film] PRIMARY KEY ([film_id])
);

GO

CREATE TABLE [film_actor] (
    [film_id] int NOT NULL,
    [actor_id] int NOT NULL,
    [last_update] datetime NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_film_actor] PRIMARY KEY ([film_id], [actor_id]),
    CONSTRAINT [FK_film_actor_actor_actor_id] FOREIGN KEY ([actor_id]) REFERENCES [actor] ([actor_id]) ON DELETE CASCADE,
    CONSTRAINT [FK_film_actor_film_film_id] FOREIGN KEY ([film_id]) REFERENCES [film] ([film_id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_film_actor_actor_id] ON [film_actor] ([actor_id]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171002175648_Filmes', N'2.0.0-rtm-26452');

GO

ALTER TABLE [film] ADD [language_id] tinyint NOT NULL DEFAULT 0;

GO

ALTER TABLE [film] ADD [original_language_id] tinyint NULL;

GO

CREATE TABLE [language] (
    [language_id] tinyint NOT NULL,
    [name] char(20) NOT NULL,
    [last_update] datetime NOT NULL DEFAULT (getdate()),
    CONSTRAINT [PK_language] PRIMARY KEY ([language_id])
);

GO

CREATE INDEX [IX_film_language_id] ON [film] ([language_id]);

GO

CREATE INDEX [IX_film_original_language_id] ON [film] ([original_language_id]);

GO

ALTER TABLE [film] ADD CONSTRAINT [FK_film_language_language_id] FOREIGN KEY ([language_id]) REFERENCES [language] ([language_id]) ON DELETE CASCADE;

GO

ALTER TABLE [film] ADD CONSTRAINT [FK_film_language_original_language_id] FOREIGN KEY ([original_language_id]) REFERENCES [language] ([language_id]) ON DELETE NO ACTION;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171002194922_Idioma', N'2.0.0-rtm-26452');

GO

CREATE INDEX [idx_actor_last_name] ON [actor] ([last_name]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171003210825_IndiceAtorUltimoNome', N'2.0.0-rtm-26452');

GO

ALTER TABLE [actor] ADD CONSTRAINT [AK_actor_first_name_last_name] UNIQUE ([first_name], [last_name]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171003211112_UniqueAtorPrimeiroUltimoNome', N'2.0.0-rtm-26452');

GO

ALTER TABLE [film] ADD [rating] varchar(10) NULL;

GO

ALTER TABLE [dbo].[film]
                ADD CONSTRAINT [check_rating] CHECK (
                    [rating]='NC-17' OR 
                    [rating]='R' OR 
                    [rating]='PG-13' OR 
                    [rating]='PG' OR 
                    [rating]='G')

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20171003220317_Classificacao', N'2.0.0-rtm-26452');

GO

