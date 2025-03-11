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

INSERT INTO Permission VALUES('cm83ts0sq00009nlcq3nvj4oa','create','user','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00019nlcbfbtmhzp','create','user','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00029nlcz4povtg8','create','user','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00039nlcibuza0bn','read','user','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00049nlcueef8qpj','read','user','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00059nlc9ihccyga','read','user','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00069nlcggxsdlhk','update','user','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00079nlci8jj1l7f','update','user','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00089nlc52zzquvs','update','user','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq00099nlcupz7q76z','delete','user','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000a9nlc94tz1eid','delete','user','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000b9nlcmon7uzjy','delete','user','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000c9nlceybmoxe8','create','note','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000d9nlcqvoepxth','create','note','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000e9nlcc35clta6','create','note','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000f9nlcng9m8mgj','read','note','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000g9nlczndp1npa','read','note','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000h9nlc5eqbc0v1','read','note','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000i9nlcy3z7qxnb','update','note','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000j9nlccrv77q3n','update','note','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000k9nlc15pm7fko','update','note','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000l9nlcdmr67fji','delete','note','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000m9nlc9s3bcntv','delete','note','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000n9nlcau2f9ld5','delete','note','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000o9nlcjolg7xoc','create','site','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000p9nlc5jfj1wvo','create','site','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sq000q9nlcbd99mbcl','create','site','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000r9nlcuk2axpaw','read','site','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000s9nlc64weav9b','read','site','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000t9nlcwvrd1uer','read','site','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000u9nlcn9tbwc1f','update','site','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000v9nlc6lk8vjt6','update','site','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000w9nlcrtw9j6n2','update','site','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000x9nlcxosbgdiu','delete','site','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000y9nlcgmjyaspe','delete','site','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr000z9nlcvs36dpyk','delete','site','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00109nlcjgj1dtzv','create','role','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00119nlcy3eep8l1','create','role','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00129nlcde9r49j2','create','role','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00139nlc8y5v6gc9','read','role','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00149nlc0c27l2cp','read','role','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00159nlcuy185lso','read','role','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00169nlcwggom0s8','update','role','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00179nlckmemzgrq','update','role','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00189nlc6t77ekhk','update','role','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr00199nlcqa3ews9f','delete','role','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001a9nlcwa6z1bys','delete','role','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001b9nlcfvrmu9ik','delete','role','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001c9nlcbcvcltmo','create','permission','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001d9nlct83y3v6b','create','permission','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001e9nlcl4m2hdui','create','permission','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001f9nlc9cyuikrr','read','permission','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001g9nlcqdsaf4d9','read','permission','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001h9nlcpoq5288b','read','permission','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001i9nlc2cduhfkf','update','permission','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001j9nlcre4bgoas','update','permission','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001k9nlcpcsvqbsi','update','permission','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001l9nlcsn7tygsg','delete','permission','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001m9nlcpm7qnyei','delete','permission','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001n9nlcxapr318x','delete','permission','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001o9nlcw6nbspen','create','connection','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001p9nlcabpjvdz6','create','connection','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001q9nlca0eygveo','create','connection','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001r9nlcpwndonn5','read','connection','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001s9nlcj8n0l557','read','connection','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001t9nlcr51bfzz4','read','connection','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001u9nlcew77mrsn','update','connection','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001v9nlcch1evzju','update','connection','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001w9nlcvc2foh7d','update','connection','any','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001x9nlcv76ormtb','delete','connection','own','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001y9nlc3wjsclto','delete','connection','site','',1741657283594,1741657283594);
INSERT INTO Permission VALUES('cm83ts0sr001z9nlcb3d37mw2','delete','connection','any','',1741657283594,1741657283594);

INSERT INTO Role VALUES('cm83ts0sx00219nlcnbg9e9ke','super-admin','',1741657283601,1741657283601);
INSERT INTO Role VALUES('cm83ts0sy00229nlcji3k5m36','admin','',1741657283603,1741657283603);
INSERT INTO Role VALUES('cm83ts0t000239nlc495ae9uj','user','',1741657283604,1741657283604);

INSERT INTO _RolePermissions VALUES('cm83ts0sq00029nlcz4povtg8','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00059nlc9ihccyga','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00089nlc52zzquvs','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000b9nlcmon7uzjy','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000e9nlcc35clta6','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000h9nlc5eqbc0v1','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000k9nlc15pm7fko','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000n9nlcau2f9ld5','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000q9nlcbd99mbcl','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000t9nlcwvrd1uer','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000w9nlcrtw9j6n2','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000z9nlcvs36dpyk','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00129nlcde9r49j2','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00159nlcuy185lso','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00189nlc6t77ekhk','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001b9nlcfvrmu9ik','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001e9nlcl4m2hdui','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001h9nlcpoq5288b','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001k9nlcpcsvqbsi','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001n9nlcxapr318x','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001q9nlca0eygveo','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001t9nlcr51bfzz4','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001w9nlcvc2foh7d','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001z9nlcb3d37mw2','cm83ts0sx00219nlcnbg9e9ke');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00019nlcbfbtmhzp','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00049nlcueef8qpj','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00079nlci8jj1l7f','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000a9nlc94tz1eid','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000d9nlcqvoepxth','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000g9nlczndp1npa','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000j9nlccrv77q3n','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000m9nlc9s3bcntv','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000p9nlc5jfj1wvo','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000s9nlc64weav9b','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000v9nlc6lk8vjt6','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000y9nlcgmjyaspe','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00119nlcy3eep8l1','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00149nlc0c27l2cp','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00179nlckmemzgrq','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001a9nlcwa6z1bys','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001d9nlct83y3v6b','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001g9nlcqdsaf4d9','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001j9nlcre4bgoas','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001m9nlcpm7qnyei','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001p9nlcabpjvdz6','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001s9nlcj8n0l557','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001v9nlcch1evzju','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001y9nlc3wjsclto','cm83ts0sy00229nlcji3k5m36');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00009nlcq3nvj4oa','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00039nlcibuza0bn','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00069nlcggxsdlhk','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq00099nlcupz7q76z','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000c9nlceybmoxe8','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000f9nlcng9m8mgj','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000i9nlcy3z7qxnb','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000l9nlcdmr67fji','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sq000o9nlcjolg7xoc','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000r9nlcuk2axpaw','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000u9nlcn9tbwc1f','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr000x9nlcxosbgdiu','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00109nlcjgj1dtzv','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00139nlc8y5v6gc9','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00169nlcwggom0s8','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr00199nlcqa3ews9f','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001c9nlcbcvcltmo','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001f9nlc9cyuikrr','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001i9nlc2cduhfkf','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001l9nlcsn7tygsg','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001o9nlcw6nbspen','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001r9nlcpwndonn5','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001u9nlcew77mrsn','cm83ts0t000239nlc495ae9uj');
INSERT INTO _RolePermissions VALUES('cm83ts0sr001x9nlcv76ormtb','cm83ts0t000239nlc495ae9uj');

INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts0vf00249nlc8i1jhtya');
INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts0xc002j9nlchxbqqwvc');
INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts0z800309nlcyynsc1hg');
INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts115003l9nlce06rdvyo');
INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts131003u9nlcloky3td7');
INSERT INTO _UserRoles VALUES('cm83ts0sx00219nlcnbg9e9ke','cm83ts151004h9nlckw16m7u5');
INSERT INTO _UserRoles VALUES('cm83ts0sy00229nlcji3k5m36','cm83ts151004h9nlckw16m7u5');
INSERT INTO _UserRoles VALUES('cm83ts0t000239nlc495ae9uj','cm83ts151004h9nlckw16m7u5');

INSERT INTO _RoleSites VALUES('cm83ts0sy00229nlcji3k5m36','cm83ts0sv00209nlcvraxy52k');
INSERT INTO _RoleSites VALUES('cm83ts0t000239nlc495ae9uj','cm83ts0sv00209nlcvraxy52k');

INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts0vf00249nlc8i1jhtya');
INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts0xc002j9nlchxbqqwvc');
INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts0z800309nlcyynsc1hg');
INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts115003l9nlce06rdvyo');
INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts131003u9nlcloky3td7');
INSERT INTO _UserSites VALUES('cm83ts0sv00209nlcvraxy52k','cm83ts151004h9nlckw16m7u5');