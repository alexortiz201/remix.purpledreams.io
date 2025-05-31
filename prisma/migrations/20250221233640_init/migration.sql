-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "name" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Note" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "ownerId" TEXT NOT NULL,
    CONSTRAINT "Note_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "NoteImage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "altText" TEXT,
    "objectKey" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "noteId" TEXT NOT NULL,
    CONSTRAINT "NoteImage_noteId_fkey" FOREIGN KEY ("noteId") REFERENCES "Note" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "UserImage" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "altText" TEXT,
    "objectKey" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "UserImage_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Password" (
    "hash" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Password_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "expirationDate" DATETIME NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Permission" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "action" TEXT NOT NULL,
    "entity" TEXT NOT NULL,
    "access" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Role" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL DEFAULT '',
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Verification" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "type" TEXT NOT NULL,
    "target" TEXT NOT NULL,
    "secret" TEXT NOT NULL,
    "algorithm" TEXT NOT NULL,
    "digits" INTEGER NOT NULL,
    "period" INTEGER NOT NULL,
    "charSet" TEXT NOT NULL,
    "expiresAt" DATETIME
);

-- CreateTable
CREATE TABLE "Connection" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "providerName" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "userId" TEXT NOT NULL,
    CONSTRAINT "Connection_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Passkey" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "aaguid" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "publicKey" BLOB NOT NULL,
    "userId" TEXT NOT NULL,
    "webauthnUserId" TEXT NOT NULL,
    "counter" BIGINT NOT NULL,
    "deviceType" TEXT NOT NULL,
    "backedUp" BOOLEAN NOT NULL,
    "transports" TEXT,
    CONSTRAINT "Passkey_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Site" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "_RolePermissions" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_RolePermissions_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RolePermissions_B_fkey" FOREIGN KEY ("B") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_UserRoles" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_UserRoles_A_fkey" FOREIGN KEY ("A") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_UserRoles_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_RoleSites" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_RoleSites_A_fkey" FOREIGN KEY ("A") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RoleSites_B_fkey" FOREIGN KEY ("B") REFERENCES "Site" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_UserSites" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_UserSites_A_fkey" FOREIGN KEY ("A") REFERENCES "Site" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_UserSites_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE INDEX "Note_ownerId_idx" ON "Note"("ownerId");

-- CreateIndex
CREATE INDEX "Note_ownerId_updatedAt_idx" ON "Note"("ownerId", "updatedAt");

-- CreateIndex
CREATE INDEX "NoteImage_noteId_idx" ON "NoteImage"("noteId");

-- CreateIndex
CREATE UNIQUE INDEX "UserImage_userId_key" ON "UserImage"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Password_userId_key" ON "Password"("userId");

-- CreateIndex
CREATE INDEX "Session_userId_idx" ON "Session"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Permission_action_entity_access_key" ON "Permission"("action", "entity", "access");

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Verification_target_type_key" ON "Verification"("target", "type");

-- CreateIndex
CREATE UNIQUE INDEX "Connection_providerName_providerId_key" ON "Connection"("providerName", "providerId");

-- CreateIndex
CREATE INDEX "Passkey_userId_idx" ON "Passkey"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "Site_name_key" ON "Site"("name");

-- CreateIndex
CREATE UNIQUE INDEX "_RolePermissions_AB_unique" ON "_RolePermissions"("A", "B");
CREATE INDEX "_RolePermissions_B_index" ON "_RolePermissions"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_UserRoles_AB_unique" ON "_UserRoles"("A", "B");
CREATE INDEX "_UserRoles_B_index" ON "_UserRoles"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RoleSites_AB_unique" ON "_RoleSites"("A", "B");
CREATE INDEX "_RoleSites_B_index" ON "_RoleSites"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_UserSites_AB_unique" ON "_UserSites"("A", "B");
CREATE INDEX "_UserSites_B_index" ON "_UserSites"("B");

--------------------------------- Manual Seeding --------------------------
-- Hey there, Kent here! This is how you can reliably seed your database with
-- some data. You edit the migration.sql file and that will handle it for you.

-- The user Roles and Permissions are seeded here.
-- If you'd like to customise roles and permissions, you can edit and add the code below to your `prisma/seed.ts` file.
-- Seed your development database with `npx prisma db seed`
-- Create a sql dump of your database with `sqlite3 prisma/data.db .dump > seed.sql`
-- Replace the SQL below with your new Roles & Permissions related SQL from `seed.sql`

-- console.time('🌐 Created sites...')
-- const siteList = [
-- 	{ name: 'purpledreams', description: 'purpledreams.io - Admin site' },
-- 	{ name: 'salonexpo', description: 'salonexpo.studio - The Salon Expo site' },
-- ]

-- for (const { name, description } of siteList) {
-- 	await prisma.site.create({
-- 		select: { id: true },
-- 		data: {
-- 			name,
-- 			description,
-- 		},
-- 	})
-- }
-- console.timeEnd('🌐 Created sites...')

-- console.time('🔑 Created permissions...')
-- const entities = ['user', 'note', 'site', 'role', 'permission', 'connection'];
-- const actions = ['create', 'read', 'update', 'delete']
-- const accesses = ['own', 'site', 'any'] as const

-- let permissionsToCreate = []
-- for (const entity of entities) {
-- 	for (const action of actions) {
-- 		for (const access of accesses) {
-- 			permissionsToCreate.push({ entity, action, access })
-- 		}
-- 	}
-- }
-- await prisma.permission.createMany({ data: permissionsToCreate })
-- console.timeEnd('🔑 Created permissions...')

-- console.time('👑 Created roles...')
-- await prisma.role.create({
-- 	data: {
-- 		name: 'super-admin',
-- 		permissions: {
-- 			connect: await prisma.permission.findMany({
-- 				select: { id: true },
-- 				where: { access: 'any' },
-- 			}),
-- 		}
-- 	},
-- })
-- await prisma.role.create({
-- 	data: {
-- 		name: 'admin',
-- 		permissions: {
-- 			connect: await prisma.permission.findMany({
-- 				select: { id: true },
-- 				where: { access: 'site' },
-- 			}),
-- 		},
-- 		sites: {
-- 			connect: { id: defaultSite.id }
-- 		}
-- 	},
-- })
-- await prisma.role.create({
-- 	data: {
-- 		name: 'user',
-- 		permissions: {
-- 			connect: await prisma.permission.findMany({
-- 				select: { id: true },
-- 				where: { access: 'own' },
-- 			}),
-- 		},
-- 		sites: {
-- 			connect: { id: defaultSite.id }
-- 		}
-- 	},
-- })
-- console.timeEnd('👑 Created roles...')

INSERT INTO Site VALUES('cmbcatfyd00009nyk1c331xvg','purpledreams','purpledreams.io - Admin site',1748699979780,1748699979780);
INSERT INTO Site VALUES('cmbcatfym00019nykymp8igar','salonexpo','salonexpo.studio - The Salon Expo site',1748699979790,1748699979790);

INSERT INTO Permission VALUES('cm83vfane00009nszybczy0t1','create','user','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00019nszdykqhncn','create','user','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00029nszunzehh89','create','user','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00039nszvtdd8jv7','read','user','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00049nsz4324533e','read','user','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00059nszlj1jb70m','read','user','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00069nszzowfy1qy','update','user','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00079nsz5c881d9m','update','user','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00089nszro9arnqk','update','user','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00099nsz7jmdlf9o','delete','user','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000a9nszkux4qy2t','delete','user','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000b9nszvwp9qzz5','delete','user','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000c9nszsrvc2xdm','create','note','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000d9nszphevc4p3','create','note','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000e9nszsmaznlf3','create','note','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000f9nsz6s6i1trj','read','note','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000g9nszb6rtzdhj','read','note','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000h9nszoehewoqv','read','note','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000i9nszp1mu3ee4','update','note','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000j9nszedo93kk0','update','note','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000k9nsz39hvebmj','update','note','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000l9nszw2fa1b04','delete','note','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000m9nszd6rn225v','delete','note','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000n9nszaf5g44c7','delete','note','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000o9nszdf6lzc1l','create','site','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000p9nsz8h4lbua1','create','site','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000q9nszuvx1rx7q','create','site','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000r9nszg01pu2og','read','site','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000s9nszxajis7cu','read','site','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000t9nszlb6g170b','read','site','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000u9nsz8g8u0mpa','update','site','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000v9nszd2z23br5','update','site','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000w9nszes14bdrq','update','site','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000x9nszhffenynq','delete','site','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000y9nszmiz9oobd','delete','site','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane000z9nsz1undl1tp','delete','site','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00109nszo2f0r62n','create','role','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00119nszlshrv13k','create','role','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00129nszjrishwz3','create','role','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00139nsz90qvk56t','read','role','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00149nsz65brgr02','read','role','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00159nsz8zn0m9t6','read','role','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00169nsz6bylp4x2','update','role','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00179nsz1a191sqh','update','role','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00189nsz1myg7xp8','update','role','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane00199nszytzpebfa','delete','role','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001a9nszstqy1y8h','delete','role','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001b9nszns5ibgpg','delete','role','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001c9nszrmjm250b','create','permission','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001d9nszymjn0niz','create','permission','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001e9nszgnhol6gp','create','permission','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001f9nszsy11xwqp','read','permission','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001g9nszn6nd1kya','read','permission','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001h9nszjaluqhvv','read','permission','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001i9nszd77ij24d','update','permission','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001j9nsz76xeavhu','update','permission','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001k9nszpz55ttfn','update','permission','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001l9nsztmkhu9fg','delete','permission','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfane001m9nszx645xrnk','delete','permission','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001n9nsz3kykav2h','delete','permission','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001o9nsz0c76sr5e','create','connection','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001p9nszpa0mu8ym','create','connection','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001q9nszrfcxa0ck','create','connection','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001r9nszbznu90qy','read','connection','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001s9nsz3zctmngz','read','connection','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001t9nszg5ulloya','read','connection','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001u9nszv3lh5ddy','update','connection','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001v9nsz9xor8eo2','update','connection','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001w9nsz3w18e6mu','update','connection','any','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001x9nszh39lqml3','delete','connection','own','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001y9nszd8o71cwi','delete','connection','site','',1741660049066,1741660049066);
INSERT INTO Permission VALUES('cm83vfanf001z9nszgjhes867','delete','connection','any','',1741660049066,1741660049066);

INSERT INTO Role VALUES('cm83vfanl00219nsz2s95csi8','super-admin','',1741660049074,1741660049074);
INSERT INTO Role VALUES('cm83vfano00229nsz9uu6bvqt','admin','',1741660049076,1741660049076);
INSERT INTO Role VALUES('cm83vfanq00239nsz2ipb6ozn','user','',1741660049079,1741660049079);

INSERT INTO _RolePermissions VALUES('cm83vfane00029nszunzehh89','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00059nszlj1jb70m','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00089nszro9arnqk','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000b9nszvwp9qzz5','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000e9nszsmaznlf3','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000h9nszoehewoqv','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000k9nsz39hvebmj','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000n9nszaf5g44c7','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000q9nszuvx1rx7q','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000t9nszlb6g170b','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000w9nszes14bdrq','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane000z9nsz1undl1tp','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00129nszjrishwz3','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00159nsz8zn0m9t6','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00189nsz1myg7xp8','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane001b9nszns5ibgpg','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane001e9nszgnhol6gp','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane001h9nszjaluqhvv','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane001k9nszpz55ttfn','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfanf001n9nsz3kykav2h','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfanf001q9nszrfcxa0ck','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfanf001t9nszg5ulloya','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfanf001w9nsz3w18e6mu','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfanf001z9nszgjhes867','cm83vfanl00219nsz2s95csi8');
INSERT INTO _RolePermissions VALUES('cm83vfane00019nszdykqhncn','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00049nsz4324533e','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00079nsz5c881d9m','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000a9nszkux4qy2t','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000d9nszphevc4p3','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000g9nszb6rtzdhj','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000j9nszedo93kk0','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000m9nszd6rn225v','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000p9nsz8h4lbua1','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000s9nszxajis7cu','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000v9nszd2z23br5','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane000y9nszmiz9oobd','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00119nszlshrv13k','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00149nsz65brgr02','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00179nsz1a191sqh','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane001a9nszstqy1y8h','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane001d9nszymjn0niz','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane001g9nszn6nd1kya','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane001j9nsz76xeavhu','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane001m9nszx645xrnk','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfanf001p9nszpa0mu8ym','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfanf001s9nsz3zctmngz','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfanf001v9nsz9xor8eo2','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfanf001y9nszd8o71cwi','cm83vfano00229nsz9uu6bvqt');
INSERT INTO _RolePermissions VALUES('cm83vfane00009nszybczy0t1','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00039nszvtdd8jv7','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00069nszzowfy1qy','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00099nsz7jmdlf9o','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000c9nszsrvc2xdm','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000f9nsz6s6i1trj','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000i9nszp1mu3ee4','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000l9nszw2fa1b04','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000o9nszdf6lzc1l','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000r9nszg01pu2og','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000u9nsz8g8u0mpa','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane000x9nszhffenynq','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00109nszo2f0r62n','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00139nsz90qvk56t','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00169nsz6bylp4x2','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane00199nszytzpebfa','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane001c9nszrmjm250b','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane001f9nszsy11xwqp','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane001i9nszd77ij24d','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfane001l9nsztmkhu9fg','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfanf001o9nsz0c76sr5e','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfanf001r9nszbznu90qy','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfanf001u9nszv3lh5ddy','cm83vfanq00239nsz2ipb6ozn');
INSERT INTO _RolePermissions VALUES('cm83vfanf001x9nszh39lqml3','cm83vfanq00239nsz2ipb6ozn');

INSERT INTO _RoleSites VALUES('cm83vfano00229nsz9uu6bvqt','cm83vfanj00209nszj2wcfi28');
INSERT INTO _RoleSites VALUES('cm83vfanq00239nsz2ipb6ozn','cm83vfanj00209nszj2wcfi28');
