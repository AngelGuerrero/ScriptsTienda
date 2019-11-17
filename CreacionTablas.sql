USE `tienda`;

-- Creación de la tabla para el cliente
CREATE TABLE IF NOT EXISTS `Cliente` (
  `IdCliente` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50),
  `Apellido1` VARCHAR(50),
  `Apellido2` VARCHAR(50),
  `RFC` VARCHAR(50),
  
  PRIMARY KEY `pk_IdCliente`(`IdCliente`)
) ENGINE = InnoDB;


-- Creación de la tabla para el inventario
CREATE TABLE IF NOT EXISTS `Inventario` (
  `IdProducto` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50),
  `Descripcion` VARCHAR(50),
  `PrecioVenta` DOUBLE,
  `Stock` BOOLEAN,
  
  PRIMARY KEY `pk_IdProducto`(`IdProducto`)
) ENGINE = InnoDB;


-- Creación de la tabla para Venta
CREATE TABLE IF NOT EXISTS `Venta` (
  `IdVenta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Fecha` DATE,
  IdCliente INT UNSIGNED NOT NULL,

  PRIMARY KEY `pk_IdVenta`(`IdVenta`),

  FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
) ENGINE = InnoDB;


-- Creación  de la tabla para el Proveedor
CREATE TABLE IF NOT EXISTS `Proveedor` (
  `IdProveedor` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(50),
  `Calle` VARCHAR(50),
  `Numero` VARCHAR(50),
  `Colonia` VARCHAR(50),
  `CodigoPostal` VARCHAR(50),
  `RFC` VARCHAR(50),
  
  PRIMARY KEY `pk_IdProveedor`(`IdProveedor`)
) ENGINE = InnoDB;


-- Creación de la tabla de Venta-Inventario
CREATE TABLE IF NOT EXISTS `VentaInventario` (
  `Cantidad` INT NOT NULL,
  `PrecioVentaUnitario` DOUBLE NOT NULL,
  `IdVenta` INT UNSIGNED NOT NULL,
  `IdProducto` INT UNSIGNED NOT NULL,

  FOREIGN KEY (IdVenta) REFERENCES Venta(IdVenta),
  FOREIGN KEY (IdProducto) REFERENCES Inventario(IdProducto)
) ENGINE = InnoDB;


-- Creción de la tabla para la compra
CREATE TABLE IF NOT EXISTS `Compra` (
  `IdCompra` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdProveedor` INT UNSIGNED NOT NULL,

  PRIMARY KEY `pk_IdCompra`(`IdCompra`),

  FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
) ENGINE = InnoDB;


-- Creación de la tabla para CompraInventario
CREATE TABLE IF NOT EXISTS `CompraInventario` (
  `IdCompra` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `IdProducto` INT UNSIGNED NOT NULL,
  `Cantidad` INT NOT NULL,
  `PrecioUnitario` DOUBLE NOT NULL,

  FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra),
  FOREIGN KEY (IdProducto) REFERENCES Inventario(IdProducto)
) ENGINE = InnoDB;

-- MUESTRA LAS TABLAS DE LA BASE DE DATOS
SHOW TABLES;