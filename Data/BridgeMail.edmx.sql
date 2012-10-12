
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 09/18/2012 22:12:10
-- Generated from EDMX file: E:\dev\Web\DotNetNuke\620b\DesktopModules\BridgeMail\Data\BridgeMail.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [dnn620b];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[GoupMail_Person]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GoupMail_Person];
GO
IF OBJECT_ID(N'[dbo].[GroupMail_Groups]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupMail_Groups];
GO
IF OBJECT_ID(N'[dbo].[GroupMail_History]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupMail_History];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'GoupMail_Person'
CREATE TABLE [dbo].[GoupMail_Person] (
    [ItemID] int IDENTITY(1,1) NOT NULL,
    [ModuleID] int  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [CreatedByUser] int  NOT NULL,
    [FirstName] nvarchar(150)  NULL,
    [LastName] nvarchar(150)  NULL,
    [EMail] nvarchar(150)  NULL,
    [Comment] nvarchar(max)  NULL,
    [Phone] nvarchar(20)  NULL,
    [City] nvarchar(50)  NULL,
    [State] nvarchar(4)  NULL,
    [CellPhone] nvarchar(20)  NULL,
    [ACBLNumber] nvarchar(12)  NULL
);
GO

-- Creating table 'GroupMail_Groups'
CREATE TABLE [dbo].[GroupMail_Groups] (
    [ItemID] int IDENTITY(1,1) NOT NULL,
    [ModuleID] int  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [CreatedByUser] int  NOT NULL,
    [GroupName] nvarchar(150)  NOT NULL
);
GO

-- Creating table 'GroupMail_History'
CREATE TABLE [dbo].[GroupMail_History] (
    [itemID] int IDENTITY(1,1) NOT NULL,
    [ModuleID] int  NOT NULL,
    [CreatedDate] datetime  NOT NULL,
    [CreatedByUser] int  NOT NULL,
    [GroupID] int  NOT NULL,
    [Title] nvarchar(max)  NULL,
    [Message] nvarchar(max)  NULL,
    [SentTo] nvarchar(max)  NULL,
    [GroupMail_GroupsItemID] int  NOT NULL
);
GO

-- Creating table 'GroupMail_GroupsGoupMail_Person'
CREATE TABLE [dbo].[GroupMail_GroupsGoupMail_Person] (
    [Lists_ItemID] int  NOT NULL,
    [People_ItemID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [ItemID] in table 'GoupMail_Person'
ALTER TABLE [dbo].[GoupMail_Person]
ADD CONSTRAINT [PK_GoupMail_Person]
    PRIMARY KEY CLUSTERED ([ItemID] ASC);
GO

-- Creating primary key on [ItemID] in table 'GroupMail_Groups'
ALTER TABLE [dbo].[GroupMail_Groups]
ADD CONSTRAINT [PK_GroupMail_Groups]
    PRIMARY KEY CLUSTERED ([ItemID] ASC);
GO

-- Creating primary key on [itemID] in table 'GroupMail_History'
ALTER TABLE [dbo].[GroupMail_History]
ADD CONSTRAINT [PK_GroupMail_History]
    PRIMARY KEY CLUSTERED ([itemID] ASC);
GO

-- Creating primary key on [Lists_ItemID], [People_ItemID] in table 'GroupMail_GroupsGoupMail_Person'
ALTER TABLE [dbo].[GroupMail_GroupsGoupMail_Person]
ADD CONSTRAINT [PK_GroupMail_GroupsGoupMail_Person]
    PRIMARY KEY NONCLUSTERED ([Lists_ItemID], [People_ItemID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Lists_ItemID] in table 'GroupMail_GroupsGoupMail_Person'
ALTER TABLE [dbo].[GroupMail_GroupsGoupMail_Person]
ADD CONSTRAINT [FK_GroupMail_GroupsGoupMail_Person_GroupMail_Groups]
    FOREIGN KEY ([Lists_ItemID])
    REFERENCES [dbo].[GroupMail_Groups]
        ([ItemID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [People_ItemID] in table 'GroupMail_GroupsGoupMail_Person'
ALTER TABLE [dbo].[GroupMail_GroupsGoupMail_Person]
ADD CONSTRAINT [FK_GroupMail_GroupsGoupMail_Person_GoupMail_Person]
    FOREIGN KEY ([People_ItemID])
    REFERENCES [dbo].[GoupMail_Person]
        ([ItemID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupMail_GroupsGoupMail_Person_GoupMail_Person'
CREATE INDEX [IX_FK_GroupMail_GroupsGoupMail_Person_GoupMail_Person]
ON [dbo].[GroupMail_GroupsGoupMail_Person]
    ([People_ItemID]);
GO

-- Creating foreign key on [GroupMail_GroupsItemID] in table 'GroupMail_History'
ALTER TABLE [dbo].[GroupMail_History]
ADD CONSTRAINT [FK_GroupMail_GroupsGroupMail_History]
    FOREIGN KEY ([GroupMail_GroupsItemID])
    REFERENCES [dbo].[GroupMail_Groups]
        ([ItemID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_GroupMail_GroupsGroupMail_History'
CREATE INDEX [IX_FK_GroupMail_GroupsGroupMail_History]
ON [dbo].[GroupMail_History]
    ([GroupMail_GroupsItemID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------