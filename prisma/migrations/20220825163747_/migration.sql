-- CreateTable
CREATE TABLE `Personas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `apellido_p` VARCHAR(191) NOT NULL,
    `apellido_m` VARCHAR(191) NULL,
    `tipo_sanguineo` ENUM('O', 'A', 'B', 'AB') NOT NULL,
    `ci` VARCHAR(50) NULL,
    `telefono` VARCHAR(20) NULL,
    `direccion` TEXT NULL,
    `fecha_nacimiento` DATETIME(3) NULL,
    `ciudad` ENUM('LaPaz', 'Cochabamba', 'SantaCruz', 'Oruro', 'Sucre', 'Potosi', 'Tarija', 'Pando', 'Beni') NULL,
    `eliminado` DATETIME(3) NULL,
    `creado_en` DATETIME(3) NULL,
    `actualizado_en` DATETIME(3) NULL,

    UNIQUE INDEX `Personas_ci_key`(`ci`),
    UNIQUE INDEX `Personas_telefono_key`(`telefono`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Usuarios` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `personaId` INTEGER NOT NULL,
    `usuario` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `nivel` ENUM('Administrador', 'Medico', 'Secretario', 'Paciente') NOT NULL,
    `estado` TINYINT NOT NULL,
    `creado_en` DATETIME(3) NULL,
    `foto` VARCHAR(191) NULL,
    `correo` VARCHAR(191) NOT NULL,
    `correoVerificado` DATETIME(3) NULL,

    UNIQUE INDEX `Usuarios_personaId_key`(`personaId`),
    UNIQUE INDEX `Usuarios_usuario_key`(`usuario`),
    UNIQUE INDEX `Usuarios_correo_key`(`correo`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Parientes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `relacion` ENUM('Padre', 'Hijo') NOT NULL,
    `personaId` INTEGER NOT NULL,
    `parienteId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Citas` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pacienteId` INTEGER NOT NULL,
    `secretariaId` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL,
    `motivo` TEXT NOT NULL,
    `estado` TINYINT NOT NULL,
    `creado_en` DATETIME(3) NULL,
    `actualizado_en` DATETIME(3) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Sedes` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `direccion` TEXT NOT NULL,
    `telefono` VARCHAR(191) NOT NULL,
    `ciudad` ENUM('LaPaz', 'Cochabamba', 'SantaCruz', 'Oruro', 'Sucre', 'Potosi', 'Tarija', 'Pando', 'Beni') NOT NULL,
    `creado_en` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Sedes_nombre_key`(`nombre`),
    UNIQUE INDEX `Sedes_telefono_key`(`telefono`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Historial` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pacienteId` INTEGER NOT NULL,
    `medicoId` INTEGER NOT NULL,
    `fecha` DATETIME(3) NOT NULL,
    `detalles` TEXT NOT NULL,
    `creado_en` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `actualizado_en` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Enfermedad` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `patologia` ENUM('Anatomica', 'Citologica', 'Dermica', 'Histologica', 'Neurologica', 'Pulmonaria', 'Renal', 'Urologica', 'Hematologica') NOT NULL,
    `detalle` TEXT NOT NULL,

    UNIQUE INDEX `Enfermedad_nombre_key`(`nombre`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Diagnosticos` (
    `enfermedadId` INTEGER NOT NULL,
    `historialId` INTEGER NOT NULL,

    UNIQUE INDEX `Diagnosticos_enfermedadId_historialId_key`(`enfermedadId`, `historialId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Usuarios` ADD CONSTRAINT `Usuarios_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `Personas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Parientes` ADD CONSTRAINT `Parientes_personaId_fkey` FOREIGN KEY (`personaId`) REFERENCES `Personas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Parientes` ADD CONSTRAINT `Parientes_parienteId_fkey` FOREIGN KEY (`parienteId`) REFERENCES `Personas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Citas` ADD CONSTRAINT `Citas_pacienteId_fkey` FOREIGN KEY (`pacienteId`) REFERENCES `Personas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Citas` ADD CONSTRAINT `Citas_secretariaId_fkey` FOREIGN KEY (`secretariaId`) REFERENCES `Usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Historial` ADD CONSTRAINT `Historial_pacienteId_fkey` FOREIGN KEY (`pacienteId`) REFERENCES `Personas`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Historial` ADD CONSTRAINT `Historial_medicoId_fkey` FOREIGN KEY (`medicoId`) REFERENCES `Usuarios`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Diagnosticos` ADD CONSTRAINT `Diagnosticos_enfermedadId_fkey` FOREIGN KEY (`enfermedadId`) REFERENCES `Enfermedad`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Diagnosticos` ADD CONSTRAINT `Diagnosticos_historialId_fkey` FOREIGN KEY (`historialId`) REFERENCES `Historial`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
