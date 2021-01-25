-- Tabla categoría
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
	idcategoria int(11) NOT NULL AUTO_INCREMENT,
	nombre varchar(50) not null unique,
	descripcion varchar(255) null,
	estado bit(1),
	PRIMARY KEY (idcategoria)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Tabla artículo
DROP TABLE IF EXISTS `articulo`;
CREATE TABLE IF NOT EXISTS `articulo` (
	idarticulo int(11) NOT NULL AUTO_INCREMENT,
	idcategoria int(11) not null,
	codigo varchar(50) null,
	nombre varchar(100) not null unique,
	precio_venta decimal(11,2) not null,
	stock integer not null,
	descripcion varchar(255) null,
	imagen varchar(20) null,
	estado bit(1),
	PRIMARY KEY (idarticulo)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Filtros para la tabla `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fkartcat` FOREIGN KEY (idcategoria) REFERENCES `categoria` (idcategoria) ON DELETE CASCADE;

-- Tabla Persona
DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
	idpersona int(11) NOT NULL AUTO_INCREMENT,
	tipo_persona varchar(20) not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) null,
	PRIMARY KEY (idpersona)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Tabla rol
DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
	idrol int(11) NOT NULL AUTO_INCREMENT,
	nombre varchar(30) not null,
	descripcion varchar(255) null,
	estado bit(1),
	PRIMARY KEY (idrol)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Tabla usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
	idusuario int(11) NOT NULL AUTO_INCREMENT,
	idrol int(11) not null,
	nombre varchar(100) not null,
	tipo_documento varchar(20) null,
	num_documento varchar(20) null,
	direccion varchar(70) null,
	telefono varchar(20) null,
	email varchar(50) not null,
	clave varbinary(200) not null,
	estado bit(1),
	PRIMARY KEY (idusuario)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

ALTER TABLE `usuario`
  ADD CONSTRAINT `fkusurol` FOREIGN KEY (idrol) REFERENCES `rol` (idrol) ON DELETE CASCADE;

-- Tabla ingreso
DROP TABLE IF EXISTS `ingreso`;
CREATE TABLE IF NOT EXISTS `ingreso` (
	idingreso int(11) NOT NULL AUTO_INCREMENT,
	idproveedor int(11) not null,
	idusuario int(11) not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
	PRIMARY KEY (idingreso)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

ALTER TABLE `ingreso`
  ADD CONSTRAINT `fkproper` FOREIGN KEY (idproveedor) REFERENCES `persona` (idpersona) ON DELETE CASCADE,
  ADD CONSTRAINT `fkusuing` FOREIGN KEY (idusuario) REFERENCES `usuario` (idusuario) ON DELETE CASCADE;

-- Tabla detalle_ingreso
DROP TABLE IF EXISTS `detalle_ingreso`;
CREATE TABLE IF NOT EXISTS `detalle_ingreso` (
	iddetalle_ingreso int(11) NOT NULL AUTO_INCREMENT,
	idingreso int(11) not null,
	idarticulo int(11) not null,
	cantidad int(11) not null,
	precio decimal(11,2) not null,
	PRIMARY KEY (iddetalle_ingreso)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fkdetinging` FOREIGN KEY (idingreso) REFERENCES `ingreso` (idingreso) ON DELETE CASCADE,
  ADD CONSTRAINT `fkdetingart` FOREIGN KEY (idarticulo) REFERENCES `articulo` (idarticulo) ON DELETE CASCADE;

-- Tabla venta
DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
	idventa int(11) NOT NULL AUTO_INCREMENT,
	idcliente int(11) not null,
	idusuario int(11) not null,
	tipo_comprobante varchar(20) not null,
	serie_comprobante varchar(7) null,
	num_comprobante varchar (10) not null,
	fecha datetime not null,
	impuesto decimal (4,2) not null,
	total decimal (11,2) not null,
	estado varchar(20) not null,
	PRIMARY KEY (idventa)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

ALTER TABLE `venta`
  ADD CONSTRAINT `fkventcli` FOREIGN KEY (idcliente) REFERENCES `persona` (idpersona) ON DELETE CASCADE,
  ADD CONSTRAINT `fkvenusu` FOREIGN KEY (idusuario) REFERENCES `usuario` (idusuario) ON DELETE CASCADE;

-- Tabla detalle_venta
DROP TABLE IF EXISTS `detalle_venta`;
CREATE TABLE IF NOT EXISTS `detalle_venta` (
	iddetalle_venta int(11) NOT NULL AUTO_INCREMENT,
	idventa int(11) not null,
	idarticulo int(11) not null,
	cantidad int(11) not null,
	precio decimal(11,2) not null,
	descuento decimal(11,2) not null,
	PRIMARY KEY (iddetalle_venta)
)ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fkdetvenven` FOREIGN KEY (idventa) REFERENCES `venta` (idventa) ON DELETE CASCADE,
  ADD CONSTRAINT `fkdetvenart` FOREIGN KEY (idarticulo) REFERENCES `articulo` (idarticulo) ON DELETE CASCADE;