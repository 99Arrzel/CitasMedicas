/*
  Warnings:

  - Added the required column `sedeId` to the `Historial` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Historial` ADD COLUMN `sedeId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Historial` ADD CONSTRAINT `Historial_sedeId_fkey` FOREIGN KEY (`sedeId`) REFERENCES `Sedes`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
