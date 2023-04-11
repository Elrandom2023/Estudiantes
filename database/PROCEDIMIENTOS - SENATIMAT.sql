USE senatimat;

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_listar()
BEGIN
	SELECT est.idestudiante,
		est.apellidos, est.nombres,est.tipodocumento, est.nrodocumento,
		est.fechanacimiento,esc.escuela,
		car.carrera,
		sed.sede,
		est.fotografia
	FROM estudiantes est
	INNER JOIN carreras car ON car.idcarrera = est.idcarrera
	INNER JOIN sedes sed 	ON sed.idsede = est.idsede
	INNER JOIN escuelas esc ON esc.idescuela = car.idescuela
	WHERE est.estado ='1';
END $$

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_registrar
(
	IN _apellidos		VARCHAR(40),
	IN _nombres			VARCHAR(40),
	IN _tipodocumento	CHAR(1),
	IN _nrodocumento	CHAR(8),
	IN _fechanacimiento	DATE,
	IN _idcarrera			INT,
	IN _idsede				INT,
	IN _fotografia			VARCHAR(100)
)
BEGIN
	-- Validar el contenido de _fotografia
	IF _fotografia = '' THEN 
		SET _fotografia = NULL;
	END IF;
	
	INSERT INTO estudiantes
	(apellidos, nombres, tipodocumento, nrodocumento, fechanacimiento, idcarrera, idsede, fotografia) VALUES
	(_apellidos, _nombres, _tipodocumento, _nrodocumento, _fechanacimiento, _idcarrera, _idsede, _fotografia);
END $$

CALL spu_estudiantes_registrar('Villegas Salazar', 'Luis', 'D', '12345678', '2003-09-26', 5, 1, '')
CALL spu_estudiantes_registrar('Castillo Guerra', 'Carlos', 'C', '456789123', '1989-06-12', 3, 2, '')
SELECT * FROM estudiantes

DELIMITER $$
CREATE PROCEDURE spu_estudiantes_eliminar()
BEGIN
END $$








DELIMITER $$
CREATE PROCEDURE spu_sedes_listar()
BEGIN
	SELECT * FROM sedes ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_escuelas_listar()
BEGIN
	SELECT * FROM escuelas ORDER BY 2;
END $$

DELIMITER $$
CREATE PROCEDURE spu_carreras_listar(IN _idescuela INT)
BEGIN
	SELECT idcarrera, carrera
	FROM carreras
	WHERE idescuela = _idescuela;
END $$

CALL spu_carreras_listar(1)
