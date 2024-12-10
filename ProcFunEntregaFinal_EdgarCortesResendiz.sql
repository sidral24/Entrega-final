------------------------------------
-- EDGAR CORTES RESENDIZ --
------------------------------------

CREATE OR REPLACE FUNCTION alterar_inventarios(
	_id_mp NUMERIC, 
    _cantidad_mp NUMERIC, 
    _id_dulce NUMERIC, 
    _cantidad_dulce NUMERIC
)
RETURNS boolean
AS $$
DECLARE
	existencia_mp INTEGER;
    inventario_dulce INTEGER;
BEGIN
	-- Disminucion de Inventario Materias Primas
	    -- Validar existencia suficiente de materia prima
		SELECT existencia INTO existencia_mp
	    FROM materias_primas
	    WHERE id_mp = _id_mp;
		
	    IF existencia_mp IS NULL THEN
	        RAISE EXCEPTION 'No se encontro la Materia Prima con el ID: %', _id_mp;
			RETURN FALSE;
	    ELSIF existencia_mp < _cantidad_mp THEN
	        RAISE EXCEPTION 'No hay sufienciente Materia Prima, Existencia: %', existencia_mp;
			RETURN FALSE;
	    END IF;

		-- Reducir inventario de materia prima
	    UPDATE materias_primas
	    SET existencia = existencia - _cantidad_mp
	    WHERE id_mp = _id_mp;

		
	-- Aumento Inventario de Dulces
		SELECT stock INTO inventario_dulce
		FROM dulces
		WHERE id_dulce = _id_dulce;

		IF inventario_dulce IS NULL THEN
	        RAISE EXCEPTION 'No se encontro Dulce con el ID %.', _id_dulce;
			RETURN FALSE;
	    END IF;

		UPDATE dulces 
		SET stock = stock + _cantidad_dulce
		WHERE id_dulce = _id_dulce;

	-- Todo Correcto
	RETURN TRUE; 
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE sp_registro_elaboracion(
    _id_fabrica NUMERIC, 
	_id_trabajador NUMERIC, 
	_id_mp NUMERIC, 
	_id_dulce NUMERIC,
    _cantidad NUMERIC
)
AS $$
DECLARE
	_elaboracion_id INTEGER;
BEGIN

	-- Verificar que si existan los registros con esa ID
	IF EXISTS (SELECT 1 FROM fabricas WHERE id_fabrica=_id_fabrica) THEN
		IF EXISTS (SELECT 1 FROM trabajadores WHERE id_trabajador=_id_trabajador) THEN
			IF EXISTS (SELECT 1 FROM materias_primas WHERE id_mp=_id_mp) THEN
				IF EXISTS (SELECT 1 FROM dulces WHERE id_dulce=_id_dulce) THEN

				-- Se busca el ultimo registro de elaboració para poder asignarle un id
			        SELECT MAX (id_elaboracion)+1 INTO _elaboracion_id FROM elaboracion;
					
				-- Se inserta el registro con los nuevos datos
			        INSERT INTO elaboracion (id_elaboracion,id_fabrica, id_trabajador, id_mp, id_dulce, cantidad)
			        VALUES (_elaboracion_id,_id_fabrica, _id_trabajador, _id_mp, _id_dulce, _cantidad);
					
				ELSE
					RAISE EXCEPTION 'No se encontro la Dulce con el ID: %', _id_dulce;
		    	END IF;
				
			ELSE
				RAISE EXCEPTION 'No se encontro la Materia Prima con el ID: %', _id_mp;
			END IF;
			
		ELSE 
			RAISE EXCEPTION 'No se encontro la Trabajadores con el ID: %', _id_trabajador;
		END IF;
		
	ELSE
		RAISE EXCEPTION 'No se encontro la Fabrica con el ID: %', _id_fabrica;
	END IF;
	
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE sp_proceso_completo(
	_id_fabrica NUMERIC,
	_id_trabajador NUMERIC,
    _id_mp NUMERIC, 
	_id_dulce NUMERIC,
	_cantidad NUMERIC,
    _cantidad_mp NUMERIC,  
    _cantidad_dulce NUMERIC
)
AS $$
DECLARE
    
BEGIN

	-- Llamar a la función para registrar o crear elaboración
    CALL sp_registro_elaboracion(_id_fabrica , _id_trabajador , _id_mp , _id_dulce ,_cantidad );

    -- Llamar a la función de modificación de inventario (materia prima y dulces)
	PERFORM alterar_inventarios(_id_mp, _cantidad_mp, _id_dulce, _cantidad_dulce);

END;
$$ LANGUAGE plpgsql;

SELECT * FROM materias_primas;
SELECT * FROM dulces;
SELECT * FROM elaboracion;

CALL sp_proceso_completo(1,1,1,1,20,30,10);