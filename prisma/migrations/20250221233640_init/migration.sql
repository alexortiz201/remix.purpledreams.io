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
CREATE TABLE "_PermissionToRole" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_PermissionToRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Permission" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_PermissionToRole_B_fkey" FOREIGN KEY ("B") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_RoleToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL,
    CONSTRAINT "_RoleToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "Role" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_RoleToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
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
CREATE UNIQUE INDEX "_PermissionToRole_AB_unique" ON "_PermissionToRole"("A", "B");

-- CreateIndex
CREATE INDEX "_PermissionToRole_B_index" ON "_PermissionToRole"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_RoleToUser_AB_unique" ON "_RoleToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_RoleToUser_B_index" ON "_RoleToUser"("B");

--------------------------------- Manual Seeding --------------------------
-- Hey there, Kent here! This is how you can reliably seed your database with
-- some data. You edit the migration.sql file and that will handle it for you.

-- The user Roles and Permissions are seeded here.
-- If you'd like to customise roles and permissions, you can edit and add the code below to your `prisma/seed.ts` file.
-- Seed your development database with `npx prisma db seed`
-- Create a sql dump of your database with `sqlite3 prisma/data.db .dump > seed.sql`
-- Replace the SQL below with your new Roles & Permissions related SQL from `seed.sql`

-- console.time('🔑 Created permissions...')
-- const entities = ['user', 'note']
-- const actions = ['create', 'read', 'update', 'delete']
-- const accesses = ['own', 'any'] as const

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
-- 		name: 'admin',
-- 		permissions: {
-- 			connect: await prisma.permission.findMany({
-- 				select: { id: true },
-- 				where: { access: 'any' },
-- 			}),
-- 		},
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
-- 	},
-- })
-- console.timeEnd('👑 Created roles...')

INSERT INTO Permission VALUES('cm83ozy5y00009ng70sw6sh2b','create','user','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00019ng7mk44g4rp','create','user','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00029ng7v0szi6o9','create','user','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00039ng72ssyt8m9','read','user','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00049ng7wc9xfpha','read','user','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00059ng78kvw3uwm','read','user','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00069ng7l7dyebmu','update','user','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00079ng7d80mi4bf','update','user','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00089ng71g3qikhr','update','user','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y00099ng77rfho9fj','delete','user','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000a9ng7237ska8p','delete','user','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000b9ng7dff8nlid','delete','user','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000c9ng7zsc3g2rf','create','note','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000d9ng7ezlqhgpi','create','note','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000e9ng7m0jjwnjr','create','note','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000f9ng7ghmm26tu','read','note','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000g9ng7l2kt3p30','read','note','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000h9ng7wa52mupw','read','note','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000i9ng7s5fbaw0a','update','note','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000j9ng7u7i0qax3','update','note','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000k9ng786v1122m','update','note','any','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000l9ng70tm8p98e','delete','note','own','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000m9ng75r7x9huq','delete','note','site','',1741649255350,1741649255350);
INSERT INTO Permission VALUES('cm83ozy5y000n9ng75894e4j7','delete','note','any','',1741649255350,1741649255350);

INSERT INTO Role VALUES('cm83ozy64000p9ng7tbvt9ixt','super-admin','',1741649255356,1741649255356,'cm83ozy62000o9ng7dlk25oid');
INSERT INTO Role VALUES('cm83ozy66000q9ng7f9gofxtg','admin','',1741649255358,1741649255358,'cm83ozy62000o9ng7dlk25oid');
INSERT INTO Role VALUES('cm83ozy67000r9ng7wkobzngl','user','',1741649255359,1741649255359,'cm83ozy62000o9ng7dlk25oid');

INSERT INTO _PermissionToRole VALUES('cm83ozy5y00029ng7v0szi6o9','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00059ng78kvw3uwm','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00089ng71g3qikhr','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000b9ng7dff8nlid','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000e9ng7m0jjwnjr','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000h9ng7wa52mupw','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000k9ng786v1122m','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000n9ng75894e4j7','cm83ozy64000p9ng7tbvt9ixt');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00019ng7mk44g4rp','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00049ng7wc9xfpha','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00079ng7d80mi4bf','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000a9ng7237ska8p','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000d9ng7ezlqhgpi','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000g9ng7l2kt3p30','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000j9ng7u7i0qax3','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000m9ng75r7x9huq','cm83ozy66000q9ng7f9gofxtg');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00009ng70sw6sh2b','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00039ng72ssyt8m9','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00069ng7l7dyebmu','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y00099ng77rfho9fj','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000c9ng7zsc3g2rf','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000f9ng7ghmm26tu','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000i9ng7s5fbaw0a','cm83ozy67000r9ng7wkobzngl');
INSERT INTO _PermissionToRole VALUES('cm83ozy5y000l9ng70tm8p98e','cm83ozy67000r9ng7wkobzngl');

INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozy8n000s9ng71hwxtnl1');
INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozyao00199ng7qlbls1ze');
INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozycl001q9ng7orxjnhuf');
INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozyeh00219ng737urvmgm');
INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozygf002k9ng7rg6bo81y');
INSERT INTO _RoleToUser VALUES('cm83ozy64000p9ng7tbvt9ixt','cm83ozyie002r9ng73uqgdnd1');
INSERT INTO _RoleToUser VALUES('cm83ozy66000q9ng7f9gofxtg','cm83ozyie002r9ng73uqgdnd1');
INSERT INTO _RoleToUser VALUES('cm83ozy67000r9ng7wkobzngl','cm83ozyie002r9ng73uqgdnd1');
